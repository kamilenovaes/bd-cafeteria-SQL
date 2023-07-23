# bd-cafeteria-SQL

<b>Atividade:</b>

Considere o modelo conceitual de uma associação de cafeterias conforme abaixo: 

- Cafe (id_preparo, nome_preparo**, puro*)
- Cafeteria (id_cafeteria, nome_fantasia, endereço, instagram)
- Cliente (id_cliente, nome_cliente, email, dt_nascimento)
- Gosta (id_cliente, id_preparo) id_cliente referencia Cliente, 
id_preparo referencia Cafe
- Oferece (id_cafeteria, id_preparo, avaliação***, preço, vegano*,) 
id_cafeteria referencia Cafeteria, 
id_preparo referencia Cafe
- Frequenta (id_cliente, id_cafeteria) id_cliente referencia Cliente, 
id_cafeteria referencia Cafeteria

      *Atributos que podem valer S (sim) ou N (não) ** Por preparo entenda-se modos de preparar/servir o café como espresso, capuccino, café latte, afogato, etc.. *** Avaliação é uma nota de 1 a 5, sendo 5 mais bem conceituado, com uma decimal.
  
1) Faça o script para criar o banco Cafeterias conforme o modelo acima. Os campos id 
nas tabelas Café, Cafeteria e Cliente são autoincrementais. Os atributos preço e 
avaliação são numéricos, data de nascimento que é do tipo date, demais são varchar.

2) Faça o script para popular as tabelas conforme os dados abaixo:

- a. Os cafés espresso, doppio e cold brew são puros. Já o capuccino, afogato e o 
café latte não são puros, vai leite, sorvete ou chantilly no seu preparo.

- b. Fazem parte da associação as cafeterias Cafeína, Cafezal, Cat Café, Café com 
pão (demais atributos, preenchimento livre).

- c. Os clientes são:

 i. Antonio, que gosta dos cafés puros e de capuccino. O email dele é 
antonio@cafe.org e nasceu em 22/07/1980.

 ii. Alice, nasceu em 15/01/1994, seu email é alice@gmail.com. Alice toma 
espresso, doppio, cold brew e afogato de vez em quando.

 iii. Regina prefere capuccino e café latte. Nasceu em 01/07/1999 e seu 
email é regina@yahoo.com. 

 iv. Guilherme curte os cafés frios: cold brew e afogato. Seu email é 
iceland@gmail.com e nasceu em 22/10/2000.

 v. Marcelo, como profissional de TI, gosta de todos cafés! Ele nasceu em 
08/01/1995 e o email? Imagina! Só podia ser marcelo@id.uff.br!

- d. Os cafés que cada cafeteria oferece são (preço e avaliação entre parênteses):

 i. Cafeína: espresso (R$6.50 com avaliação 4.9), doppio (R$8.9 com 
avaliação 4.7), capuccino (R$11.50 com avaliação 4.2) e o café latte
(R$11 com avaliação 3.9). Os dois últimos na opção vegana.

 ii. Cafezal: espresso (R$5.90 com avaliação 4.5), doppio (R$8.50 com 
avaliação 4.3), cold brew (R$16 com avaliação 3.9), capuccino (R$11.00 
com avaliação 4.8), o café latte (R$10 com avaliação 3.5) e afogato
(R$15 com avaliação 4.5).

 iii. Cat Café: espresso (R$6.90 com avaliação 4.3), doppio (R$9 com 
avaliação 3.9), cold brew (R$15 com avaliação 3.7), capuccino (R$12.00 
com avaliação 4.5), afogato(R$16 com avaliação 4.6) e o café latte (R$ 
12 com avaliação 4), sendo os três últimos na opção vegana.

 iv. Café com pão: espresso (R$5.50 com avaliação 3.9), capuccino 
(R$10.00 com avaliação 3.5) e o café latte (R$8 com avaliação 3.5).

- e. As cafeterias que cada cliente frequenta são:

 i. Cafeína é frequentada por Alice, Antonio e Marcelo.
 
 ii. Quem frequenta a Cafezal são Marcelo, Regina e Alice.
 
 iii. Cat Café: Regina e Marcelo.
 
 iv. Café com pão: Antonio.


3) Responda as perguntas abaixo com comandos SQL: 

- a. O Antonio adora tomar capuccino e quer fazer uma degustação. Listar o nome, 
endereço, instagram, avaliação e preço das cafeterias que servem os 
capuccinos mais bem avaliados da cidade (conceito entre 4 e 5), em ordem 
decrescente de avaliação.

- b. Já Alice é vegana e procura companhia para tomar café e conversar sobre 
veganismo. Liste os demais (que não a Alice) clientes que frequentam as
cafeterias que servem cafés veganos. 

- c. O Cat Café fará uma promoção para o lançamento do café ‘Garfield’, que é 
como chamam o afogato (nome_preparo) e deseja enviar uma mensagem 
para seus frequentadores que ainda não “gostam” deste preparo. Liste nome e 
e-mail destes clientes.

- d. A dona do Cafezal pensa em reajustar valores e quer comparar o preço do 
espresso (nome_preparo) da Cafezal com as demais cafeterias. Listar
nome_fantasia, preço e avaliação das cafeterias que vendem ‘espresso’ com 
preço acima do que o Cafezal pratica.

- e. Por causa do aumento, a Cafezal quer oferecer um brinde para os seus 
frequentadores que aniversariam em julho. Liste nome e e-mail destes clientes 
com o nome dos preparos que eles gostam concatenados em uma string.

- f. A Cafeína precisa aumentar o preço dos seus cafés “puros” em 8% e os “não 
puros” em 5%. 

- g. A Café com Pão vai sair da associação. Apagar todos os dados referentes a ela.

- h. A associação vai realizar uma pesquisa entre os frequentadores para coletar a 
avaliação de cada cafeteria. Incluir um atributo, nas mesmas condições que a 
avaliação dos cafés, para receber esta informação
