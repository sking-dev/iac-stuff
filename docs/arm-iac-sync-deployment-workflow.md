# Workflow to Sync IaC with Live Resources

To ensure that the IaC matches up with what's been deployed to the live environment.

This workflow is based on using Azure CLI to deploy ARM templates.

----

- Run an `az deployment group what-if` referencing the files from the **feature branch**
  - Proceed if all looks OK
- Run an `az deployment group create` referencing the files from the **feature branch**
  - Proceed if successful
- Merge the feature branch to the master branch
- Run an `az deployment group what-if` referencing the files from the **master branch**
  - No changes should be flagged up
    - If `what-if` is not available (e.g. Azure Stack Hub) then (re)deploy referencing the files from the **master branch**
      - No changes should be flagged up
