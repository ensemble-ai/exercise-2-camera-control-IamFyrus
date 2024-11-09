# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Janani Asokumar
* *email:* jasokumar@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Stage one meets all the requirements. The camera follows the target exactly and is always at the centered on the targer. No issues in stage one. The 5x5 cross is also visible and looks correct.
___
### Stage 2 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Stage two meets all the requirements as well. The auto-scroll works has required and the target is also bounded within the box and doesn't affect the speed of the box when it collides with the edge at all. A very minor improvement would have been to make the box a rectangle instead of square so that the screen above and below the box could have been seen. However, this is a stylistic choice.

___
### Stage 3 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Stage three meets all the requirements with the camera trailing behind the target. Once again the behavor works exactly as intended with no glitches and is smooth. A very small note was the usage of export variables. The student used the export variables as intended allowing the values to be changed in the inspector, but they also harded coded the values which wasn't necessary can be omitted.

___
### Stage 4 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [X] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Stage 4 has the basic idea of what is required, however the implementation is incomplete. The target is quite glitchy when the camera focuses ahead of the target. There appear to be 2 targets instead of one clear one. When the camera moves up or down the target once again glitches quite a lot and the behavior is unexplainable. Additionally, the delay catch up duration requirement doesn't work as intended (however, the student did try to implement it). The student left a note saying stage 4 is done, however, on my laptop the stage seems to have a lot of glitches

___
### Stage 5 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [X] Unsatisfactory

___
#### Justification ##### 
Stage 5 is not implemented. There appears to be a box that is auto-scrolling, but the target is nowhere to be found. The student did include a note about this lack of implementation for stage 5 in their github commit messages.
___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####

- [hardset values on export variables](https://github.com/ensemble-ai/exercise-2-camera-control-IamFyrus/blob/08669863d556a6778c5cbda1fe411f812b6e501a/Obscura/scripts/camera_controllers/position_lock_lerp.gd#L4) values for export values are hardset instead of being edited in the inspector settings of the file. 


#### Style Guide Exemplars ####

- [Good function usage/naming](https://github.com/ensemble-ai/exercise-2-camera-control-IamFyrus/blob/08669863d556a6778c5cbda1fe411f812b6e501a/Obscura/scripts/camera_controllers/horizontal_auto_scroll.gd#L47) student used _reposition method to keep the target within box. The functions are named appropriately and also the code is broken down into smaller portions and easy to follow along.

- [simple logic/clean code](https://github.com/ensemble-ai/exercise-2-camera-control-IamFyrus/blob/08669863d556a6778c5cbda1fe411f812b6e501a/Obscura/scripts/camera_controllers/position_lock_lerp.gd#L27) follow logic for stage 3 is simple + easy to understand. Student used the built in lerp method which promotes code reuse instead of writing their own lerp logic. 


___
#### Put style guide infractures ####

___

# Best Practices #

### Description ###

If the student has followed best practices then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####

- Student only made one commit, so its hard to tell when they started working and if they had enough time
- [creating new Vector3 instead of using target.position](https://github.com/ensemble-ai/exercise-2-camera-control-IamFyrus/blob/08669863d556a6778c5cbda1fe411f812b6e501a/Obscura/scripts/camera_controllers/position_lock.gd#L22) Student could have used target.global_position instead of creating a new vector to assign position to variable. This doesn't affect the functionality of the program, but more so a best practice suggestion. 



#### Best Practices Exemplars ####

- There are a fair number of comments throught out the assignments that clarify what the program is doing. This follows the guidelines of best practices

- [Comments on what the student attempted to do](https://github.com/ensemble-ai/exercise-2-camera-control-IamFyrus/blob/08669863d556a6778c5cbda1fe411f812b6e501a/Obscura/scripts/camera_controllers/speedup_push_zone.gd#L35) Additionally they also left comments in stage 4 and stage 5 explaining what the student tired to achieve, but how it ended up not working. Comments like these were nicely written and were helpful in communicating the student's throuht process