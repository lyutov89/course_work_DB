USE open_lk; 

INSERT INTO open_lk.assets_types VALUES 
  ('1','share'), 
  ('2','bond'), 
  ('3','currency'), 
  ('4','good'); 
 
CREATE TEMPORARY TABLE sex(sex CHAR(1));
	INSERT INTO sex VALUES ('M'), ('F');
		UPDATE open_lk.profile SET sex = (SELECT sex FROM sex ORDER BY RAND() LIMIT 1);
 
SELECT * FROM open_lk.assets_types; 
  
SELECT * FROM open_lk.users; 

SELECT * FROM open_lk.profile; 

SELECT user_id, birthday FROM profile
	WHERE YEAR(birthday) > 2002; 

UPDATE profile 
	SET birthday = '1989-02-07'
	WHERE user_id = 103; 
  
INSERT INTO type_of_exchanges VALUES 
  ('1','MOEX'), 
  ('2','SPB'),
  ('3','LSE'),
  ('4','NQ');

 UPDATE shares_list 
 SET price = 254.30 
 WHERE ticker = 'SBER'; 

 
INSERT INTO goods_group VALUES
  ('1','metals'), 
  ('2','energy'),
  ('3','corn'), 
  ('4','meat'); 
 
INSERT INTO goods VALUES 
  ('1','1','GC','1570.18','62300','1545.45','1565.45'),  
  ('2','1','SI','17628.18','57000','17547.89','17797.32'),
  ('3','1','HG','2557','94800','2556','2607'),
  ('4','1','PL','973.90','103000','962.87','977'),
  ('5','2','B','53.99','280200','53.33','54.67'),
  ('6','2','CL','50','394800','47.50','51.20'),
  ('7','2','NG','1.792','337200','1.752','1.8'),
  ('8','3','C','541.12','900200','519.05','558.25'),
  ('9','3','CH','379.62','413200','378.12','381.88'),
  ('10','3','MF','290.15','337200','289.06','292.90'),
  ('11','3','RF','13.15','539200','12.96','13.05'),      
  ('12','4','LEG','117.188','59994','117.06','119.75'),
  ('13','4','GFF','142.45','15431','142.25','142.52'),
  ('14','4','HEG','64.36','49650','63.79','66.17');
 
 SELECT * FROM goods g2; 
  
 SELECT * FROM shares_list sl; 
 



 