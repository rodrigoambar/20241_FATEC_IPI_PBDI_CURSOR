DO $$
	DECLARE
	v_ano INT := 201;
	v_inscritos INT := 6000000;
	cur_ano_inscritos CURSOR (ano INT, inscritos INT) FOR
	SELECT youtuber FROM tb_youtubers WHERE started >= ano AND subscribes >= inscritos; 
	v_youtuber VARCHAR (200);
BEGIN
	--- 2.abertura
	---essa, argumentos pela ordem
	--OPEN cur_ano_inscritos(v_ano, v_inscritos);
	---ou essa, passando argumentos pelo nome
	--OPEN cur_ano_inscritos(inscritos := v_inscritos, ano := v_ano);
	--ou
	OPEN cur_ano_inscritos (ano:= v_ano, inscritos := v_inscritos);
	LOOP
		-- buscar o nome
		--3. RECUPERAR DADOS
		FETCH cur_ano_inscritos INTO v_youtuber;
		-- sair se for o caso
		EXIT WHEN NOT FOUND;
		--exibir se puder
		RAISE NOTICE '%', v_youtuber;
	END LOOP;
	--4. fechamento 
	CLOSE cur_ano_inscritos;
END;
$$
-- --cursor  vinculado (bound)
-- --exibir nome de canal concatenado a seu numero de inscritos
-- --mais um bloquinho anonimo
-- DO $$
-- 	DECLARE
-- 		--cursor bound(vinculado)
-- 		/--1. Declaração(ainda não está aberto)
-- 		cur_nomes_e_inscritos CURSOR FOR
-- 		SELECT youtuber, subscribes FROM tb_youtubers;
-- 		tupla RECORD;
-- 		--- tupla.youtuber --- volta youtuber
-- 		--- tupla.subscribes --- volta num inscritos
-- 		resultado TEXT DEFAULT '';
-- 	BEGIN
-- 		--2. Abertura do cursor
-- 		OPEN cur_nomes_e_inscritos;
-- 		-- vamos usar while
-- 		--3. Recuperação de dados
-- 		FETCH cur_nomes_e_inscritos INTO tupla;
-- 		WHILE FOUND LOOP
-- 		--concatenar, operador
-- 		resultado := resultado || tupla.youtuber || ':' || tupla.subscribes || ',' ;
-- 		FETCH cur_nomes_e_inscritos INTO tupla;
-- 		END LOOP;
-- 		--4. Fechar cursor
-- 		CLOSE cur_nomes_e_inscritos;
-- 		RAISE NOTICE '%', resultado;
-- END;
-- $$




-- DO $$
-- DECLARE
-- 	--1. Declaraçao
-- 	cur_nomes_a_partir_de REFCURSOR; 
-- 	v_youtuber VARCHAR(200);
-- 	v_ano INT := 2008;
-- 	v_name_tabela VARCHAR(200) := 'tb_youtubers';
	

-- BEGIN
-- 	--2. Aberturado cursor 
-- 	OPEN cur_nomes_a_partir_de FOR EXECUTE
-- 	format(
-- 		' 
-- 			select
-- 				youtuber
-- 			FROM %s
-- 			WHERE started =$1
-- 		', v_name_tabela
-- 	)USING v_ano;
-- 	LOOP
-- 		FETCH cur_nomes_a_partir_de INTO v_youtuber;
-- 		EXIT WHEN NOT FOUND;
-- 		RAISE NOTICE '%', v_youtuber;
	
-- 	END LOOP;
-- 	--4. Fechamento do cursor
-- 	CLOSE cur_nomes_a_partir_de;

-- END;
-- $$
