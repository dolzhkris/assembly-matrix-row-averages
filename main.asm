.model small ; razmer koda i dannih ne previshaet 64 kb
.stack 100h ; razmer steka 256 bait(100h v 16richnoi sys)

.data ; nachalo segmenta dannih 
    array db 9 dup(0)   ; mass 3x3
    avg1 db ?           ; average 1 row
    avg2 db ?           ; average 2 row
    avg3 db ?           ; average 3 row
    message db 'Enter elements of the array 3x3:', 0Dh, 0Ah, '$' ; sms dlya vvoda elementov (0Dh, 0Ah perevod karetki i nachalo s new row)
    result1 db 'Average of row 1: $' ; sms dlya average 1
    result2 db 'Average of row 2: $' ; sms dlya average 2
    result3 db 'Average of row 3: $' ; sms dlya average 3
    newline db 0Dh, 0Ah, '$' ; vivod pustoi row

    .code ; nachalo koda
start: ; metka nachala prog
    mov ax, @data ; zagruzka adresa segmenta dannih v reg ax
    mov ds, ax ; ustanovka segmenta dannih (bez nee prog ne smozhet obrash k svoim peremennim)

    ; vivod mess o vvode elementov
    mov ah, 09h ; dos dlya vivoda stroki 
    lea dx, message ; zagruzka adresa sms v reg dx
    int 21h ; vizov preriv dos

    ; vvod elementov 
    mov si, offset array ; ukazatel na nazhalo mass
    mov cx, 9 ; schetchik
input_array: ; metka loop vvoda
    mov ah, 01h ; dos dlya vvoda simvola
    int 21h ; vizov preriv dos
    sub al, '0' ; preobraz v num
    mov [si], al ; sohr chisla v mass
    inc si ; perehod k sled elem
    
    ; vivod pustoi row 
    mov ah, 09h ; dos dlya vivoda stroki
    lea dx, newline ; zagruzka adresa sms v reg dx
    int 21h ; vizov preriv dos
    
    loop input_array ; loop dlya sled znach

    ; calc average
    call calc_averages ; vizov loop

    ; vivod average
    call print_results ; vizov loop

    ; zaverh prog
    mov ah, 4Ch ; vizov dos dlya zaversh prog
xor al, al ; obnulenie reg al
int 21h ; vizov preriv dos

    ; func calc average
calc_averages: ; metka loop calc average
    ; calc average 1
    lea si, array ; ukaz na nach 1 row
    xor ax, ax ; obnulenie reg ax
    mov cx, 3 ; schetchik
    call sum_row ; vizov loop
    mov [avg1], al ; sohr average 1

    ; calc average 2
    lea si, array + 3 ; ukaz na nach 2 row
    xor ax, ax ; obnulenie reg ax
    mov cx, 3 ; schetchik
    call sum_row ; vizov loop
    mov [avg2], al ; sohr average 2

    ; calc average 3
    lea si, array + 6 ; ukaz na nach 3 row
    xor ax, ax ; obnulenie reg ax
    mov cx, 3 ; schetchik
    call sum_row ; vizov loop
    mov [avg3], al ; sohr average 3
    ret ; vozvr iz func

; func sum elem row
sum_row: ; metka calc sum row 
    xor ax, ax ; obnulenie reg ax
sum_loop: ; metka loop sum
    add al, [si] ; dobavlenie elem k sum
    inc si ; perehod k sled elem 
    loop sum_loop ; loop dlya vseh elem row
    mov ah, 0 ; obnul
    mov dl, 3 ; delitel (kol-vo el row)
    div dl ; delit na 3
    ret ; vozvr iz func

; func vivoda result
print_results: ; metka loop print results
    ; vivod pustoi row 
    mov ah, 09h ; dos dlya vivoda stroki
    lea dx, newline ; zagruzka adresa sms v reg dx
    int 21h ; vizov preriv dos
    
    ; vivod average 1
    mov ah, 09h ; dos dlya vivoda stroki
    lea dx, result1 ; zagruzka adresa sms v reg dx
    int 21h ; vizov preriv dos
    mov al, [avg1] ; zagruz average 1 v reg al
    call print_number ; vizov loop

    ; vivod pustoi row 
mov ah, 09h ; dos dlya vivoda stroki
lea dx, newline ; zagruzka adresa sms v reg dx
    int 21h ; vizov preriv dos

    ; vivod average 2
    mov ah, 09h ; dos dlya vivoda stroki
    lea dx, result2 ; zagruzka adresa sms v reg dx
    int 21h ; vizov preriv dos
    mov al, [avg2] ; zagruz average 2 v reg al
    call print_number ; vizov loop

    ; vivod pustoi row 
    mov ah, 09h ; dos dlya vivoda stroki
    lea dx, newline ; zagruzka adresa sms v reg dx
    int 21h ; vizov preriv dos

    ; vivod average 3
    mov ah, 09h ; dos dlya vivoda stroki
    lea dx, result3 ; zagruzka adresa sms v reg dx
    int 21h ; vizov preriv dos
    mov al, [avg3] ; zagruz average 3 v reg al
    call print_number ; vizov loop

    ; vivod pustoi row 
    mov ah, 09h ; dos dlya vivoda stroki
    lea dx, newline ; zagruzka adresa sms v reg dx
    int 21h ; vizov preriv dos
    ret ; vozvr iz func

; func vivoda num
print_number: ; metka loop vivoda num
    add al, '0' ; preobraz simvola v num
    mov dl, al ; peremes num v reg dl
    mov ah, 02h ; dos dlya vivoda simvola
    int 21h ; vizov preriv dos
    ret ; vozvr iz func

    end start ; zaversh prog
