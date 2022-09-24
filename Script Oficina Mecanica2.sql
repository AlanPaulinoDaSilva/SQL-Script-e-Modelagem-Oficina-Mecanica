/*Criação do Banco de dados para o cenário de Oficina Mecânica*/

create database oficina_mecanica;

use oficina_mecanica;

create table ordem_serviço(
		id_ordem_serviço int not null auto_increment primary key,
        data_emissão date,
        valor_peça decimal,
        valor_serviço decimal,
        valor_total decimal default 0,
        status_on enum ('Aprovada', 'Reprovada', 'Aguardando Peças', 'Aguardando Aprovacão', 'Em execução', 'Concluida'),
        previsao_entrega date,
        id_cliente int,
        id_equipe_responsavel int,
        id_serviço int,
        constraint fk_serviço foreign key(id_serviço) references serviço(id_serviço),
        constraint fk_cliente foreign key(id_cliente) references cliente(id_cliente)
);
alter table ordem_serviço auto_increment=1;   
alter table ordem_serviço
change status status_os enum ('Aprovada', 'Reprovada', 'Aguardando Peças', 'Aguardando Aprovacão', 'Em execução', 'Concluida');




insert into ordem_serviço(data_emissão,valor_peça,valor_serviço,valor_total,status_os,previsao_entrega,id_equipe_responsavel)values
		('20220812','300','100',valor_peça+valor_serviço,'Em execução','20220810','1'),
        ('20220108','400','200',valor_peça+valor_serviço,'Em execução','20220809','1'),
        ('20220811','500','300',valor_peça+valor_serviço,'Aguardando Peças','20220811','1'),
        ('20220811','600','400',valor_peça+valor_serviço,'Concluida','20220812','01');
        
select * from ordem_serviço;      

create table cliente(
		id_cliente int not null auto_increment primary key,
        Pnome varchar(10),
        Sobrenome varchar(45),
        CPF char(11) not null, 
        CNPJ varchar(20),
        Rua varchar(20) not null,
        Bairro varchar(10),
        Cidade varchar(20) not null,
        Cep char(8) not null,
        Estado char(2) not null,
        Telefone varchar(15),
        email varchar(30),
        constraint unique_cpf_cliente unique (CPF)
);

insert into cliente (Pnome,Sobrenome,CPF,CNPJ,Rua,Bairro,Cidade,Cep,Estado,Telefone,email) values
		('Anderson','Paulino','29147767700','189189228983','Venezuela','Vila','Santos','11702110','SP','13981351212','teste@teste'),
		('Adriano','Paulino','29147747701','189189228987','São Paulo','Margarida','São Paulo','11702444','SP','13981351222','adriano@teste'),
        ('Alex','Paulino','29147747702','189189228986','Valentin','Vila','Santos','11702110','SP','13981351212','alex@teste'),
        ('Stefania','Paulino','29147747703','189189228984','Escobar','Vila','Santos','11702110','SP','13981351222','stefania@teste');     

select * from cliente;

alter table cliente auto_increment=1;         
        
create table veiculos(
		id_veiculo int not null auto_increment primary key,
        Placa varchar(10) not null,
        marca varchar(10),
        modelo varchar(10),
        ano varchar(10),
        id_equipe_avaliaçao int,
        cliente_id_cliente int,
        constraint pk_cliente_veiculo foreign key (cliente_id_cliente) references cliente(id_cliente),
        constraint pk_equipe_id_avalia foreign key (id_equipe_avaliaçao) references equipes_mecanica(id_equipe)
);
alter table veiculos auto_increment=1; 

insert into veiculos(Placa,marca,modelo,ano,cliente_id_cliente)values
		('AAA-1010','VW','FOX','2014','1'),
        ('BBB-1010','GM','CELTA','2018','2'),
        ('CCC-1010','FIAT','PALIO','2020','3'),
        ('DDD-1010','FORD','FIESTA','2012','4');

 
select * from veiculos;

 
create table serviço(
		id_serviço int not null auto_increment primary key,
        id_equipe_responsavel int,
        id_ordem_serviço int,
        id_cliente int,
        valor_serviço decimal,
        constraint fk_cliente_serviço foreign key(id_cliente) references cliente(id_cliente),
        constraint fk_equipe_responsavel foreign key(id_equipe_responsavel) references equipes_mecanica(id_equipe)
);
alter table serviço auto_increment=1; 
insert into serviço(id_ordem_serviço,id_cliente,valor_serviço)values
		('1','1','100'),
        ('2','2','200'),
        ('3','3','300'),
        ('4','4','400');
        
 select * from serviço;
 
 
