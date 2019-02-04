drop table if exists "tbTmpOdoo";
create temporary table "tbTmpOdoo" as   		
select * from
(select public.res_partner.id as partner_id,
		public.res_partner.name as name,		
		public.mail_channel_partner.create_date as create_date,
 		public.mail_channel_partner.channel_id as channel_id
FROM public.res_partner
left outer join public.mail_channel_partner
on public.res_partner.id=public.mail_channel_partner.partner_id) tb
where tb.channel_id=(select id FROM public.mail_channel where name='general');
select * from
(select public.res_users.id as id,
 		"tbTmpOdoo".name as name,
 		public.res_users.login as email,	
		"tbTmpOdoo".create_date as create_date
from public.res_users
left outer join "tbTmpOdoo"
on public.res_users.partner_id="tbTmpOdoo".partner_id) ts
where ts.create_date > (SELECT date_trunc('month', CURRENT_DATE))
and ts.create_date < (SELECT date_trunc('month', CURRENT_DATE) + interval '1 month - 1 day');
