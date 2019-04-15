FROM jenkins/jenkins:2.164.2

# Distributed Builds plugins
RUN /usr/local/bin/install-plugins.sh ssh-slaves

# install Notifications and Publishing plugins
RUN /usr/local/bin/install-plugins.sh email-ext
RUN /usr/local/bin/install-plugins.sh mailer
RUN /usr/local/bin/install-plugins.sh slack

# Artifacts
RUN /usr/local/bin/install-plugins.sh htmlpublisher

#Pipeline install
RUN /usr/local/bin/install-plugins.sh ace-editor ant antisamy-markup-formatter apache-httpcomponents-client-4-api authentication-tokens bouncycastle-api branch-api build-timeout cloudbees-folder command-launcher credentials credentials-binding display-url-api docker-commons docker-workflow durable-task git github github-api github-branch-source gradle handlebars jackson2-api jdk-tool jquery-detached jsch junit ldap lockable-resources mapdb-api matrix-auth matrix-project momentjs pam-auth pipeline-build-step pipeline-github-lib pipeline-graph-analysis pipeline-input-step pipeline-milestone-step pipeline-model-api pipeline-model-declarative-agent pipeline-model-definition pipeline-model-extensions pipeline-rest-api pipeline-stage-step pipeline-stage-tags-metadata pipeline-stage-view plain-credentials resource-disposer scm-api script-security ssh-credentials structs subversion timestamper token-macro workflow-aggregator workflow-api workflow-basic-steps workflow-cps workflow-cps-global-lib workflow-durable-task-step workflow-job workflow-multibranch workflow-scm-step workflow-step-api workflow-support

# Scaling
RUN /usr/local/bin/install-plugins.sh kubernetes

USER jenkins
