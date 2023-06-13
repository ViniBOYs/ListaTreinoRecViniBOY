create database recuperacaoLista;
use recuperacaoLista;

####################################
# (1) #

create table weapon(
	id bigint not null auto_increment,
    name varchar(100) not null,
    in_game_price int not null,
    magazine_ammo int not null,
    primary key(id)
);

create table skins(
	id bigint not null auto_increment,
    name varchar(100) not null,
    rarity enum("Covert","Classified","Restricted","Mil-Spec"),
    weaponFK bigint not null,
    description varchar(500),
    wear_level enum("Factore New","Minimal Wear","Field-Tested","Well-Worn","Battle-Sacarred"),
	primary key(id),
    foreign key(weaponFK) references weapon(id)
);
####################################
# (2) #

create table cliente(
	idcliente int not null auto_increment,
    nomeCLIENTE varchar(30) not null,
    RG_CLIENTE varchar(20) not null,
    primary key(idcliente)
);

create table vendedor(
	idvendedor int not null auto_increment,
    nomeVendedor varchar(45),
    primary key(idvendedor)

);

create table pedido(
	numPedido int not null auto_increment,
    dataPedido datetime not null default now(),
    valorPedido numeric(10,2) not null,
    vendedor_idVendedor int not null,
    cliente_idCliente int not null,
    primary key(numPedido),
    foreign key(vendedor_idVendedor) references vendedor(idvendedor),
    foreign key(cliente_idCliente) references cliente(idcliente)
);

###################
# (3) #
create table fFornecedor(
	idFornecedor int not null auto_increment,
    nomeFornecedor varchar(45) not null,
    primary key(idFornecedor)
);

create table fPrincipioativo( 
	idPrincipioativo int not null auto_increment,
    nomePrincipioativo varchar(60) not null,
    primary key(idPrincipioativo)
);

create table fMedicamento(
	idMedicamento int not null auto_increment,
    nomeComercial varchar(60) not null,
    idPrincipioativo int not null,
    idFornecedor int not null,
    QtdeEstoque int not null,
    primary key(idMedicamento),
    foreign key(idPrincipioativo) references fPrincipioativo(idPrincipioativo),
    foreign key(idFornecedor) references fFornecedor(idFornecedor)
);

#########################
# (4) # 

create table steamGameId( # Tabela B
	id bigint not null auto_increment,
    steamId varchar(200) not null,
	gameDescripiton varchar(500) not null,
    primary key(id)
);

create table skiins( # Tabela C
	id bigint not null auto_increment,
    name varchar(100) not null,
    rarity enum("Covert","Classified","Restricted","Mil-Spec"),
    weapon varchar(100),
    description varchar(500),
    wear_level enum("Factore New","Minimal Wear","Field-Tested","Well-Worn","Battle-Sacarred"),
	primary key(id)
);

create table csgoPlayer( # Tabela A
	id bigint not null auto_increment,
	steamGameIdFK bigint not null, # Item unico da Tabela B
    primary key(id),
    foreign key(steamGameIdFK) references steamGameId(id)
);

create table skinsPurchaseHistoric( # Tabela AC/ᵈᶜ
	id bigint not null auto_increment,
	csgoPlayerFK bigint not null,
    skinsFK bigint not null,
    datetime datetime not null default now(),
    primary key(id),
    foreign key(csgoPlayerFK) references csgoPlayer(id),
    foreign key(skinsFK) references skiins(id)
);

####################
# (5) #

# Para fazer um tabela que tenha multiplos relacionamentos é nescessário o uso de uma tabela extra onde será feita a união e armazenamento dos dados das tabelas que precisam possuir
# o multiplo relacionamento, um exemplo muito comum de sua aplocação é a criação de tabelas de histórico.

create table produto(
	id bigint not null auto_increment,
    nomeProduto varchar(100) not null,
    primary key(id)    
);

create table prateleira(
	id bigint not null auto_increment,
    NumPrateleira int not null,
    primary key(id)
);

create table PrateleirasDosProdutos(
	id bigint not null auto_increment,
    NumPrateleiraFK bigint not null,
    produtoFK bigint not null,
    primary key(id),
    foreign key(NumPrateleiraFK) references prateleira(id),
    foreign key(produtoFK) references produto(id)
);

