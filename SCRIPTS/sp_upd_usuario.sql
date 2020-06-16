DROP PROCEDURE IF EXISTS sp_upd_usuario;
DELIMITER $$
CREATE PROCEDURE sp_upd_usuario(in
	usuarioID int, 
    nome varchar(30),
    usuario varchar(25),
    senha varchar(80), 
    situacao tinyint(1)
    )
BEGIN    
	UPDATE sis_usuarios A SET 
		A.usuarioID = usuariOID, 
		A.nome 		= nome,
        A.usuario 	= usuario, 
        A.senha 	= senha,
        A.situacao 	= situacao
	WHERE A.usuarioID = usuarioID;
END; $$     
    