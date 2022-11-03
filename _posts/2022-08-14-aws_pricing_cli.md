---
title: Navigating the AWS Pricing API with the AWS CLI
date: 2022-08-14 21:59:16 +1000
categories:
  - aws
  - example
---

The AWS Pricing API is pretty different from the average AWS API but once I got a handle on what it was doing it makes a lot of sense to be able to get pricing data in this way. Let me break it down a bit using the AWS CLI.

Let's imagine we want the pricing of EKS Clusters in the SYD region, ap-southeast-2. The first bit of information we need to get is what is the service code for the EKS service. The service code being the name used for a service in the pricing API. To get a full list of all the services, and their services codes, you can use the pricing:DescribeServices API call without any flags. This will return a list of all services with their available attributes (more on this a bit later).

Before we go to heavily into the specifics, it's important to know that the pricing API isn't available in every region, it's only available in us-east-1 and ap-south-1, at least at the time of writing. This means all the below API calls will need to be made against one of these regions,  otherwise the calls will fail.

With that out of the way, lets dig in. To start let's get a list of all the services codes and grep out EKS:

```bash
aws pricing describe-services | jq '.Services[].ServiceCode' | grep -i EKS
"AmazonEKS"
```

As mentioned, this doesn't only give us the list of services codes but also gives us a list attributes for each service. The pricing:DescribeServices API call has a service code flag to allow us to only receive attributes for a given service code.

Now that we know the service code for EKS is AmazonEKS we can use this to get the list of AmazonEKS attributes:

```bash
aws pricing describe-services --service-code AmazonEKS
{
    "Services": [
        {
            "ServiceCode": "AmazonEKS",
            "AttributeNames": [
                "productFamily",
                "termType",
                "tenancy",
                "usagetype",
                "locationType",
                "cputype",
                "tiertype",
                "regionCode",
                "servicecode",
                "location",
                "servicename",
                "memorytype",
                "operation"
            ]
        }
    ],
    "FormatVersion": "aws_v1"
}
```

With these attributes we can then find all the possible values for each of these attributes, for example here is a list of some of the available options for AmazonEKS:

```bash
# Returns a list of region names available for EKS
aws pricing get-attribute-values --service-code AmazonEKS --attribute-name location
# Returns a list of region codes available for EKS
aws pricing get-attribute-values --service-code AmazonEKS --attribute-name regionCode
# Returns a list of the types of usage within EKS, currently Fargate vCPU, Fargate Memory, and Cluster (this being what we're after)
aws pricing get-attribute-values --service-code AmazonEKS --attribute-name usageType
```

Now with all this information we can start to get the actual pricing information we really care about using the pricing:GetProducts API call. Using:

```bash
aws pricing get-products --service-code AmazonEKS
```

we will get all the pricing information available for EKS but this is too much irrelevant information for us at the moment and we only want very specific pricing information, being the pricing data for the cost of an EKS cluster in ap-southeast-2. To ensure we only get this information we can apply filters using the attribute names and attribute values from above.

The first filter we will add is for the region, ap-southeast-2. Using the filter flag on the pricing:GetProducts API call we can restrict the returned data to only the region we're after. **Note:** The filter Type is for an exact match of field and value and currently is the only Type supported by the pricing API.

```bash
aws pricing get-products --service-code AmazonEKS --filter Type=TERM_MATCH,Field=regionCode,Value=ap-southeast-2
```

This now restricts all information to pricing in SYD, ap-southeast-2, but we still get details about Fargate pricing when all we want is cluster pricing. So we need to apply another filter. In this case we're after the usage type of APS2-AmazonEKS-Hours:perCluster (unfortunately this values is named in such a way as to be unique per region). Using this we can filter one more time for the exact data we want:

```bash
aws pricing get-products --service-code AmazonEKS --filter Type=TERM_MATCH,Field=regionCode,Value=ap-southeast-2 Type=TERM_MATCH,Field=usageType,Value=APS2-AmazonEKS-Hours:perCluster | jq '.PriceList[] | fromjson'
{
  "product": {
    "productFamily": "Compute",
    "attributes": {
      "tiertype": "HAStandard",
      "regionCode": "ap-southeast-2",
      "servicecode": "AmazonEKS",
      "usagetype": "APS2-AmazonEKS-Hours:perCluster",
      "locationType": "AWS Region",
      "location": "Asia Pacific (Sydney)",
      "servicename": "Amazon Elastic Container Service for Kubernetes",
      "operation": "CreateOperation"
    },
    "sku": "BMJ7KNTWFFFQPFS4"
  },
  "serviceCode": "AmazonEKS",
  "terms": {
    "OnDemand": {
      "BMJ7KNTWFFFQPFS4.JRTCKXETXF": {
        "priceDimensions": {
          "BMJ7KNTWFFFQPFS4.JRTCKXETXF.6YS6EN2CT7": {
            "unit": "Hours",
            "endRange": "Inf",
            "description": "Amazon EKS cluster usage in Asia Pacific (Sydney)",
            "appliesTo": [],
            "rateCode": "BMJ7KNTWFFFQPFS4.JRTCKXETXF.6YS6EN2CT7",
            "beginRange": "0",
            "pricePerUnit": {
              "USD": "0.1000000000"
            }
          }
        },
        "sku": "BMJ7KNTWFFFQPFS4",
        "effectiveDate": "2022-08-01T00:00:00Z",
        "offerTermCode": "JRTCKXETXF",
        "termAttributes": {}
      }
    }
  },
  "version": "20220811195142",
  "publicationDate": "2022-08-11T19:51:42Z"
}
```

This now returns the pricePerUnit (how much it costs in USD), the unit the pricePerUnit is charged at (in this case being per hour), and a whole bunch of other potentially useful information (such as other filterable attributes names and values found under ".product.attributes").

And there we have it, the basics of going from zero to being able to find the cost of running an EKS Cluster in the SYD, ap-southeast-2, region. This same logic can be applied to any of the SDK's and be made even more generic and robust for gathering a larger dataset of pricing data.

I hope this short guide is as useful to others as it has been to myself during my own work in Cost Optimising on AWS.
