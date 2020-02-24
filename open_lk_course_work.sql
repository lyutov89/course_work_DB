
CREATE DATABASE open_lk; 

USE open_lk; 

-- Таблица users. TIN - это как наш ИНН. 

CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  TIN INT NOT NULL, 
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  phone VARCHAR(120) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

SELECT * FROM users;

SELECT * FROM wallet; 


-- Таблица профилей

CREATE TABLE profile (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY,
  sex CHAR(1) NOT NULL,
  birthday DATE,
  hometown VARCHAR(100), 
  address VARCHAR(100)
); 

SELECT * FROM profile p2; 

-- Таблица кошелек пользователя

DESC open_lk.wallet; 

DROP TABLE wallet; 

CREATE TABLE wallet (
  id INT UNSIGNED NOT NULL,
  TIN INT NOT NULL,
  ticker VARCHAR(10),  
  quantity INT UNSIGNED NOT NULL
); 

-- Таблица типов ценных бумаг 
DROP TABLE assets_types; 

CREATE TABLE assets_types (
   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   type_of_asset VARCHAR(100)
); 

-- Таблица акций

-- price - DECIMAL или FLOAT? Нужно, чтобы обрабатывалось например 233.84
DROP TABLE open_lk.shares_list; 

CREATE TABLE shares_list (
   id INT UNSIGNED NOT NULL,
   ticker CHAR(10), 
   price DECIMAL UNSIGNED,
   exchange_type INT UNSIGNED, 
   last_news VARCHAR(255), 
   created_at DATETIME DEFAULT NOW(),
   updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
); 

DROP TABLE share_profile; 

SELECT * FROM open_lk.shares_list; 

-- Таблица профиля акции


CREATE TABLE share_profile (
   share_id INT UNSIGNED NOT NULL,
   ticker CHAR (10), 
   volume_of_deals_for_day INT NOT NULL, 
   open_price INT NOT NULL, 
   close_price INT NOT NULL,
   expecting_dividend INT UNSIGNED, 
   next_report DATE NOT NULL
   ); 

-- Таблица рынков
DROP TABLE type_of_exchanges; 
  
CREATE TABLE type_of_exchanges ( 
   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
   exchange CHAR(10) 
   ); 

-- Таблица сделок пользователя 
DROP TABLE user_deals; 
  
CREATE TABLE user_deals (
   id INT UNSIGNED NOT NULL, 
   user_id INT UNSIGNED NOT NULL, 
   TIN INT NOT NULL, 
   asset_type INT UNSIGNED NOT NULL,
   ticker CHAR(10),
   amount_of_assets INT NOT NULL, 
   type_of_deal CHAR(10), 
   price_for_equity INT NOT NULL
   ); 

-- Таблица облигаций (бондов) nkd_value - накопленный купонный доход 

DROP TABLE list_bond;

-- пока не понятно, зачем нужна таблица List bond

