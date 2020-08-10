---
layout: post
title:  "Writing a deployment plan"
date:   2020-08-07 18:00:00 +0200
tags: 
  - deployment plan
  - release management
featured_article: true
---
*How do you create a deployment plan that is accurate and helps your team to have a more stable and trustworthy deployment. This post describes what should be in a deployment plan, so you can rely on it for your production releases.*

## Planning, contact info, communication plan
This is basic stuff and should always be present. This sections answers questions like:
- When is the deployment planned?
- Who does what?
- Who are the stakeholders?
- How to contact people and who is their back-up?
- Who must be informed at what time/situation with what message?


## Pre checks and backups
Make sure your system is in the right state to start the deployment. For example:
- Check that the current version of the system matches what is expected in the plan
- Check that all users have logged out and that the system is not running any processes
- Etc etc

Also this is the moment to run your backups in case you need them later for rollback.
- Back up the database
- Take a snapshot of the file system
- Etc etc


## Installation and configuration actions
This section is the core of the deployment plan and should give precise description of all the steps that must be executed to perform the deployment. Think of:
- Steps to install new configuration
- Manual updates
- Migration actions


## Verification actions
After installing, you should verify as well as you can that the deployment was successful. Since you are working on Production, you cannot assume to be able to run tests, but there are usually other checks you can do to verify the deployment. Think of:
- Checking the user interfaces to see the updated functionality
- Check new tables of data for the correct content
- Check the update times of your configuration
- Etc etc


## Rollback plan
Prepare for the worst, what if after all the preparation the deployment still fails? Typically, this is the moment to restore the backups that you made earlier. Or, if your environment allows it, you can include here the steps to revert changes. 

Make sure to also include a communication plan of whom to inform and when. Trust me, people will want to know.


## Release notes and other documentation
Make sure that any relevant documentation can easily be found from the deployment plan. A typical example are the release notes, as this is often a document that is sent to the stakeholders after a successful deployment.


## Tip
If possible, make sure that the people executing the deployment know the plan beforehand. Ideally, they should have done a dry run of the entire plan on a staging environment to make sure the plan is accurate.