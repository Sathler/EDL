## Origens e Influências

Inicialmente PHP se referia a "Personal Home Page Tools", um conjunto de scripts CGI escritos em linguagem C desenvolvidos por Rasmus Lerdof em 1994 com o propósito de acompanhar visitas em seu currículo online. Em 1995, Rasmus liberou seu código fonte ao público.

Com o aumento da demanda por aplicações web simples e dinâmicas e com o apoio de usuários na correção de bugs o PHP se expandiu, estando presente em centenas de milhões de domínios atualmente.

A linguagem PHP foi desenvolvida propositalmente para ser parecida com a linguagem C, tornando fácil a adoção de desenvolvedores habituados com essa linguagem e outras similares, foi influenciada também pelas linguagens Perl e Java e possui sintaxe HTML embutida. 

## Classificação

PHP é um linguagem interpretada, imperativa, funcional, orientada a objeto, procedural e de tipagem fraca e dinâmica.

Apesar de possuir aplicações em outras áreas, a liguagem PHP é utilizada principalmente em desenvolvimento *server-side* web, sendo executado junto à um servidor web.

## Array em PHP

Array em PHP funciona como uma mapa que relaciona chaves e valores, onde as chaves podem ser tanto valores inteiros quanto strings, e os valores podem ser de qualquer tipo suportado em PHP, desde valores inteiros e strings até outros arrays e objetos.

Internamente um array em PHP funciona como uma hashtable com encadeamento exterior
```PHP
$array = [ 27,                   
		   1.8,                  
		   "chave" => "valor",   
		   9 => [1,2,3,"quatro"]
		 ];

```

A implementação de tal estrutura é complicada, mas pode ser encontrada nas referências.

## Comparação com outras linguagens

Uma importante funcionalidade da liguagem PHP se chama reflexão, que é a capacidade do programa de observar e modificar sua própria estrutura e comportamento em tempo de execução. Tal ação é impossível em outras linguagens orientadas a objeto sem suporte a reflexão, como por exemplo, C++;

Uma opção possível para linguagens com suporte a programação reflexiva é acessar campos que a princípio não seriam acessíveis ao programador, como por exemplo:

```c++
class Pessoa{
	private:
	int RG;
	string nome;

	public:
	Pessoa(int rg, string nome){
		this->RG = rg;
		this->nome = nome;	
	}
};

int main(){
	Pessoa Usuario(123456789, "Bruce Wayne");
	cout << Usuario.nome << ' ' << Usuario.RG << endl;
}
```
O programa acima retornará um erro em tempo de compilação, já que os campos "nome" e "rg" são inacessíveis fora da classe em que estão definidos, sendo necessário a inclusão de métodos de classe para realizar tal ação.

```c++
class Pessoa{
	private:
	int RG;
	string nome;

	public:
	Pessoa(int rg, string nome){
		this->RG = rg;
		this->nome = nome;	
	}

	string getNome(){
		return this->nome;	
	}

	int getRG(){
		return this->RG;
	}
};

int main(){
	Pessoa Usuario(123456789, "Bruce Wayne");
	cout << Usuario.getNome() << ' ' << Usuario.getRG() << endl;
}
```
Através da programação reflexiva presente no PHP é possível acessar tais campos sem a necessidade de tais métodos, isso é especialmente vantajoso quando o programador não possui acesso à implementação de tais classes.

```PHP
<?php

class Pessoa{
	private $RG;
	private $nome;
	
	function __construct($rg, $nome){
		$this->RG = $rg;
		$this->nome = $nome;
	}
}

//o objeto reflectionClass armazena informações sobre a classe Pessoa 
$reflectionClass = new ReflectionClass("Pessoa");

//criando uma nova instancia de Pessoa a partir de reflectionClass
$usuario = $reflectionClass->newInstance(123456789, "Bruce Wayne");

//o metodo getProperty retorna não o valor, mas informações sobre campo da classe refletida em reflection class
$fieldNome = $reflectionClass->getProperty("nome");
$fieldRG = $reflectionClass->getProperty("RG");

//mudando a permissao de acesso aos campos escolhidos
$fieldNome->setAccessible(true);
$fieldRG->setAccessible(true);

//acessando valores antes inacessiveis
echo $fieldNome->getValue($usuario).' '.$fieldRG->getValue($usuario);//Bruce Wayne 123456789
?>
```

Deve-se observar que mesmo após a mudança de acessibilidade esses campos apenas são acessiveis através da classe de reflexão e seus métodos, não sendo possível obte-los de maneira direta.

É também possível modificar o valor destes campos.

```PHP
//mudando o valor do campo 
$fieldNome->setValue($usuario, "Clark Kent");

echo $fieldNome->getValue($usuario).' '.$fieldRG->getValue($usuario);//Clark Kent 123456789
```
Tambem é possível acessar métodos antes inacessíveis.

```PHP
class Pessoa{
	private $RG;
	private $nome;
	
	function __construct($rg, $nome){
		$this->RG = $rg;
		$this->nome = $nome;
	}
	
	private function whoHeIs(){
		$herois = ["Clark Kent" => "Super Man", "Bruce Wayne" => "Batman", "Diana Prince" => "Mulher-Maravilha"];
		if(isset($herois[$this->nome])){
			return $herois[$this->nome];
		}
		else{
			return "Pessoa comum";
		}
	}
}

//o objeto reflectionClass armazena informações sobre a classe Pessoa 
$reflectionClass = new ReflectionClass("Pessoa");

//criando uma nova instancia de Pessoa a partir de reflectionClass
$usuario = $reflectionClass->newInstance(123456789, "Bruce Wayne");

//method recebe um objeto reflectionMethod
$method = $reflectionClass->getMethod("whoHeIs");

//mudando acesso ao metodo
$method->setAccessible(true);

//chamando o metodo para o objeto antes instanciado
echo $method->invoke($usuario); //Batman 
```

## Referências

[PHP.net](https://www.php.net/manual/pt_BR/history.php.php)\
[en.wikipedia.org/wiki/Reflection_(computer_programming)](https://en.wikipedia.org/wiki/Reflection_(computer_programming))\
[Nikic](https://nikic.github.io/2012/03/28/Understanding-PHPs-internal-array-implementation.html)