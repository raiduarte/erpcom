
DROP PROCEDURE IF EXISTS sp_add_usuario;
DELIMITER $$
CREATE PROCEDURE sp_add_usuario(in
  usuarioID int,
  nome varchar(30), 
  usuario varchar(15), 
  senha varchar(80)
  )
BEGIN  
  INSERT INTO sis_usuarios(
    nome,
    usuario,
    senha
  )
  VALUES(
    nome,
    usuario,
    senha
  );

SET @n=nome;
  SELECT usuarioID FROM sis_usuarios WHERE nome = @n INTO @ID;
  
  INSERT INTO sis_permissoes(usuarioID, programaID)
	VALUES(usuarioID, programaID);
    
END; $$