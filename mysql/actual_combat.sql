SELECT
    pub.id as pub_id,pub.comment as pub_comment,pub.tag_name pub_tag,stg.stage_id stage_id,step.step_id as step_id,step.status step_status
FROM
    dinobot.autoci_publishrecord as pub
join dinobot.autoci_publishrecord_stage_records as pub_stg on pub.id=pub_stg.publishrecord_id
join dinobot.autoci_stagerecord as stg on pub_stg.stagerecord_id=stg.id
join dinobot.autoci_stagerecord_step_records as stg_step on stg_step.stagerecord_id=stg.id
join dinobot.autoci_steprecord as step on stg_step.steprecord_id=step.id
where step.step_id=5 and stg.stage_id=4 and step.status="failed" and pub.created_at between '2017-09-22' and '2017-09-28';

SELECT
    pub.id as pub_id,pub.comment as pub_comment,pub.tag_name pub_tag,stg.stage_id,comp.name,comp.redmine_project_id
FROM
    dinobot.autoci_publishrecord as pub
join dinobot.autoci_publishrecord_stage_records as pub_stg on pub.id=pub_stg.publishrecord_id
join dinobot.autoci_stagerecord as stg on pub_stg.stagerecord_id=stg.id
join dinobot.autoci_publishrecord_components as pub_comp on pub.id=pub_comp.publishrecord_id
join dinobot.base_component as comp on pub_comp.component_id=comp.id
where stg.stage_id=4 and comp.redmine_project_id=35 and pub.created_at between '2017-09-22' and '2017-09-28';



SELECT
    distinct pub.id as pub_id,pub.comment as pub_comment,pub.tag_name pub_tag,stg.stage_id,comp.name as comp_name,comp.redmine_project_id as redmind_group
FROM
    dinobot.autoci_publishrecord as pub
join dinobot.autoci_publishrecord_stage_records as pub_stg on pub.id=pub_stg.publishrecord_id
join dinobot.autoci_stagerecord as stg on pub_stg.stagerecord_id=stg.id
join dinobot.autoci_publishrecord_components as pub_comp on pub.id=pub_comp.publishrecord_id
join dinobot.base_component as comp on pub_comp.component_id=comp.id
where comp.redmine_project_id=35 and pub.created_at between '2017-09-22' and '2017-09-28'
group by pub.id;


SELECT
    pub.id as pub_id,pub.comment as pub_comment,pub.tag_name pub_tag,stg.stage_id stage_id,step.step_id as step_id,step.status step_status,comp.name as comp_name
FROM
    dinobot.autoci_publishrecord as pub
join dinobot.autoci_publishrecord_stage_records as pub_stg on pub.id=pub_stg.publishrecord_id
join dinobot.autoci_stagerecord as stg on pub_stg.stagerecord_id=stg.id
join dinobot.autoci_stagerecord_step_records as stg_step on stg_step.stagerecord_id=stg.id
join dinobot.autoci_steprecord as step on stg_step.steprecord_id=step.id
join dinobot.autoci_publishrecord_components as pub_comp on pub.id=pub_comp.publishrecord_id
join dinobot.base_component as comp on pub_comp.component_id=comp.id
where comp.redmine_project_id=35 and step.step_id=5 and stg.stage_id=4 and step.status="successfully" and pub.created_at between '2017-09-22' and '2017-09-28';