create table peça(
		id_peça int not null auto_increment primary key,
        nome_peça varchar(45),
        fabricante varchar(45),
        valor decimal,
        marca_modelo_veiculo varchar(45) default 'Universal',
        quantidade int,
        id_ordem_serviço int,
        id_cliente int,
        constraint fk_os_serviço foreign key(id_ordem_serviço) references ordem_serviço(id_ordem_serviço),
        constraint fk_os_clientes foreign key(id_cliente) references cliente(id_cliente)
        
);
/*alter table peça auto_increment=1;     
alter table peça add column quantidade_consumida int after quantidade;
alter table peça drop column quantidade_consumida;
alter table peça
change quantidade quantidade_comprada_estoque int;*/

 insert into peça(nome_peça,fabricante,valor,marca_modelo_veiculo,quantidade_comprada_estoque,quantidade_consumida,id_ordem_serviço,id_cliente)values
		('Pastilha de freio','Tecnical','100',default,'100','1','1','1'),
        ('Pneu 175/65R14','Pirelli','350',default,'100','4','2','2'),
        ('Amortecedor','Cofap','250',default,'100','4','3','3'),
        ('Oleo Mineral','Bardal','30',default,'100','4','4','4');

select * from peça;        
 
 create table mecanicos(
		id_mecanico int not null auto_increment primary key,
        nome varchar(45),
        endereço varchar(100),
        especialidade varchar(45),
        id_equipe_mecanica int,
        constraint fk_equipe_mecanica foreign key(id_equipe_mecanica) references equipes_mecanica(id_equipe)
 );
 alter table mecanicos auto_increment=1;            
 
 
 insert into mecanicos(nome,endereço,especialidade)values
		('Valmir','Rua dos Altos,22 Vila- São Paulo-SP','Suspensão'),
        ('Pedro','Rua dos Baixos,20 Vila- São Paulo-SP','Freios'),
        ('Alexandre','Rua do Meio,12 Vila- São Paulo-SP','Alinhamento'),
        ('José','Rua do Caminho,25 Vila- São Paulo-SP','Troca Óleo');
        
select * from mecanicos;
        
create table equipes_mecanica(
		id_equipe int not null auto_increment,
        id_mecanico int,
        primary key (id_equipe,id_mecanico)
);         
/*alter table equipes_mecanica auto_increment=1;               
alter table equipes_mecanica add column especialidade_equipe varchar(40);      
alter table equipes_mecanica drop id_equipe;
update equipes_mecanica set especialidade_equipe='Eletrica' where id_mecanico='4'; */
      

 insert into equipes_mecanica(id_mecanico,especialidade_equipe)values
		('1','Manutenção'),
        ('1','Manutenção'),
        ('2','Revisão'),
        ('2','Revisão');

select * from equipes_mecanica;       

show tables;    
   
   
/*--------------------CONSULTAS SQL NO BANCO DE DADOS DE OFICINA MECÂNICA----------------------*/   
   
/* Consulta de Ordem de serviço usando Junçoes com INNER JOIN entre 4 Tabelas*/
select concat(pnome,' ',sobrenome)as Cliente, especialidade_equipe as "Serviço Executado", placa, concat(marca,'/', modelo) as Veiculo, 
			status_os , previsao_entrega, valor_peça, valor_serviço, valor_total  
            from cliente as c inner join veiculos
            on id_cliente=cliente_id_cliente
            inner join ordem_serviço as os
            on c.id_cliente=os.id_cliente
            inner join equipes_mecanica
            on id_equipe_responsavel=id_equipe
            order by previsao_entrega;

/*Consulta para saber quem foi o mecanico responsavel pelo serviço + resultados da da Busca de Cliente, Veiculo, Ordem_serviço, Equipes_mecanica,Mecanico */
select concat(pnome,' ',sobrenome)as Cliente, especialidade_equipe as "Serviço Executado", nome as "Mecânico Responsável", placa, concat(marca,'/', modelo) as Veiculo, 
			status_os , previsao_entrega, valor_peça, valor_serviço, valor_total  
            from cliente as c inner join veiculos
            on id_cliente=cliente_id_cliente
            inner join ordem_serviço as os
            on c.id_cliente=os.id_cliente
            inner join equipes_mecanica
            on id_equipe_responsavel=id_equipe
            inner join mecanicos
            on id_equipe_mecanica=id_equipe
            order by previsao_entrega;
 
 
 /*Consulta pra saber quais Ordens de serviço e seus respectivos clientes ainda estão em execução e sua previsão de entrega*/
select concat(pnome,' ',sobrenome)as Cliente, especialidade_equipe as "Serviço Executado", nome as "Mecânico Responsável", placa, concat(marca,'/', modelo) as Veiculo, 
			status_os , previsao_entrega 
            from cliente as c inner join veiculos
            on id_cliente=cliente_id_cliente
            inner join ordem_serviço as os
            on c.id_cliente=os.id_cliente
            inner join equipes_mecanica
            on id_equipe_responsavel=id_equipe
            inner join mecanicos
            on id_equipe_mecanica=id_equipe
            where status_os='Em execução'
            order by previsao_entrega;
            
            