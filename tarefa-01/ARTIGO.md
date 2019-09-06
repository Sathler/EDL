## Origens e Influências

Inicialmente PHP se referia a "Personal Home Page Tools", um conjunto de scripts CGI escritos em linguagem C desenvolvidos por Rasmus Lerdof em 1994 com o propósito de acompanhar visitas em seu currículo online. Em 1995, Rasmus liberou seu código fonte ao público.

Com o aumento da demanda por aplicações web simples e dinâmicas e com o apoio de usuários na correção de bugs o PHP se expandiu, estando presente em centenas de milhões de domínios atualmente.

A linguagem PHP foi desenvolvida propositalmente para ser parecida com a linguagem C, tornando fácil a adoção de desenvolvedores habituados com essa linguagem e outras similares, foi influenciada também pelas linguagens Perl e Java e possui sintaxe HTML embutida. 

## Classificação

PHP é um linguagem interpretada, imperativa, funcional, orientada a objeto, procedural e de tipagem fraca e dinâmica.

Apesar de possuir aplicações em outras áreas, a liguagem PHP é utilizada principalmente em desenvolvimento *server-side* web, sendo executado junto à um servidor web. 

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
echo $fieldNome->getValue($usuario).' '.$fieldRG->getValue($usuario);
?>
```

Deve-se observar que mesmo após a mudança de acessibilidade esses campos apenas são acessiveis através da classe de reflexão e seus métodos, não sendo possível obte-los de maneira direta.

## Referências

[PHP.net](https://www.php.net/manual/pt_BR/history.php.php)
[en.wikipedia.org/wiki/Reflection_(computer_programming)](https://en.wikipedia.org/wiki/Reflection_(computer_programming))