CREATE TABLE list_bond (
   id INT UNSIGNED NOT NULL,
   ticker CHAR(10), 
   price DECIMAL UNSIGNED,
   exchange_type VARCHAR(100), 
   created_at DATETIME DEFAULT NOW(),
   updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

DROP TABLE bond_profile; 

CREATE TABLE bond_profile (
   bond_id INT UNSIGNED NOT NULL,
   ticker CHAR(10), 
   price_nominal INT NOT NULL, 
   current_price INT NOT NULL, 
   period_payment INT NOT NULL, 
   nkd_value INT NOT NULL, 
   nearest_payment DATE NOT NULL, 
   bond_coupon INT NOT NULL, 
   created_at DATETIME DEFAULT NOW(),
   updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() 
   ); 
  
-- Таблица валют 
DROP TABLE currencies; 
  
CREATE TABLE currencies (
   id INT UNSIGNED NOT NULL,
   current_value INT UNSIGNED NOT NULL, 
   trade_volume INT UNSIGNED NOT NULL, 
   open_price INT UNSIGNED NOT NULL, 
   close_price INT UNSIGNED NOT NULL
   );
 
DROP TABLE type_currency;  
  
CREATE TABLE type_currency (
   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
   ticker VARCHAR (10) 
   ); 
  
-- Таблица товаров
DROP TABLE goods; 
  
CREATE TABLE goods (
   id INT UNSIGNED NOT NULL, 
   good_group INT UNSIGNED NOT NULL, 
   ticker VARCHAR(10), 
   current_value INT UNSIGNED NOT NULL, 
   trade_volume INT UNSIGNED NOT NULL, 
   open_price INT UNSIGNED NOT NULL, 
   close_price INT UNSIGNED NOT NULL
   ); 

-- Таблица групп товаров
DROP TABLE goods_group; 
  
CREATE TABLE goods_group (
   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
   name_good_group VARCHAR(10)
   ); 

-- Таблица торговых идей 
DROP TABLE analytical_ideas;   
  
CREATE TABLE analytical_ideas (
   id INT UNSIGNED NOT NULL, 
   idea_number INT UNSIGNED NOT NULL,
   ticker CHAR(10), 
   type_asset CHAR(10), 
   type_deal CHAR(10),
   to_follow_idea INT NOT NULL, 
   time_horizont_month INT NOT NULL, 
   earning_forecast_percent INT NOT NULL, 
   created_at DATETIME DEFAULT NOW(),
   updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() 
  ); 

-- цель создания каталога - разделить сами идеи и параметры их доходности (горизонт, процент, тип сделки)
DROP TABLE catalogue_analytical_ideas; 

CREATE TABLE catalogue_analytical_ideas (
   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
   name VARCHAR(255), 
   link_idea VARCHAR(255)  
  );
  
SHOW TABLES 

-- to follow idea - у пользователя есть возможность добавить идею в лист отслеживаемых, а у идеи появляется рейтинг доверия 
-- таким образом, можно отследить наиболее популярные идеи. 


-- Таблица связей

ALTER TABLE open_lk.profile
	ADD CONSTRAINT profile_user_id_fk
		FOREIGN KEY (user_id) REFERENCES open_lk.users(id); 
	
ALTER TABLE user_deals
	ADD CONSTRAINT user_deals_user_id_fk
		FOREIGN KEY (user_id) REFERENCES open_lk.users(id); 
	
ALTER TABLE analytical_ideas 
	ADD CONSTRAINT analytical_ideas_to_follow_idea_fk
		FOREIGN KEY (to_follow_idea) REFERENCES users(id); 

ALTER TABLE analytical_ideas MODIFY to_follow_idea INT UNSIGNED NOT NULL; 

ALTER TABLE share_profile 
	ADD CONSTRAINT share_profile_share_id_fk
		FOREIGN KEY (share_id) REFERENCES shares_list(id);
	

ALTER TABLE shares_list MODIFY id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY; 

ALTER TABLE bond_profile 
	ADD CONSTRAINT bond_profile_bond_id_fk
		FOREIGN KEY (bond_id) REFERENCES list_bond(id);
	
ALTER TABLE list_bond MODIFY id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY; 

ALTER TABLE analytical_ideas 
	ADD CONSTRAINT analytical_ideas_idea_number_fk
		FOREIGN KEY (idea_number) REFERENCES catalogue_analytical_ideas(id); 
	
ALTER TABLE goods 
	ADD CONSTRAINT goods_good_group_fk
		FOREIGN KEY (good_group) REFERENCES goods_group(id); 
	
ALTER TABLE wallet 
	ADD CONSTRAINT wallet_id_fk
		FOREIGN KEY (id) REFERENCES users(id); 
	
ALTER TABLE user_deals 
	ADD CONSTRAINT user_deals_asset_type_fk
		FOREIGN KEY (asset_type) REFERENCES assets_types(id); 
	
ALTER TABLE analytical_ideas
	ADD CONSTRAINT analytical_ideas_type_asset_fk
		FOREIGN KEY (type_asset) REFERENCES assets_types(id);

	ALTER TABLE analytical_ideas MODIFY type_asset INT UNSIGNED NOT NULL; 

ALTER TABLE shares_list
	ADD CONSTRAINT shares_list_exchange_type_fk
		FOREIGN KEY (exchange_type) REFERENCES type_of_exchanges(id);
	
ALTER TABLE currencies
	ADD CONSTRAINT currencies_id_fk
		FOREIGN KEY (id) REFERENCES type_currency(id);

SELECT * FROM type_currency tc; 

SELECT * FROM currencies c2; 

SELECT * FROM wallet w2; 

SELECT * FROM analytical_ideas ai; 

-- Возникло желание создать общую таблицу тикеров и сделать тикер первичным ключом. 
-- Достоинства: мы свяжем большинство таблиц (тикеры присутствуют почти везде). Следовательно, база будет работать шустрее
-- Недостатки. На практике биржи сами разделяют свои рынки: фондовый, валютный, срочный. И к основному тикеру появляется дополнительный индекс, 
-- который его идентифицирует.
-- В итоге я считаю, что в первом приближении лучше оставить так, как есть.  

-- Запросы к базе данных. 
-- Определим самую популярную инвестиционную идею и кол-во лайков, которые ей было поставлено (+)  
-- Самый молодой инвестор, который поставил больше всего лайков инвестидеям 
-- Самый богатый инвестор, который поставил больше всего лайков инвестидеям
-- Кто больше всех совершил сделок: мужчины или девушки? (++) 
-- Самый популярный актив в сделках. И самый непопулярный. 
-- Самую высокодоходную акцию с точки зрения дивидендов, сколько у нее лайков (фолловеров) 
-- Как настроены пользователи по инвестрекомендациям? Сколько сделок sell and buy по ним? (++) 

SELECT *FROM open_lk.analytical_ideas; 

SELECT ticker, COUNT(*) AS most_followed_idea FROM open_lk.analytical_ideas
GROUP BY ticker; 

SELECT to_follow_idea FROM open_lk.analytical_ideas; 


-- Триггер: добавление нового эмитента в таблицу профиля акций/облигаций и товара/валюты. 
-- При отсутствии цены на эмитент должна вызываться ошибка. 

-- Транзакция покупки акции или облигации или валюты или товара
 
-- Поскольку база данных находится в развитии и большинство тикеров еще предстоит завести в лист, то необходимо написать
-- триггер, который будет проверять правильно ли выполнен ввод данных, например, в лист акций. Триггер нужен перед 
-- вставкой и перед обновлением листа. В дальнейшем нужно сделать такие же по профилю акции, листу облигаций, валютным 
-- парам и товарам. 

-- Триггер. Начинаем с DELIMITER 

DELIMITER //

CREATE TRIGGER check_price_and_ticker_BEFORE INSERT IN shares_list; 
FOR EACH ROW 
BEGIN
	IF NEW.price IS NULL AND NEW.ticker IS NULL THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE TEXT = 'CHECK is not passed. Price and ticker are not defined'
	END IF; 
END//

-- блок вставки
-- оба значения неопределены

INSERT INTO open_lk.shares_list
	(id, price, ticker, exchange_type, last_news, created_at, updated_at)
VALUES
	(21, NULL, NULL, 1, 'https://ru.investing.com/news/economy/article-400', '2020-02-20 09:42:34', '2020-02-20 09:42:34' ); //

-- определено одно из двух

INSERT INTO open_lk.shares_list
	(id, price, ticker, exchange_type, last_news, created_at, updated_at)
VALUES
	(21, NULL, 'SNGS', 1, 'https://ru.investing.com/news/economy/article-400', '2020-02-20 09:42:34', '2020-02-20 09:42:34' ); //

	-- Триггер на проверку перед обновлением таблицы products

CREATE TRIGGER check_price_and_ticker_before_upd BEFORE UPDATE IN open_lk.shares_list; 
FOR EACH ROW 
BEGIN
	IF NEW.price IS NULL AND NEW.ticker IS NULL THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE TEXT = 'Check is not paased. New price and new ticker is not defined'
	END IF; 
END//

-- общее представление (1): общий каталог инвестидей с сортировкой по горизонту инвестирования. 

-- назовем представление general_invest_catalogue

CREATE VIEW general_invest_cat AS SELECT DISTINCT(idea_number), ticker, earning_forecast_percent, time_horizont_month, name as NAME, link_idea AS LINK FROM open_lk.analytical_ideas
	INNER JOIN catalogue_analytical_ideas
	ON idea_number=catalogue_analytical_ideas.id
ORDER BY time_horizont_month; 

SELECT * FROM general_invest_cat; 

-- Инвесторы как правило следят за облигациями и акциями одного и того же эмитента. 
-- Поэтому очень удобно получить представление по эмитентам у которых есть и облигации и акции на бирже. 
-- Создадим представление bond_and_share_info_from_plant 


CREATE VIEW bond_and_share_info_from_plant AS SELECT bp.ticker, bond_coupon, period_payment AS bond_period_payment, expecting_dividend AS share_dividend
FROM bond_profile bp
	JOIN share_profile
	ON share_profile.ticker=bp.ticker
ORDER BY share_dividend; 

SELECT * FROM bond_and_share_info_from_plant; 

-- Процедуры и транзакции. 

-- Процедуры 


-- Первая процедура будет очень простой. Мы будем выбирать все сделки пользователей по акциям, где кол-во больше заданного arg
-- Конечно, это можно реализовать при помощи запроса, используя Having или When, но для начала сделаем так: 

DELIMITER //
CREATE PROCEDURE info_deal_user (arg int)
BEGIN
    SELECT user_id, ticker, price_for_equity, amount_of_assets, type_of_deal
    FROM user_deals ud
    WHERE amount_of_assets > arg AND asset_type = 1;
END //
DELIMITER ; 

CALL deal_user(200);

-- Процедура №2. Сделаем выборку по инвесторам, имеющих в своих кошельках до 50 у.е. ; от 50 до 200 у.е. ; от 200 и более у.е. 
-- Как улучшить процедуру: сделать раздельно по рублям, долларам, фунтам. Или найти способ, как посчитать сумму трех раздельных элементов по окнам (USD/RUB, GBP/RUB, RUB) 

DELIMITER //
CREATE PROCEDURE get_investor (str VARCHAR(256))
BEGIN
    CASE str
    WHEN "Маленький кошелек"
    THEN
		SELECT last_name as "инвестор", SUM(quantity) as "Сумма в кошельке"
			FROM wallet w2
			LEFT JOIN users on w2.id = users.id
        group by w2.id
        HAVING SUM(quantity) < 50;
    WHEN "Средний кошелек"
    THEN
		SELECT last_name as "инвестор", SUM(quantity) as "Сумма в кошельке"
			FROM wallet w2
			LEFT JOIN users on w2.id = users.id
        group by w2.id
        HAVING SUM(amt) >= 50 and SUM(amt) < 200;
    WHEN "Большой кошелек"
    THEN
		SELECT last_name as "инвестор", SUM(quantity) as "Сумма в кошельке"
			FROM wallet w2
			LEFT JOIN users on w2.id = users.id
        group by w2.id
        HAVING SUM(amt) >= 200;
    END CASE;
END //
DELIMITER ;

SELECT * FROM wallet w2 where ticker = 'RUB' and quantity > 250; 

SELECT * FROM user_deals ud WHERE user_id = 20; 

-- Транзакция - покупка актива

-- Покупка актива через кошелек пользователя на примере акции Сбербанка   

-- Сначала проверка, действительно есть ли деньги на покупку этого актива. 

SELECT * FROM wallet w2 where ticker = 'RUB' and quantity > 250; 

-- потом стартуем с транзакцией. 

START TRANSACTION	
UPDATE wallet SET quantity = quantity - 250 WHERE ticker = 'RUB' and wallet.id = 23
INSERT INTO user_deals SET asset_type = 1, ticker = 'SBER', amount_of_assets = 1, type_of_deal = 'buy', price_for_equity = 250
	WHERE user_id = 23
COMMIT; 

-- не совсем уверен в этой операции, но не мог ее не добавить, поскольку транзакция с покупкой и продажей - основа 
-- всех финансовых сервисов. Если даже и неверно, то пусть получу от вас комментарий, где выполнено неверно и после обновлю. 

-- 6 запросов с группировками, вложенными таблицами и JOIN-ами. 

-- 1) Кто больше всех совершил сделок: мужчины или девушки? 

