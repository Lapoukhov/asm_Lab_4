     org 100h

ch1 dw 10
ch2 dw 1
ch3 dw 12


start:

      mov ax,word[ch1]    ;����� �����
      call output
      call ent            ;����� ����� 1
      mov ax,word[ch2]
      call output
      call ent            ;����� ����� 2
      mov ax,word[ch3]
      call output
      call ent            ;����� ����� 3

      mov ax,word[ch1] ;c
      mov cx,word[ch2] ;d
      mov bx,word[ch3] ;e

      call registr1      ;�������� ���������� ����� �������
      call ent           ;����� ���������� ����������
      call global        ;�������� ���������� ����� ���������� ����������
      call ent
      push word[ch1]     ;�������� ����� 1 � ����
      push word[ch2]     ;�������� ����� 2 � ����
      push word[ch3]     ;�������� ����� 2 � ����
      call stek1         ;�������� ���������� ����� ����

      call pressanykey
      ret


stek1:
      mov bp,sp ;�������� ���������� �� �����
      mov ax, [bp+6] ;� cx ����� 2
      mov bx, [bp+2] ;� ax ����� 1
      mov cx, [bp+4]

      add ax,cx  ;�+d
      sub bx,6   ;e-6
      mul bx     ;*
      mov ax, bx
      sal ax, 2
      call output
      ret 6      ;���������� ��������

global:

     mov ax,[ch1] ;�������� � ax ����� 1
     mov cx,[ch2] ;�������� � cx ����� 2
     mov bx,[ch3]

     add ax,cx  ;�+d
     sub bx,6   ;e-6
     mul bx     ;*
     mov ax, bx
     sal ax, 2
     call output
     ret

registr1:
     add ax,cx  ;�+d
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


