DROP TRIGGER IF EXISTS trg_add_usuarios;
DELIMITER $$
CREATE TRIGGER trg_add_usuarios AFTER INSERT ON sis_usuarios FOR EACH ROW 
BEGIN
	SET @ID:=NEW.usuarioID;
	INSERT INTO sis_permissoes (usuarioID, posicao, programaID) VALUES (@ID, 1, 1);
END; $$