SELECT profile.sex, COUNT(amount_of_assets) AS amount_of_deals
FROM open_lk.user_deals
	JOIN open_lk.profile
		ON profile.user_id = user_deals.user_id
GROUP BY profile.sex
ORDER BY COUNT(amount_of_assets) DESC LIMIT 2; 

-- 2) Название инвестидеи, общее кол-во лайков по ней и кол-во совершенных сделок 

SELECT catalogue_analytical_ideas.name, COUNT(DISTINCT(to_follow_idea)) AS like_idea, COUNT(user_deals.ticker) as amount_deal 
FROM open_lk.analytical_ideas 
	LEFT JOIN catalogue_analytical_ideas
		ON catalogue_analytical_ideas.id = analytical_ideas.idea_number
	LEFT JOIN user_deals
		ON analytical_ideas.ticker = user_deals.ticker
			WHERE asset_type = 1
GROUP BY catalogue_analytical_ideas.name
ORDER BY amount_deal DESC LIMIT 10; 

-- 3) 10 самых молодых пользователей и сколько лайков они поставили в каталоге инвестидей

SELECT COUNT(to_follow_idea) as amount_of_likes, last_name, first_name, profile.user_id FROM analytical_ideas ai
	JOIN users
		ON ai.to_follow_idea = users.id
	JOIN profile
		ON ai.to_follow_idea = profile.user_id
