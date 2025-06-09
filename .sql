CREATE TABLE T_ALERTA 
    ( 
     id_alerta               NUMBER  NOT NULL , 
     T_TIPO_EVENTO_id_evento NUMBER  NOT NULL , 
     T_ENDERECO_id_endereco  NUMBER  NOT NULL , 
     T_USUARIOS_id_usuario   NUMBER  NOT NULL , 
     titulo_alerta           VARCHAR2 (100)  NOT NULL , 
     descricao_alerta        CLOB  NOT NULL , 
     risco_alerta            VARCHAR2 (20)  NOT NULL , 
     dt_alerta               DATE  NOT NULL 
    ) 
;

ALTER TABLE T_ALERTA 
    ADD CONSTRAINT T_ALERTA_PK PRIMARY KEY ( id_alerta ) ;

CREATE TABLE T_CLIMA 
    ( 
     id_clima               NUMBER  NOT NULL , 
     T_ENDERECO_id_endereco NUMBER  NOT NULL , 
     dt_registro            DATE  NOT NULL , 
     temperatura_clima      NUMBER (5,2)  NOT NULL , 
     umidade_clima          NUMBER (5,2)  NOT NULL , 
     vento_clima            NUMBER (5,2)  NOT NULL , 
     indice_uv              NUMBER (4,2)  NOT NULL , 
     descricao_clima        VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE T_CLIMA 
    ADD CONSTRAINT T_CLIMA_PK PRIMARY KEY ( id_clima ) ;

CREATE TABLE T_CONFIG_USUARIO 
    ( 
     T_USUARIOS_id_usuario NUMBER  NOT NULL , 
     aviso_temp            CHAR (1)  NOT NULL , 
     mostrar_dicas         CHAR (1)  NOT NULL , 
     widget_config         CHAR (1) , 
     verif_diaria          CHAR (1)  NOT NULL , 
     notificar_estrada     CHAR (1)  NOT NULL , 
     avisar_catastrofe     CHAR (1)  NOT NULL 
    ) 
;

ALTER TABLE T_CONFIG_USUARIO 
    ADD CONSTRAINT T_CONFIG_USUARIO_PK PRIMARY KEY ( T_USUARIOS_id_usuario ) ;

CREATE TABLE T_DADO 
    ( 
     id_dado                NUMBER  NOT NULL , 
     T_ENDERECO_id_endereco NUMBER  NOT NULL , 
     dt_dado                DATE  NOT NULL , 
     valor_dado             VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE T_DADO 
    ADD CONSTRAINT T_DADO_PK PRIMARY KEY ( id_dado ) ;

CREATE TABLE T_DENUNCIA 
    ( 
     id_denuncia            NUMBER  NOT NULL , 
     T_USUARIOS_id_usuario  NUMBER  NOT NULL , 
     T_ENDERECO_id_endereco NUMBER  NOT NULL , 
     descricao_denuncia     CLOB  NOT NULL , 
     dt_denuncia            DATE  NOT NULL , 
     imagem_denuncia        VARCHAR2 (255)  NOT NULL , 
     status_denuncia        VARCHAR2 (20)  NOT NULL 
    ) 
;

ALTER TABLE T_DENUNCIA 
    ADD CONSTRAINT T_DENUNCIA_PK PRIMARY KEY ( id_denuncia ) ;

CREATE TABLE T_DICA 
    ( 
     id_dica                 NUMBER  NOT NULL , 
     T_TIPO_EVENTO_id_evento NUMBER  NOT NULL , 
     titulo_dica             VARCHAR2 (100)  NOT NULL , 
     conteudo_dica           CLOB  NOT NULL , 
     localizacao_dica        VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE T_DICA 
    ADD CONSTRAINT T_DICA_PK PRIMARY KEY ( id_dica ) ;

CREATE TABLE T_ENDERECO 
    ( 
     id_endereco        NUMBER  NOT NULL , 
     bairro_endereco    VARCHAR2 (50)  NOT NULL , 
     cep_endreco        CHAR (9)  NOT NULL , 
     cidade_endereco    VARCHAR2 (50)  NOT NULL , 
     uf_endereco        CHAR (2)  NOT NULL , 
     latitude_endereco  NUMBER (9,6)  NOT NULL , 
     longitude_endereco NUMBER (9,6)  NOT NULL 
    ) 
;

ALTER TABLE T_ENDERECO 
    ADD CONSTRAINT T_ENDERECO_PK PRIMARY KEY ( id_endereco ) ;

CREATE TABLE T_HISTORICO_DENUNCIA 
    ( 
     id_hist                NUMBER  NOT NULL , 
     T_DENUNCIA_id_denuncia NUMBER  NOT NULL , 
     dt_status              DATE  NOT NULL , 
     novo_status            VARCHAR2 (30)  NOT NULL , 
     observacao_config      CLOB  NOT NULL 
    ) 
;

ALTER TABLE T_HISTORICO_DENUNCIA 
    ADD CONSTRAINT T_HISTORICO_DENUNCIA_PK PRIMARY KEY ( id_hist ) ;

CREATE TABLE T_NOTIFICACAO 
    ( 
     id_notificacao        NUMBER  NOT NULL , 
     T_USUARIOS_id_usuario NUMBER  NOT NULL , 
     T_ALERTA_id_alerta    NUMBER  NOT NULL 
    ) 
;

ALTER TABLE T_NOTIFICACAO 
    ADD CONSTRAINT T_NOTIFICACAO_PK PRIMARY KEY ( id_notificacao ) ;

CREATE TABLE T_PREVISAO 
    ( 
     id_previsao            NUMBER  NOT NULL , 
     T_ENDERECO_id_endereco NUMBER  NOT NULL , 
     dt_previsao            DATE  NOT NULL , 
     temperatura_min        NUMBER (5,2)  NOT NULL , 
     temperatura_max        NUMBER (5,2)  NOT NULL , 
     descricao_clima        VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE T_PREVISAO 
    ADD CONSTRAINT T_PREVISAO_PK PRIMARY KEY ( id_previsao ) ;

CREATE TABLE T_TIPO_EVENTO 
    ( 
     id_evento        NUMBER  NOT NULL , 
     nm_evento        VARCHAR2 (50)  NOT NULL , 
     descricao_evento CLOB  NOT NULL 
    ) 
;

ALTER TABLE T_TIPO_EVENTO 
    ADD CONSTRAINT T_TIPO_EVENTO_PK PRIMARY KEY ( id_evento ) ;

CREATE TABLE T_USUARIOS 
    ( 
     id_usuario             NUMBER  NOT NULL , 
     T_ENDERECO_id_endereco NUMBER  NOT NULL , 
     nm_usuario             VARCHAR2 (100)  NOT NULL , 
     email_usuario          VARCHAR2 (100)  NOT NULL , 
     senha_usuario          CHAR (8)  NOT NULL , 
     tipo_usuario           VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE T_USUARIOS 
    ADD CONSTRAINT T_USUARIOS_PK PRIMARY KEY ( id_usuario ) ;

ALTER TABLE T_USUARIOS 
    ADD CONSTRAINT T_USUARIOS_email_usuario_UN UNIQUE ( email_usuario ) ;

ALTER TABLE T_USUARIOS 
    ADD CONSTRAINT T_USUARIOS_senha_usuario_UN UNIQUE ( senha_usuario ) ;

ALTER TABLE T_ALERTA 
    ADD CONSTRAINT T_ALERTA_T_ENDERECO_FK FOREIGN KEY 
    ( 
     T_ENDERECO_id_endereco
    ) 
    REFERENCES T_ENDERECO 
    ( 
     id_endereco
    ) 
;

ALTER TABLE T_ALERTA 
    ADD CONSTRAINT T_ALERTA_T_TIPO_EVENTO_FK FOREIGN KEY 
    ( 
     T_TIPO_EVENTO_id_evento
    ) 
    REFERENCES T_TIPO_EVENTO 
    ( 
     id_evento
    ) 
;

ALTER TABLE T_ALERTA 
    ADD CONSTRAINT T_ALERTA_T_USUARIOS_FK FOREIGN KEY 
    ( 
     T_USUARIOS_id_usuario
    ) 
    REFERENCES T_USUARIOS 
    ( 
     id_usuario
    ) 
;

ALTER TABLE T_CLIMA 
    ADD CONSTRAINT T_CLIMA_T_ENDERECO_FK FOREIGN KEY 
    ( 
     T_ENDERECO_id_endereco
    ) 
    REFERENCES T_ENDERECO 
    ( 
     id_endereco
    ) 
;

ALTER TABLE T_CONFIG_USUARIO 
    ADD CONSTRAINT T_CONFIG_USUARIO_T_USUARIOS_FK FOREIGN KEY 
    ( 
     T_USUARIOS_id_usuario
    ) 
    REFERENCES T_USUARIOS 
    ( 
     id_usuario
    ) 
;

ALTER TABLE T_DADO 
    ADD CONSTRAINT T_DADO_T_ENDERECO_FK FOREIGN KEY 
    ( 
     T_ENDERECO_id_endereco
    ) 
    REFERENCES T_ENDERECO 
    ( 
     id_endereco
    ) 
;

ALTER TABLE T_DENUNCIA 
    ADD CONSTRAINT T_DENUNCIA_T_ENDERECO_FK FOREIGN KEY 
    ( 
     T_ENDERECO_id_endereco
    ) 
    REFERENCES T_ENDERECO 
    ( 
     id_endereco
    ) 
;

ALTER TABLE T_DENUNCIA 
    ADD CONSTRAINT T_DENUNCIA_T_USUARIOS_FK FOREIGN KEY 
    ( 
     T_USUARIOS_id_usuario
    ) 
    REFERENCES T_USUARIOS 
    ( 
     id_usuario
    ) 
;

ALTER TABLE T_DICA 
    ADD CONSTRAINT T_DICA_T_TIPO_EVENTO_FK FOREIGN KEY 
    ( 
     T_TIPO_EVENTO_id_evento
    ) 
    REFERENCES T_TIPO_EVENTO 
    ( 
     id_evento
    ) 
;

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE T_HISTORICO_DENUNCIA 
    ADD CONSTRAINT T_HISTORICO_DENUNCIA_T_DENUNCIA_FK FOREIGN KEY 
    ( 
     T_DENUNCIA_id_denuncia
    ) 
    REFERENCES T_DENUNCIA 
    ( 
     id_denuncia
    ) 
;

ALTER TABLE T_NOTIFICACAO 
    ADD CONSTRAINT T_NOTIFICACAO_T_ALERTA_FK FOREIGN KEY 
    ( 
     T_ALERTA_id_alerta
    ) 
    REFERENCES T_ALERTA 
    ( 
     id_alerta
    ) 
;

ALTER TABLE T_NOTIFICACAO 
    ADD CONSTRAINT T_NOTIFICACAO_T_USUARIOS_FK FOREIGN KEY 
    ( 
     T_USUARIOS_id_usuario
    ) 
    REFERENCES T_USUARIOS 
    ( 
     id_usuario
    ) 
;

ALTER TABLE T_PREVISAO 
    ADD CONSTRAINT T_PREVISAO_T_ENDERECO_FK FOREIGN KEY 
    ( 
     T_ENDERECO_id_endereco
    ) 
    REFERENCES T_ENDERECO 
    ( 
     id_endereco
    ) 
;

ALTER TABLE T_USUARIOS 
    ADD CONSTRAINT T_USUARIOS_T_ENDERECO_FK FOREIGN KEY 
    ( 
     T_ENDERECO_id_endereco
    ) 
    REFERENCES T_ENDERECO 
    ( 
     id_endereco
    ) 
;