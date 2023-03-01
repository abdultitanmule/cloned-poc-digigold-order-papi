# mulesoft-template-api
This repository acts as a template that can be used to create Experience, Process, and System APIs with correct branch names. The template can be found on the **DEVELOP branch** so it is expected that the developer to finalize first the refactoring of the template Mule project before creating a Pull-Request (PR) to the default MASTER branch. 

## Notice ALL Mulesoft Developers
This template can be used as basis for starting development work in the APIs (Experience, Process, and System). This template already covers the following configurations:
1. Global Configuration file - global-config.xml
  - This configuration file already has the information for Global Environment, Configuration Properties including Secure Properties
2. Global Error Handler - global-error-handler.xml
  - This configuration file imports common error handler. 
  	 * Reference api-main-error-handler for APIKIT main related flows
  	 * Reference api-console-error-handler for APIKIT console related flows
  	 * Reference global-http-error-handler for HTTP related flows.
  	 * Any project specific (or) specifically handled error scenarios have to be placed here
3. Configuration Properties
4. Default packages for Common, Implementation flows
5. Default Munit XML file is added

## TODO
1. Refactor the name of the project into their specific API to be created including all configuration (keyword: "mulesoft-template-api")
2. Check all instances of the #TODO FOR DEVELOPER and update accordingly
3. Update the README.md appropriately
4. There are instances in which there are folders that are not seen by Github as new/changed so we need to run in the Git console: "git add -f src" in the root of the project
5. Commit and Push all changes to the **DEVELOP** branch

## Best Practices
1. Ensure that flow names, component names, re-using flows/sub flows is handled properly. Follow all the best practices and make sure to be consistent across the application.
2. Ensure that for the DEV up to PROD secured properties configurations, they are CORRECTLY encrypted based on the Environment Security key. Please note that all developers are not permitted to access the PROD security key and only reserved for the leads and up.
3. When running the Mulesoft application locally, you need to supply the following arguments: -Denv=<<environment>> and -Dsecure.key.titan=<<SECURITY KEY>>

## pom.xml
1. Default pom.xml has reference to cloudhub2 deployment. Make sure to override the properties while publishing asset or deploying through mule maven plugin
2. All the dependencies or modules should be pointing to latest versions
3. Artifact ID should always follow the below convention:
  <apiname>-app
