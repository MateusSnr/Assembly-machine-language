;
; Ex01ProvaP2.asm
;
; Created: 30/05/2023 19:33:11
; Author : Desktop
;


; Replace with your application code
.org 0x0000 ;Início do programa

start: ;loop de inicialização
	ldi r16, 0b11110011 ;Armazendo o valor 0 que indica porta de recebimento de dados nos pinos pb2 pb3.
	out ddrb, r16 ;Setando os pinos 16 e 17 como entrada de dados.

	ldi r17, 0b00011100 ;Armazenando o valor 1 que indica envio de dados nos pinos pd2 pd3 e pd4.
	out ddrd, r17 ; Setando os pinos 4 5 e 6. 

loop: ;void loop
	rcall verificaChaveAeBPress
	rcall verifcaChaveAeBNaoPress
	rcall verificaChaveBPress
	rcall verificaChaveAPress

ligaLedA:
	sbi pind,2 ;set bit in ( setando como um );ligando o led a
	cbi pind,3 ;clear bit ( apagando o bit ); apagando o led b
	cbi pind,4; apagando o led c
	rcall armazenaSRAM
	rjmp loop ;retorna para o loop de verificacao

ligaLedB:
	cbi pind,2
	sbi pind,3
	cbi pind,4
	rcall armazenaSRAM
	rjmp loop

ligaLedAeC:
	sbi pind,2
	cbi pind,3
	sbi pind,4
	rcall armazenaSRAM
	rjmp loop

ligaLedBeC:
	cbi pind,2
	sbi pind,3
	sbi pind,4
	rcall armazenaSRAM
	rjmp loop

verificaChaveAeBPress:
	sbis pinb,2; skip if bit is set (pule se o bit estiver setado). Vai verificar se pb2 esta setado .Se estiver setado,o programa vai pular a linha de baixo
	ret
	sbis pinb, 3;
	ret
	rjmp ligaLedA ;chama a função ligaLed1

verificaChaveAeBNaoPress:
	sbic pinb,2;skip if bit is clear (pule se o bit estiver zerado). No caso se a chave não estiver pressionada
	ret
	sbic pinb,3
	ret
	rjmp ligaLedB

verificaChaveBPress:
	sbic pinb,2
	ret
	sbis pinb,3
	ret
	rjmp ligaLedAeC

verificaChaveAPress:
	sbis pinb,2
	ret
	sbic pinb,3
	ret
	rjmp ligaLedBeC

armazenaSRAM:
	in r18,portb
	in r19,portc
	in r20,portd

	sts 0x1100, r18
	sts 0x1200, r19
	sts 0x1300, r20

	ret


	


	

	


