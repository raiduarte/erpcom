
use lazaro;

--
--
--
drop table if exists sis_usuarios;
create table sis_usuarios(
  usuarioID int not null auto_increment primary key,
  nome varchar(30) not null,
  usuario varchar(25) not null unique,
  senha varchar(80) not null,
  situacao tinyint(1) default 1,
  superusuario tinyint(1) default 0
);
insert into sis_usuarios values(null, 'Administrador', 'admin', sha2('admin', 224), 1, 1);
--
--
--
drop table if exists sis_programas;
create table sis_programas(
  programaID int not null auto_increment primary key,
  programa varchar(30) not null, 
  hint varchar(200),
  formulario varchar(50),
  icone blob,
  sistema tinyint(1) default 0
);
insert into sis_programas values
(null, 'Início', 'Início', 'TFrameInicio', null, 1), 
(null, 'Painel de Controle', 'Administração do sistema, criação de contas de acesso, personalização do sistema', 'TFramePainelDeControle', null, 1),
(null, 'Logs de Eventos', '', 'TFramePainelDeControleLogsdeEventos', null, 1);
--
--
--
drop table if exists sis_permissoes;
create table sis_permissoes(
  permissaoID int not null auto_increment primary key,
  usuarioID int not null, 
  posicao int,
  programaID int not null,
  pode_ler tinyint(1) default 1,
  pode_alterar tinyint(1) default 1,
  pode_adicionar tinyint(1) default 1,
  pode_excluir tinyint(1) default 1,
  pode_imprimir tinyint(1) default 1,
  situacao tinyint(1) default 1,
  index idxPermissoes(usuarioID, programaID)
);
insert into sis_permissoes values 
(null, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(null, 1, 1, 2, 1, 1, 1, 1, 1, 1),
(null, 1, 1, 3, 1, 1, 1, 1, 1, 1);
--
--
--
drop table if exists sis_logs_eventos;
create table sis_logs_eventos(
  eventoID int not null auto_increment primary key,
  usuarioID int not null,
  data_evento timestamp null default current_timestamp,
  programaID int not null,
  evento varchar(80) not null,
  descricao text,
  index idxLogsEventos(usuarioID, programaID)
);  
  