GROUP BY ai.to_follow_idea
ORDER BY profile.birthday DESC LIMIT 10; 

-- 4) 10-ка инвесторов, у которых больше всего денег на счету (по валюте + по рублям) 
-- 

SELECT CONCAT(first_name,' ', last_name) AS user_name, SUM(quantity*current_price) AS all_wallet
FROM wallet w2
	JOIN users 
		ON users.id = w2.id
	JOIN type_currency
		ON w2.ticker = type_currency.ticker
GROUP BY user_name
ORDER BY all_wallet DESC LIMIT 10; 

-- 5) кто больше следит (фолловит) за инвестидеями? Девушки или мужчины? Вывести Тикер инвестидеи и кол-во 
-- следящих за этой инвестидеей мужчин и женщин.

SELECT * FROM catalogue_analytical_ideas cai; 

SELECT ai.ticker, COUNT(profile.sex) AS number_of_man 
FROM analytical_ideas ai
	LEFT JOIN profile
		ON ai.to_follow_idea = profile.user_id
	WHERE profile.sex = 'M'
GROUP BY ai.ticker
ORDER BY COUNT(profile.sex) DESC; 

SELECT ai.ticker, COUNT(profile.sex) AS number_of_woman
FROM analytical_ideas ai
	LEFT JOIN profile
		ON ai.to_follow_idea = profile.user_id
	WHERE profile.sex = 'F'
