#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/*
ELC117 Paradigmas de programação - Trabalho 1
Rafael Sebastião Miranda    12/08/2015
Engenharia de Controle e Automação
*/


/*
 Romualdo é o chefe da equipe de estagiários à qual você pertence. Hoje, o Romualdo chegou todo apressado dizendo que precisava de ajuda,
 rápido! Ele descobriu que usuários tiveram suas contas hackeadas no servidor SSH da empresa e precisava tomar providências. Disse ele:
 "Aqui está uma lista de logins. Preciso descartar os logins com mais de 8 caracteres, pois estes não foram hackeados. Nos demais logins,
 preciso adicionar o sufixo "@mycompany.com" e ordená-los em ordem alfabética. Vou ter que usar essa lista depois para mandar e-mails e
 fazer outras operações no sistema.".

 Você é um(a) estagiário(a) que só sabe programar em C. Você consegue fazer um programa para ajudar o Romualdo?
*/

int main(int argc, char *argv[]) {
	
	// Criação da lista (randômica)
    
	int ListSize;
    srand( (unsigned)time(NULL) );
	ListSize = 50 + rand()%51; // Tamanho da lista entre 50 e 100 nomes
    
    typedef struct { // definição da estrutura
    	char login[23]; // 8 + "@mycompany.com"  + \0
    	void *next;
    } lista;
    
    lista *Root;
    Root= malloc(sizeof(lista));
    
    lista *pointer = Root; // início da lista
    
    // preencher logins
    int i;
    for(i=0;i<ListSize;i++){
    	int LoginSize = 3 + rand()%14; // tamanho do login i (mínimo 3, máximo 16 caracteres)
    	int j;
		for(j=0;j<LoginSize;j++){
    		pointer->login[j]=97+rand()%26; // somente letras minusculas
    	}
    	pointer->login[j]=0;
    	
    	if(i!=(ListSize-1)) pointer->next = malloc(sizeof(lista)); //alocação de novo membro
    	else pointer->next = NULL; // fim da lista
    	
    	pointer=pointer->next;
    }
	// ------------------------------------------------------------------------------------------
	// Início trabalho (in fact)
	
	if(Root!=NULL){ // special case (descarta logins com mais de 8 digitos do início da lista)
		while (strlen(Root->login)>8){
			lista *temp;
			temp = Root;
			Root = Root->next;
			free(temp);
			if(Root==NULL) break;
		}
	}
	
	// descarte e concatenação ao longo de toda lista
	pointer = Root;
	lista* tail = NULL;
	
	while(pointer!=NULL){
    	if (strlen(pointer->login)>8){ // Descarta login com mais de 8 char
    		lista *temp;
			temp = pointer;
			tail->next = pointer->next;
			pointer = pointer->next;
			free(temp); // libera espaço na memória
    	}
    	else{ // adição do email
    		strcat(pointer->login,"@mycompany.com");
    		tail = pointer;
			pointer=pointer->next;
    	}
    }
	tail = NULL;
	
	// organizando lista
	
	if(Root!=NULL){
		if(Root->next!=NULL){ // pelo menos dois valores na lista
			lista* newroot = NULL;
			lista* Menor = Root->next;
			tail = Root;
			
			// Método de organização não eficiente, mas simples e prático na situação hipotética para listas de tamanhos realistas
			// Em teste demorou menos de 10s para uma lista de 50 mil nomes
			// Busca o login com valor mais baixo, remove-o da lista original e coloca em uma nova
			while(Root->next!=NULL){
				// Busca do menor login
				Menor = Root;
				pointer = Root;
				while(pointer->next!=NULL){
					lista* aux = pointer->next;
	    			if(strcmp(Menor->login,aux->login)>0){ // pode-se suportar caixa alta utilizando a função tolower() em ambos lados da comparação
						Menor = pointer->next;
	    				tail = pointer;
	    			}
	    			pointer = pointer->next;
	    		}
	    		
	    		//Reposicionamento
				// firstcase
	    		if(newroot==NULL){
	    			newroot = Menor;
	    		}
				// following cases
				else{
					pointer = newroot;
	    			while(pointer->next!=NULL) pointer = pointer->next;
	    			pointer->next = Menor;
				}
				// adequação da lista original
				if(Menor==Root) Root = Root->next;	//special case
				else tail->next = Menor->next;
				Menor->next=NULL;
			}
			// alocação do último login
			pointer = newroot;
	    	while(pointer->next!=NULL) pointer = pointer->next;
	    	pointer->next = Root;
	    	Root->next = NULL;
	    	// Lista original aponta para lista ordenada
	    	Root = newroot;
			tail = NULL;	
    	}
	}

	// imprime lista
	pointer = Root;
	while(pointer!=NULL){
    	printf("%s\n",pointer->login);
    	pointer=pointer->next;
    }
	
	// ------------------------------------------------------------------------------------------
	// liberando espaço na memória
	pointer = Root;
	while (pointer!=NULL){
		lista *temp;
		temp = pointer;
		pointer = pointer->next;
		free(temp);
	}
	Root = NULL; 
	
	system("pause");
	return 0;
}
