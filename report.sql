select max_traff,  l2_near_end_dev, l2_near_end_if, l2_far_end_dev, l2_far_end_if,  
                   upl_sel, port_id, port_name, dev_full
  from (

select max_traffic(TO_NUMBER(SUBSTRING(traffic_in,'([0-9]{1,12})' ),'999999999999D9' ),
                   TO_NUMBER(SUBSTRING(traffic_out,'([0-9]{1,12})' ),'999999999999D99' ) ) as max_traff,
	   SPLIT_PART(device,' - ',1) as dev_short, port_name, 
       uplink(imp_l2.source_iface)  as upl_sel,
       port_id as port_id, device as dev_full,
--       imp_l2.dest_device as l2_far_end_dev,      imp_l2.dest_iface as l2_far_end_if,
--       imp_l2.source_device as l2_near_end_dev,   imp_l2.source_iface as l2_near_end_if
       imp_l2.source_device as l2_far_end_dev, imp_l2.source_iface as l2_far_end_if,
       imp_l2.dest_device as l2_near_end_dev,   imp_l2.dest_iface as l2_near_end_if

from imp_cacti_2,imp_l2
where max_traffic(TO_NUMBER(SUBSTRING(traffic_in,'([0-9]{1,12})' ),'999999999999D9' ),
                  TO_NUMBER(SUBSTRING(traffic_out,'([0-9]{1,12})' ),'999999999999D99' ) ) > 500
  and uplink(imp_l2.source_iface) <10    
  and imp_cacti_2.device like '%'||imp_l2.dest_device||'%' 
--  and imp_cacti_2.device like '%'||imp_l2.source_device||'%' 
)
--group by l2_far_end_dev, l2_far_end_if
order by l2_far_end_dev, l2_far_end_if
