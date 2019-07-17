# Purpose:

This project provides a wroking example of a CI/CD pipeline that builds a custom jenkins container.

# Build environment: 

Linux based Jenkins deployments. This pipeline relies on the jenkins LTS version and is manually updated to newer versions. 

# Other information:

Custom plugins are included in the Dockerfiles. The slave images also install docker and kubectl.

# TODO:
- Add in a testing portion for each container.
- Clean up the helm chart information and fix the deployment yaml to reflect a fully constructed k8s yaml.
- Clean repo for only consice files.
- Create installation instructions for fictitious Steve.
