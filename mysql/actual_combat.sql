SELECT
    pub.id as pub_id,pub.created_at,pub.comment as pub_comment,pub.tag_name pub_tag,stg.stage_id stage_id,step.step_id as step_id,step.status step_status,comp.name as comp_name,comp.redmine_project_id
FROM
    dinobot.autoci_publishrecord as pub
left join dinobot.autoci_publishrecord_stage_records as pub_stg on pub.id=pub_stg.publishrecord_id
left join dinobot.autoci_stagerecord as stg on pub_stg.stagerecord_id=stg.id
left join dinobot.autoci_stagerecord_step_records as stg_step on stg_step.stagerecord_id=stg.id
left join dinobot.autoci_steprecord as step on stg_step.steprecord_id=step.id
left join dinobot.autoci_publishrecord_components as pub_comp on pub.id=pub_comp.publishrecord_id
left join dinobot.base_component as comp on pub_comp.component_id=comp.id

#where comp.redmine_project_id=17 and step.step_id=5 and stg.stage_id=4 step.status<>"failed" and pub.created_at between '2017-10-12' and '2017-10-18 23:59:59.999999'
where comp.redmine_project_id=172 and stg.stage_id=4 and pub.created_at between '2017-10-11 16:00:00' and '2017-10-18 16:00:00.999999'
#where pub.id=5273
#where comp.redmine_project_id=211 and step.step_id=5 and stg.stage_id=4
group by pub.id
;

SELECT
    pub.id as pub_id,pub.created_at,pub.comment,pub.status,stp.comment,comp.redmine_project_id
FROM
    dinobot.release_publishrecord as pub
left join
    dinobot.release_steprecord as stpRec on pub.id=stpRec.publishrecord_id
left join
    dinobot.release_step as stp on stpRec.step_id=stp.id
left join 
    dinobot.release_stage as stg on stg.id=stp.stage_id
left join
    dinobot.release_publishrecord_component as pub_comp on pub_comp.publishrecord_id=pub.id
left join
    dinobot.base_component as comp on comp.id=pub_comp.component_id
where
    pub.start_at between '2017-11-02' and '2017-11-08 23:59:59.999999' and comp.redmine_project_id=234 and stp.id > 8
group by pub.id;