GROUP BY ai.ticker
ORDER BY COUNT(profile.sex) DESC; 

-- Комментарий - как объединить такую аналитику в один запрос? Найти процентное соотношение? Думаю, надо пробовать через оконные функции. 

-- 6) Кто из пользователей совершил сделки по инвестрекоммендациям? На какие суммы? 

SELECT DISTINCT(CONCAT(first_name,' ', last_name)) AS users_full_name, ud.ticker, type_of_deal, price_for_equity, amount_of_assets, type_currency.current_price
FROM user_deals ud
	JOIN users
		ON users.id = ud.user_id
	JOIN analytical_ideas
		ON ud.ticker = analytical_ideas.ticker 
			AND asset_type = 1
	LEFT JOIN type_currency
		ON type_currency.id = ud.currency_id;  

-- Как бы дальше хотел развить этот запрос: 
-- Посчитать в рублях размер сделок по инвестрекоммендациям, вычислить общую сумму (как это сделать? Через оконные функции?) 
-- UPD - добавил currency_id - id валюты, в которой заключена сделка. ALTER TABLE в файле Wallet. 		

SELECT * FROM profile p2;  

SELECT * FROM currencies c2;

SELECT * FROM type_currency tc; 

SELECT * FROM user_deals ud; 

SELECT * FROM catalogue_analytical_ideas cai; 

SELECT * FROM analytical_ideas ai; 


