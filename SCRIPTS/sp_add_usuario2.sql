
DROP PROCEDURE IF EXISTS sp_add_usuario;
DELIMITER $$
CREATE PROCEDURE sp_add_usuario(in
  nome varchar(30), 
  usuario varchar(15), 
  senha varchar(80)
  )
  
BEGIN  
select nome;
	INSERT INTO sis_usuarios(nome, usuario, senha) VALUES(nome, usuario, senha);
	set @id=(select A.usuarioID from sis_usuarios A where A.usuario = usuario);
	insert into sis_permissoes (usuarioID, posicao, programaID) values (@id, 1, 1);
END; $$