## How to set up Github action for my github project

Examine the file [.github/workflows/build.yml](.github/workflows/build.yml). You can
use this file as a starting point for your workflow. Download it, and to something 
similar to:

```
mkdir -p .github/workflows/
mv -i $HOME/Downloads/build.yml .github/workflows/
git add .github
git commit .github -m "Build with github actions"
git push origin/master
```

Github Actions will trigger the build.yaml workflow steps.

# How to Configure  GitHub Packages to Build work flow

We use github packages as repository for maven artifacts. They are put here:
https://github.com/storebrand-digital/repo/packages

For more information, see:https://github.com/storebrand-digital/repo/

### How GitHub Workflow build Event trigger

Triggering on different branches and events, see
 [GitHub Actions Event Triggers](https://help.github.com/en/actions/reference/events-that-trigger-workflows)