##########################
# (6) #
use licencas;
show tables;
#################################
# (A) #
select nome_Razaosocial, cidade, UF from lcliente;
#################################
# (B) #
select *from llicenca
where Numlicenca like "%A%";
#################################
# (C) #
select *from lcliente
where Nome_RazaoSocial like "P%" order by Nome_RazaoSocial asc;
#################################
# (D) #
select *from lcliente
where Nome_RazaoSocial like "%AR" order by Nome_RazaoSocial desc;
#################################
# (E) #
select *from lcliente
where Nome_RazaoSocial like "%Y%" and Nome_RazaoSocial like "%W%";
#################################
# (F) #
select *from llicenca
where ValorAquisicao >= 1200 order by ValorAquisicao asc;
#################################
# (G) #
select *from lcliente
where idCLIENTE between 151 and 199;
#################################
# (H) #
select *from llicenca
where ValorAquisicao between 250 and 500 order by ValorAquisicao asc;
#################################
# (I) #
select *from llicenca
where DtAquisicao > "2008" and ValorAquisicao between 300 and 450 or ValorAquisicao
between 600 and 800;
#################################
# (J) #
select *from lcliente
where UF = "SP" or UF = "RS" or UF = "PR" or UF = "MG";
#################################
# (K) #
select *from lcliente
where UF != "SP" and UF != "RS" and UF != "PR" and UF != "MG";
#################################
# (L) #
insert into lcliente(idCliente, idSetor_FK, idTipo_Empresa_FK, Nome_razaosocial, 
endereco, cidade, uf, cep) values (515,98, 2, "ViniBOY_Enterprise", "AV. Paulista, 4212", "São Paulo", "SP", "1218145");
##################################
# (M) #
insert into lsoftware(idSoftware, nomeSoftware) values (11,"Counter-Strike");
select *from lsoftware;
insert into lversao(idsoftware_FK, versao) values (11, "1.6");
select *from lversao;
##################################
# (N) #
insert into llicenca(numLicenca, idcliente_FK, idSoftware_FK_FK, versao_FK,
DtAquisicao, valoraquisicao) values ("13522AE2", 515, 11, 1.6, "2023-06-11",
3253.00);
select *from llicenca order by idcliente_FK desc;
##################################
# (O) #
update llicenca set valoraquisicao = 3254.00 * 1.125 
where idsoftware_fk_fk = 11;
##################################
# (P) #
select *from ltipo_empresa;
update ltipo_empresa set descricaoTipo = "Governo"
where idTipo_empresa = 6;
##################################
# (Q) #
select l.numlicenca, l.dtaquisicao, l.valoraquisicao, 0.1*l.valoraquisicao as imposto, l.valoraquisicao - 0.1*l.valoraquisicao as valorLiquido from llicenca l
where year(l.dtaquisicao) >= 2011
order by l.dtaquisicao;

##################################
# (R) #
select s.nomesoftware, v.versao from lversao v
join lsoftware s on s.idSOFTWARE = v.idSOFTWARE_FK;
##################################
# (S) #
select count(idcliente) as "Qtde Clientes"from lcliente;
select *from lcliente order by idcliente desc;
##################################
# (T) #
select *from lsoftware;
select s.nomesoftware, l.versao_FK, c.Nome_RazaoSocial, t.descricaotipo, st.nomesetor, l.numlicenca, l.dtaquisicao, l.valoraquisicao from llicenca l
join lsoftware s on s.idsoftware = l.idSOFTWARE_FK_FK
join lcliente c on c.idcliente = l.idcliente_FK
join lsetor st on st.idsetor = c.idsetor_FK
join ltipo_empresa t on t.idtipo_empresa = c.idtipo_empresa_fk;
##################################
# (U) #
select count(*) as "Numero de Licenças Vendidas" from llicenca;
##################################
# (V) #
select count(c.idcliente), c.nome_razaosocial from llicenca l
join lcliente c on c.idcliente = l.idcliente_FK
group by c.idcliente
order by c.nome_razaosocial;




##########################
# (7) #
use recuperacaolista;

create table alunos(
	id_aluno bigint not null auto_increment,
    nome varchar(200) not null,
    numeroDaMatricula varchar(50) not null,
    dataDeNascimento date not null,
    email varchar(100) not null,
    contatoResponsalvel1 varchar(11) not null,
    contatoResponsalvel2 varchar(11) not null,
	primary key(id_aluno)
);

create table curso(
	id_curso bigint not null auto_increment,
    nome varchar(100) not null,
    codigo varchar(500) not null,
    identificacao blob,
    primary key(id_curso)
);

create table disciplinas(
	id_disciplina bigint not null auto_increment,
    nome varchar(100) not null,
    cargaHoraraia int not null,
    codigo varchar(100),
    cursoFK bigint not null,
    primary key(id_disciplina),
    foreign key(cursoFK) references curso(id_curso)
);

########################
# (8) #

create table cargo(
	id bigint not null auto_increment,
    nome varchar(100) not null,
    descricao varchar(100) not null,
    primary key(id)
);

create table funcionario(
	id bigint not null auto_increment,
    nome varchar(150) not null,
    dataDeNascimento date not null,
    cpf varchar(11) not null,
    salario int not null,
    primary key(id)
);

create table departamento(
	id bigint not null auto_increment,
    nomeDepartamento varchar(100) not null,
    codigoFuncionarioFK bigint not null,
    primary key(id),
    foreign key(codigoFuncionarioFK) references funcionario(id)
);

create table ocupacoesFuncionario(
	id bigint not null auto_increment,
    funcionarioFK bigint not null,
    departamentoFK bigint not null,
    cargoFK bigint not null,
    primary key(id),
    foreign key(funcionarioFK) references funcionario(id),
    foreign key(departamentoFK) references departamento(id),
    foreign key(cargoFK) references cargo(id)
);













