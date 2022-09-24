

Banco de dados de uma Oficina Mecânica

Scripts para gerar as Tabelas e suas respectiva entidades estão em sequencia dos scripts de inserções de dados.

No final estão os scripts de consultas as tabelas 

Os scripts de criação de tabelas, inserções de dados e também de consultas estão no mesmo arquivo para melhor entendimento.





Descrição do funcionamento do modelo de negócio do Banco de Dados da Oficina.

Sistema de controle e gerenciamento de execução de ordens de serviço em uma oficina mecânica
Clientes levam veículos à oficina mecânica para serem consertados ou para passarem por revisões periódicas
Cada veículo é designado a uma equipe de mecânicos que identifica os serviços a serem executados e preenche uma OS com data de entrega.
A partir da OS, calcula-se o valor de cada serviço, consultando-se uma tabela de referência de mão-de-obra
O valor de cada peça também irá compor a OS.
O cliente autoriza a execução dos serviços
A mesma equipe avalia e executa os serviços
Os mecânicos possuem código, nome, endereço e especialidade
Cada OS possui: n°, data de emissão, um valor, status e uma data para conclusão dos trabalhos.


