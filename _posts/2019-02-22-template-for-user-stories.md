---
layout:   post
title:    "Template for user stories"
date:     2019-02-22 15:00:00 +0200
tags: 
  - scrum 
  - user story
  - template
featured_article:   true
---
*The scrum methodology does not specify what the contents of a user story should be. This allows each team to find their own format that works for them. In this post I am placing a template that proved its value in past scrum projects. You can use it as inspiration to create your own.*

## Description
This section should make the context of the story clear. The current and desired situation are described so they can be understood by a broad audience.

## Benefit
A list of the business benefits that will be achieved by implementing this user story. It should make clear to the business why this user story is worth their investment.

## Owner / Business representative
This is the person you would go to in case of doubts on the functional and non-functional requirements that pertain to the story. It is also by default the go-to person for the UAT of the user story. State the role and name of the owner.

## Deliverables
A list of artifacts that will be delivered by this user story. All items on this list have to be delivered before the user story can be accepted. Some items on this list are specific to each user stories, while other items will apply to any story. You could see the fixed items on this list as the ```Definition of Done```.
- ...
- Peer review of development work is done
- Test report is ready
- User story is deployed deployed to test and QA environments
- Functional and technical documentation is done
- Deployment plan is updated
- Release notes are ready
- Documentation for support and hand-over (KT session) is done

## Acceptance criteria
A list of requirements that the deliverables must comply to. Only when all deliverables are ready and meet the acceptance criteria can a user story be offered for acceptance by the product owner.

## Definition of Ready
A list of all the criteria that must be met before the work on the deliverables of this user story can start. Some items on this list are specific to each user stories, while other items will apply to any story.
- ... (items specific to the user story)
- User story is stored on the backlog with a title formatted as: ```As <role>, I am able to <functionality>, so that <reason>.```
- User story is refined; assumptions, business process flow and acceptance criteria are documented
- Story points are assigned to the user story
- Dependency of the story is reduced to a minimum in relation to other user stories
- It is validated which business lines/departments are affected
- The architecture guidelines and design for the user story is clear for development team
- The definition of done can be validated/delivered
- In case of integration the data mapping must be specified by both sending and receiving parties and agreed upon by IT
- PO has prioritized and approved the user story

## Solution direction
Depending on the technical complexity of the user story, this section contains either some pointers or a more elaborate description of the details of implementing this user story. If there is a lot of content for this section, it can be put in a separate document attached to the user story in the form of a solution design.

## Test cases / Test plan
A list of test cases that must be performed during the test phase to validate that the implementation complies to the acceptance criteria. If there is a lot of content for this section, it can be put in a separate document attached to the user story in the form of a test plan.
