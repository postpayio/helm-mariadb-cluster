# helm-mariadb-cluster

Creates a MariaDB cluster built off the MariaDB cluster operator

# What is this for?

The main requirement for this chart is to group resources for mariadb databases created by the MariaDB Operator for K8s together in ArgoCD.

The problem at the time was that since these resources are all separate resources, they are scattered in the ArgoCD interface and management was difficult. By having a helm chart for them, it means that they can be managed by an Application and nicely grouped together. This is why there is hardly any templating happening in this helm chart.

# MariaDB Cluster Operator

https://github.com/mariadb-operator/mariadb-operator

All the resources created are basically passed onto the operator.
This chart is just to contain the resources in a single deployment file rather than separate resources.

The only value that is templated is the `metadata.name` which takes on the `key` value of your resource type.

# I need help with the values

With a combination of th below example and the examples given by the operator git repo, there shouldn't be anything you can't do.

Repo examples:

Example of this helm chart values.
```yaml
cluster:
  example:
    spec:
      rootPasswordSecretKeyRef:
        name: mariadb-example
        key: root-password

      storage:
        size: 10Gi

      replicas: 3

      # point to an existing MaxScale instance. Doing this will delegate tasks such as primary failover to MaxScale.
      # maxScaleRef:
      #   name: maxscale-repl

      # provision a MaxScale instance and set 'spec.maxScaleRef' automatically.
      maxScale:
        enabled: true
        connection:
          port: 3306
      replication:
        enabled: true

      database:
        example:
          spec:
            mariaDbRef:
              name: example
            characterSet: utf8
            collate: utf8_general_ci
            requeueInterval: 30s
            retryInterval: 5s
grant:
  example:
    spec:
      mariaDbRef:
        name: mariadb
      privileges:
        - "SELECT"
        - "INSERT"
        - "UPDATE"
        # - "ALL PRIVILEGES"
      database: "*"
      table: "*"
      username: app-reader
      grantOption: true
      host: "%"
      requeueInterval: 30s
      retryInterval: 5s
user:
  app-reader:
    spec:
      # If you want the user to be created with a different name than the resource name
      # name: user-custom
      mariaDbRef:
        name: example
      passwordSecretKeyRef:
        name: user-example
        key: password
      # This field is immutable and defaults to 10 after being set.
      maxUserConnections: 20
      host: "%"
      retryInterval: 5s
secret:
  # These should never really be used. Rather create your secrets out of band and add the
  # names of the secrets to the relevant resources.
  user-example:
    stringData:
      password: P4ssword
  mariadb-example:
    stringData:
      root-password: SecretSql
```

# Chart Owner

This chart is owned by the `DevOps` team.

PRs are welcome should you find an issue with this resource.

# Developing

If you want to test the rendered product of this chart you can do the following steps.

1. Create a file called test_values.yaml at the root of this repo.
1. Copy in the example above or create your own example if you are doing something specific.
1. From the root of this repo run `helm template . --name-template mfe-events-cron --namespace mfe-events-api-dev1 --kube-version 1.29 --values ./test_values.yaml --include-crds --debug`
1. This should then output to your terminal the values that are passed into k8s. Use a redirect to get it into a file if needed.