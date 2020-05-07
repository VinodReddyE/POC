# How to add GCP_SA_key to GitHub Project secrets.

Without the GCP Service Account (SA) key, you will not be able to build correctly. The
Platform team will help you add this as a 
[github secret](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets).
  
# Secrets in a workflow via Google Secrets manager

See: https://cloud.google.com/secret-manager/docs

We use secrets in the workflow to connect to GCP, Sonarsource (TBA), and 
our [package repository](https://github.com/storebrand-digital/repo/packages).

There is not (yet) any standard way to maintain secrets on the organization level in GitHub.
In order to avoid duplication of secrets, we maintain the secrets in
[Google Secrets Manager](https://console.cloud.google.com/security/secret-manager?project=dbd-shared-all).

From the command line you do:
```
gcloud config configurations activate shared                                                                                                                                                                                     
gcloud config set project dbd-shared-all                                                                                                                                                                                         
gcloud config set compute/zone europe-west4                                                                                                                                                                                       
gcloud config set compute/region europe-west4                                                                                                                                                                                     
gcloud config configurations list                                                                                                                                                                                                 

```
Create secret from either command line or from file:
 
```
echo -n "something secret" | gcloud secrets create DELETE_THIS_TEST_SECRET --replication-policy="automatic" --data-file=-
# or
gcloud secrets create DELETE_THIS_TEST_SECRET  --replication-policy="automatic" --data-file=some_file_with_secrets.txt
```

List all Secrets

```
gcloud secrets list
```

Access a secret:

```
gcloud secrets versions access latest --secret="DELETE_THIS_TEST_SECRET"
```

Delete Secret

```
gcloud secrets delete DELETE_THIS_TEST_SECRET
```

This is integrated in our build flow, as you see here:
 [.github/workflows/build.yml](.github/workflows/build.yml#L54)
          
More information please see: https://github.com/GoogleCloudPlatform/github-actions/tree/master/get-secretmanager-secrets

### Enable permissions to access the Google SecretManager secrets

In order to access GCP secret manager, you need the following access: 
`roles/secretmanager.secretAccessor`

It is not expected that anyone outside the platform team needs to do this.

Provide explicit access policies on the GCP Secret Manager to be able to access your key  
for `get` and `list` operations. Use below command for that:

```
gcloud secrets add-iam-policy-binding GITHUB_PACKAGES_DEPLOY_KEY \
    --member="shared-gke-docker-build-sa@dbd-shared-all.iam.gserviceaccount.com" \
    --role="roles/secretmanager.secretAccessor"
```

For more details, please see section about managing secrets: 
https://cloud.google.com/secret-manager/docs/managing-secrets#managing_access_to_secrets
