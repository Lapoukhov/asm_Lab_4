## fasm Lab_4
### Task:
Make 3 programs:
1. Program 1. Passing parameters through the register. Type of procedure - distant.
2. Program 2. Parameter transfer via global variables. Type of procedure - distant.
3. Program 3. Passing parameters through the stack. Type of procedure is near.


### Code:

```
     org 100h

ch1 dw 10
ch2 dw 1
ch3 dw 12

start:
      mov ax,word[ch1]    ;маска слово
      call output
      call ent            ;вывод числа 1
      mov ax,word[ch2]
      call output
      call ent            ;вывод числа 2
      mov ax,word[ch3]
      call output
      call ent            ;вывод числа 3

      mov ax,word[ch1] ;c
      mov cx,word[ch2] ;d
      mov bx,word[ch3] ;e

      call registr1      ;передача параметров через регистр
      call ent           ;вывод результата вычислений
      call global        ;передача параметров через глобальные переменные
      call ent
      push word[ch1]     ;помещаем число 1 в стек
      push word[ch2]     ;помещаем число 2 в стек
      push word[ch3]     ;помещаем число 2 в стек
      call stek1         ;передача параметров через стек

      call pressanykey
      ret

stek1:
      mov bp,sp ;передача параметров из стека
      mov ax, [bp+6] ;в cx число 2
      mov bx, [bp+2] ;в ax число 1
      mov cx, [bp+4]

      add ax,cx  ;с+d
      sub bx,6   ;e-6
      mul bx     ;*
      mov ax, bx
      sal ax, 2
      call output
      ret 6      ;завершение процедур

global:
     mov ax,[ch1] ;помещаем в ax число 1
     mov cx,[ch2] ;помещаем в cx число 2
     mov bx,[ch3]

     add ax,cx  ;с+d
     sub bx,6   ;e-6
     mul bx     ;*
     mov ax, bx
     sal ax, 2
     call output
     ret

registr1:
     add ax,cx  ;с+d
     sub bx,6   ;e-6
     mul bx     ;*
     mov ax, bx
     sal ax, 2
     call output
     ret

ent:
     mov ah, 02h
     mov dl, 10
     int 21h

     mov ah, 02h
     mov dl, 13
     int 21h
     ret

output:
      mov bx,ax
      xor cx,cx
      mov bx, 10

oi2:
      xor dx,dx
      div bx
      push dx
      inc cx

      test ax,ax
      jnz oi2

      mov ah,02h
oi3:
      pop dx
      add dl,'0'
      int 21h

      loop oi3
      ret

pressanykey:
     push ax
     mov ax,0c08h
     int 21h
     test al,al
     jnz @F
     mov ah,08h
     int 21h
@@:
     pop ax
     ret
```
