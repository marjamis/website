---
title: Navigating the AWS Cost Explorer (GetCostAndUsage) API with the AWS CLI
description: The AWS Cost Explorer API is great for getting information about your AWS spend and what's is causing that spend.
publishedDate: 2023-10-26 13:38:29 +1100
heroImage: "/blog-placeholder-3.jpg"

tags:
  - aws
  - example
---

The AWS Cost Explorer API is great for getting information about your AWS spend and what's is causing that spend. It even lets you group the costs, break it down per account, service, etc. and a variety of other fancy things.

The main options for this API call are:

```
--time-period <value>
--granularity <value>
[--filter <value>]
--metrics <value>
[--group-by <value>]
```

I won't go into details of each too much, as they already well [documented](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ce/get-cost-and-usage.html), but at a high level:

- Time Period: Specify the time range to gather data from
- Granularity: How to breakdown the time period in the data provided, available options are Daily, Hourly, and Monthly
- Metrics: The type of billing data to return. The best breakdown of what's good for you is documented in an [AWS Blog](https://aws.amazon.com/blogs/aws-cloud-financial-management/understanding-your-aws-cost-datasets-a-cheat-sheet/)

The two main more interesting ones are filter and group-by which will refine the data you receive.

- Filter: This provides are really powerful way to restrict the source data that makes up your response. For example, you can filter to specific regions, accounts, services, AZ's, charge types (more on this later).

- GroupBy: How the returned data is grouped, also many options here but the more common groups would be regions, linked accounts, and services.

For example, say I wanted to the total spend for the last 6 months in my account you can run:

There are many ways to use all of the above options and it will take a bit of time to work out what best suits your data pattern but as example to the power of using all of this options here's a query that will:

- Time Period: Get data for the last 3 months
- Granularity: Break it down per day
- Filter: Only to a specific set of linked accounts, as this will be run against a PAYER account, but exclude the Credit Charge type (as we want to know how much we would spend independent of any AWS provided credits)
- Metrics: Return both the Unblended and Amoritised Costs
- Group by Region and then Service

```bash
aws ce get-cost-and-usage \
--time-period Start=2023-03-01,End=2023-09-01 \
--granularity DAILY \
--filter '{"And":[{"Dimensions":{"Key":"LINKED_ACCOUNT","Values":["0123456789012","1234567890123"]}},{"Not":{"Dimensions":{"Key":"RECORD_TYPE","Values":["Credit"]}}}]}' \
--metrics UnblendedCost AmoritisedCost \
--group-by Type=DIMENSION,Key=REGION Type=DIMENSION,Key=SERVICE
```

Keep in mind with the amount of data data is being provided it will likely be paginated, but with the CLI this is just a matter of capturing the next-page-token value and reruning the command with this token. Of course, this is just for demonstartion purposes and would highly suggest using another method than bash if you're getting into this amount of data. Such as with python:

```python
import boto3

client = boto3.client('ce')

response = client.get_cost_and_usage(
    TimePeriod=TimePeriodDetails(
        Start="2023-03-01",
        End="2023-09-01",
    ),
    Granularity="DAILY",
    Metrics=[
        "UnblendedCost",
        "AmoritizedCost",
    ],
    GroupBy=[
        {
            Type="DIMENSION",
            Key="REGION",
        },
        {
            Type="DIMENSION",
            Key="SERVICE",
        }
    ],
    FilterDetails={
        "And": [
            {
                "Dimensions": {
                    "Key": "LINKED_ACCOUNT",
                    "Values": [
                        "0123456789012",
                        "1234567890123",
                    ]
                }
            },
            {
                "Not": {
                    "Dimensions": {
                        "Key": "RECORD_TYPE",
                        "Values": [
                            "Credit",
                        ]
                    }
                }
            }
        ]
    },
)
```
