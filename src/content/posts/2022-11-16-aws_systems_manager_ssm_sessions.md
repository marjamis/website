---
title: AWS Systems Manager (SSM) Sessions
description: The basics of AWS Systems Manager (SSM) Sessions with Linux.
publishedDate: 2022-11-16 18:34:04 +1100
heroImage: "/blog-placeholder-3.jpg"

categories:
  - aws
  - example
---

A common administrative and troubleshooting task is to SSH into an EC2 instance, while this should be done minimally it does make certain adhoc operations easier but one of the hassles of this approach is that you either need to have your instance exposed to the internet, which is generally a no-no, or you need to maintain a bastion to provide access. Here's where AWS Systems Manager (SSM) enters. Through the use of the SSM agent on an instance, you can SSH or run arbitrary commands on the instance without having it exposed to the internet and without the need of a bastion. AWS does the heavy lifting for us of managing public endpoints, the SSM API endpoints, and routing your SSH traffic from your local machine to the instance.

To get this up and running you will need to:

- On the instance:
  - Install the SSM agent on the instance and verify it's connecting to AWS SSM endpoints correctly. Thankfully this is all documented [here](https://docs.aws.amazon.com/systems-manager/latest/userguide/ssm-agent.html)
- Locally you will need to:
  - [Install the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) which will allow you to make AWS API calls
  - [Install session manager plugin for the AWS CLI](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html) which is used to create SSM sessions from your local machine to the instance

## Possible errors during installation

There can be a few issues with the above configurations that can occur, here is a short list of some of the common ones I've found and how to remediate them.

- `SessionManagerPlugin is not found. Please refer to SessionManager Documentation here: <http://docs.aws.amazon.com/console/systems-manager/session-manager-plugin-not-found>`
  - The session manager plugin is either not installed or not in your PATH to be found. An example of how to add it to your current shells PATH env is:

```bash
export PATH=$PATH:/usr/local/sessionmanagerplugin/bin
```

- `An error occurred (TargetNotConnected) when calling the StartSession operation: <instance_id> is not connected.`
  - Basically means the instance is STOPPED, not connecting to the SSM endpoint, or something similar.

---

## How do we use SSM sessions?

Once you've successfully completed the installation and verification steps there are many SSM operations you can perform but the two I want to concentrate on are:

### "SSH"-ing

- **AWS CLI:** This will create an SSH session between your local machine and the specified EC2 instance via the AWS SSM service. Once the session is made you have a normal SSH connection and you can do all the same commands you would as if you used SSH natively.

```bash
aws --region ap-southeast-2 ssm start-session --target <instance id>
```

- **AWS CLI and SSH configurations:** With a basic SSH configuration you can also use your normal ssh command to automatically call the AWS CLI with the session parameters making it even easier to SSH to the instance. A basic local SSH configuration could be:

```bash
cat << EOF > ~/.ssh/config
# SSH over Session Manager
host i-* mi-*
    ProxyCommand sh -c "aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"

EOF

ssh i-abcdefg12345678 # Example instance id
```

### Port Forwarding

- Through the use of the _AWS-StartPortForwardingSessionToRemoteHost_ SSM document you can connect to an instance and port forward via it to a different backend. Let's say there is an internal Load Balancer you want to connect to locally, such as for testing, you can set up a port forwarding session to create a tunnel via an instance, which has networking connectivity, to the internal Load Balancer for local access. An example command is:

```bash
aws ssm start-session --target <instance_with_ssm_agent> --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters '{"portNumber":["<remote_port>"],"localPortNumber":["<local_port>"],"host":["<load_balancer_cname>"]}'
```

- Now that the tunnel is setup you can open your browser to `localhost:<local_port>` and be connected to the host/Load Balancer/etc on the port you've defined in the above parameters.

For even more information you can read this [AWS Blog](https://aws.amazon.com/blogs/aws/new-port-forwarding-using-aws-system-manager-sessions-manager/) and this [documentation](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-getting-started-enable-ssh-connections.html).

---

While I've focused on the SSH'ing and port forwarding functionality of SSM via its session management, you can run a variety of other SSM Documents for general instance management as well, such as patching, or even creating your own custom SSM Documents for bespoke actions.

The power of the SSM agent for instance and session management is vast and I hope these examples help you think up additional ways you could also use SSM.
