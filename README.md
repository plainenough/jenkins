# Purpose:

This project provides a working example of a CI/CD pipeline that builds a custom jenkins container.

# Build environment: 

Linux based Jenkins deployments. This pipeline relies on the jenkins LTS version. 

# Other information:

Custom plugins are included in the Dockerfiles. The slave images also install docker and kubectl.

# Run jenkins container
docker run -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock --name jenkins -t jenkins/jenkins:lts

# TODO:
- Add in a testing portion for each container.
- Clean repo for only consice files.
- Create installation instructions for fictitious Steve.
