
MODEL small
jumps
STACK 100h
DATASEG

; --------------------------
; Your variables here
; --------------------------
CODESEG

; --------------------------
; Your code here
; --------------------------

proc CheckForArrow
WhileSearchArrowLoop:
	xor al, al
	mov ah, 00h ; wait for key press
	int 16h
	in al, 60h
	
	mov [KeyPress], al 
	cmp al, 04bh ;right arrow
	je LeftArrowFound
	cmp al, 04dh ; left arrow 
	je RightArrowFound
	cmp al, 01h ;escape key go back to search or end quiz 
	je EscapeFound
	jmp WhileSearchArrowLoop
LeftArrowFound:
	mov [RightOrLeft], 1
	jmp @@FinishTheProc
rightArrowFound:
	mov [RightOrLeft], 0
	jmp @@FinishTheProc
EscapeFound:
	; return and then one back probably to the drop down menu 
	mov di, 1
@@FinishTheProc:
	ret
endp

Proc Line 
	;looperLine put the legnth of the line
	;y defualt is 174
	;mov to [HorizontalLine] 1 for a horizontal line and si, 1 for right and 0 for left 
	mov cx, [looperLine]
LoopLine:
	push cx
	mov bh, 0h
	mov cx, [x]
	mov dx, [y]
	mov al, [color]
	mov ah, 0ch 
	int 10h
	pop cx
	cmp [HorizontalLine], 1
	je @@MakeHorizontalLine
	sub [y], 2
	jmp @@Finish
@@MakeHorizontalLine:
	cmp si, 1
	je @@RightHorizontalLine
	sub [x], 2
	jmp @@Finish 
@@RightHorizontalLine:
	add [x], 2
@@Finish:
	loop LoopLine
	
	
	ret
endp

proc Slope 
	;looperSlope put the legnth of the slope
	; x put the coordinate for the x slope start
	; put in [SlopeSize] how much slope you need 
	; for left slope put in si 0
	; for right slope put in si 1
	; put in [OppositeRoute] 1 for backward slope and si 1 or 0 for up or down 
	mov cx, [looperSlope]
LoopSlope:
	push cx
	mov bh, 0h
	mov cx, [x]
	mov dx, [y]
	mov al, [color]
	mov ah, 0ch 
	int 10h
	pop cx
	cmp [OppositeRoute], 0
	je @@Continue
@@OppositeRoute:
	add [y], 2
	jmp @@NoDec
@@Continue:
	dec [y]
@@NoDec:
	cmp si, 0
	je @@RightSlope
	mov ax, [SlopeSize]
	add [x], ax
	jmp @@GoLoop
@@RightSlope:
	mov ax, [SlopeSize]
	sub [x], ax 
@@GoLoop:
	loop LoopSlope
	
	ret 
endp

proc Corner 
	mov [OppositeRoute], 0
	mov [HorizontalLine], 0
	mov [SlopeSize], 2
	push ax
	push bx 
	push cx
	push dx 
	push di
	push si 
@@RightSide:
	cmp [QuizOrSearch], 1
	je @@ActuallyDrawingTheRoute
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y] , 164
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'c'
	call PrintColoredChar
	mov al, 'o'
	call PrintColoredChar
	mov al, 'r'
	call PrintColoredChar
	mov al, 'n'
	call PrintColoredChar
	mov al, 'e'
	call PrintColoredChar
	mov al, 'r'
	call PrintColoredChar
@@ActuallyDrawingTheRoute:
	mov [LooperLine], 50
	mov [x], 180
	call Line
	mov [looperSlope], 36
	mov si, 1 
	call slope
	cmp [QuizOrSearch], 1
	je @@FinishTheRoute
@@CheckForArrowAgain:
	xor di, di
	call CheckForArrow
	cmp di, 1
	je @@FinishTheRoute
	cmp [RightOrLeft], 0 
	je @@RightSide
@@LeftSide:
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y], 164 
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'c'
	call PrintColoredChar ;the letters for the route
	mov al, 'o'
	call PrintColoredChar
	mov al, 'r'
	call PrintColoredChar
	mov al, 'n'
	call PrintColoredChar
	mov al, 'e'
	call PrintColoredChar
	mov al, 'r'
	call PrintColoredChar
	mov [LooperLine], 50
	mov [x], 134
	call line 
	mov [looperSlope], 36
	xor si, si 
	call Slope
	jmp @@CheckForArrowAgain
@@FinishTheRoute:
	pop si
	pop di
	pop dx 
	pop cx 
	pop bx 
	pop ax 
	ret
endp

proc Curl
	mov [HorizontalLine], 0
	mov [OppositeRoute], 1
	mov [SlopeSize], 2 ;change 
	push ax
	push bx 
	push cx
	push dx 
	push di
	push si 
@@RightSide:
	cmp [QuizOrSearch], 1
	je @@ActuallyDrawingTheRoute
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y] , 164
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'c'
	call PrintColoredChar
	mov al, 'u'
	call PrintColoredChar
	mov al, 'r'
	call PrintColoredChar
	mov al, 'l'
	call PrintColoredChar
@@ActuallyDrawingTheRoute:
	mov [LooperLine], 35 ;change 
	mov [x], 218 ;maybe change 
	call Line
	mov [looperSlope], 10 ;change 
	xor si, si
	call slope
	cmp [QuizOrSearch], 1
	je @@FinishTheRoute
@@CheckForArrowAgain:
	xor di, di
	call CheckForArrow
	cmp di, 1
	je @@FinishTheRoute
	cmp [RightOrLeft], 0 
	je @@RightSide
@@LeftSide:
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y], 164 
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'c'
	call PrintColoredChar ;the letters for the route
	mov al, 'u'
	call PrintColoredChar
	mov al, 'r'
	call PrintColoredChar
	mov al, 'l'
	call PrintColoredChar
	mov [LooperLine], 35 ;change 
	mov [x], 90 ;maybe chnage 
	call line 
	mov [looperSlope], 10 ;change 
	mov si, 1 
	call Slope
	jmp @@CheckForArrowAgain
@@FinishTheRoute:
	pop si
	pop di
	pop dx 
	pop cx 
	pop bx 
	pop ax 
	ret
endp

proc Drag
	mov [OppositeRoute], 0
	mov [HorizontalLine], 1
	mov [SlopeSize], 2 ;change 
	push ax
	push bx 
	push cx
	push dx 
	push di
	push si 
@@RightSide:
	cmp [QuizOrSearch], 1
	je @@ActuallyDrawingTheRoute
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y] , 164
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'd'
	call PrintColoredChar
	mov al, 'r'
	call PrintColoredChar
	mov al, 'a'
	call PrintColoredChar
	mov al, 'g'
	call PrintColoredChar
@@ActuallyDrawingTheRoute:
	mov [x], 180 ;maybe change 
	mov [looperSlope], 20 ;change 
	xor si, si
	call slope
	mov [LooperLine], 35 ;change 
	call Line
	cmp [QuizOrSearch], 1
	je @@FinishTheRoute
@@CheckForArrowAgain:
	xor di, di
	call CheckForArrow
	cmp di, 1
	je @@FinishTheRoute
	cmp [RightOrLeft], 0 
	je @@RightSide
@@LeftSide:
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y], 164 
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'd'
	call PrintColoredChar ;the letters for the route
	mov al, 'r'
	call PrintColoredChar
	mov al, 'a'
	call PrintColoredChar
	mov al, 'g'
	call PrintColoredChar
	mov [x], 140 ;maybe chnage 
	mov [looperSlope], 20 ;change 
	mov si, 1 
	call Slope
	mov [LooperLine], 35 ;change 

	call line 
	
	jmp @@CheckForArrowAgain
@@FinishTheRoute:
	pop si
	pop di
	pop dx 
	pop cx 
	pop bx 
	pop ax 
	ret
endp

proc Fade
	mov [OppositeRoute], 0
	mov [HorizontalLine], 0
	mov [SlopeSize], 2
	push ax
	push bx 
	push cx
	push dx 
	push di
	push si 
@@RightSide:
	cmp [QuizOrSearch], 1
	je @@ActuallyDrawingTheRoute
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y] , 164
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'f'
	call PrintColoredChar
	mov al, 'a'
	call PrintColoredChar
	mov al, 'd'
	call PrintColoredChar
	mov al, 'e'
	call PrintColoredChar
@@ActuallyDrawingTheRoute:
	mov [LooperLine], 24
	mov [x], 210
	call Line
	mov [looperSlope], 14
	mov si, 1 
	call slope
	cmp [QuizOrSearch], 1
	je @@FinishTheRoute
@@CheckForArrowAgain:
	xor di, di
	call CheckForArrow
	cmp di, 1
	je @@FinishTheRoute
	cmp [RightOrLeft], 0 
	je @@RightSide
@@LeftSide:
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y], 164 
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'f'
	call PrintColoredChar ;the letters for the route
	mov al, 'a'
	call PrintColoredChar
	mov al, 'd'
	call PrintColoredChar
	mov al, 'e'
	call PrintColoredChar
	mov [LooperLine], 24
	mov [x], 95
	call line 
	mov [looperSlope], 14
	xor si, si 
	call Slope
	jmp @@CheckForArrowAgain
@@FinishTheRoute:
	pop si
	pop di
	pop dx 
	pop cx 
	pop bx 
	pop ax 
	ret
endp

proc FlatRoute
	mov [HorizontalLine], 0
	mov [OppositeRoute], 0
	mov [SlopeSize], 2 ;change 
	push ax
	push bx 
	push cx
	push dx 
	push di
	push si 
@@RightSide:
	cmp [QuizOrSearch], 1
	je @@ActuallyDrawingTheRoute
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y] , 164
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'f'
	call PrintColoredChar
	mov al, 'l'
	call PrintColoredChar
	mov al, 'a'
	call PrintColoredChar
	mov al, 't'
	call PrintColoredChar
@@ActuallyDrawingTheRoute: 
	mov [x], 210 ;maybe change 
	mov [looperSlope], 16 ;change 
	mov si, 1 
	call Slope 
	cmp [QuizOrSearch], 1
	je @@FinishTheRoute
@@CheckForArrowAgain:
	xor di, di
	call CheckForArrow
	cmp di, 1
	je @@FinishTheRoute
	cmp [RightOrLeft], 0 
	je @@RightSide
@@LeftSide:
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y], 164 
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'f'
	call PrintColoredChar ;the letters for the route
	mov al, 'l'
	call PrintColoredChar
	mov al, 'a'
	call PrintColoredChar
	mov al, 't'
	call PrintColoredChar
	mov [x], 100 ;maybe change
	mov [looperSlope], 16 ;change 
	xor si, si 
	call Slope 
	jmp @@CheckForArrowAgain
@@FinishTheRoute:
	pop si
	pop di
	pop dx 
	pop cx 
	pop bx 
	pop ax 
	ret
endp

proc Hitch
	mov [HorizontalLine], 0
	mov [OppositeRoute], 1
	mov [SlopeSize], 2 ;change 
	push ax
	push bx 
	push cx
	push dx 
	push di
	push si 
@@RightSide:
	cmp [QuizOrSearch], 1
	je @@ActuallyDrawingTheRoute
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y] , 164
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'h'
	call PrintColoredChar
	mov al, 'i'
	call PrintColoredChar
	mov al, 't'
	call PrintColoredChar
	mov al, 'c'
	call PrintColoredChar
	mov al, 'h'
	call PrintColoredChar
@@ActuallyDrawingTheRoute:
	mov [LooperLine], 15 ;change 
	mov [x], 180 ;maybe change 
	call Line
	mov [looperSlope], 5 ;change 
	xor si, si
	call slope
	cmp [QuizOrSearch], 1
	je @@FinishTheRoute
@@CheckForArrowAgain:
	xor di, di
	call CheckForArrow
	cmp di, 1
	je @@FinishTheRoute
	cmp [RightOrLeft], 0 
	je @@RightSide
@@LeftSide:
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y], 164 
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'h'
	call PrintColoredChar ;the letters for the route
	mov al, 'i'
	call PrintColoredChar
	mov al, 't'
	call PrintColoredChar
	mov al, 'c'
	call PrintColoredChar
	mov al, 'h'
	call PrintColoredChar
	mov [LooperLine], 15 ;change 
	mov [x], 130 ;maybe chnage 
	call line 
	mov [looperSlope], 5 ;change 
	mov si, 1 
	call Slope
	jmp @@CheckForArrowAgain
@@FinishTheRoute:
	pop si
	pop di
	pop dx 
	pop cx 
	pop bx 
	pop ax 
	ret
endp

proc InRoute
	mov [OppositeRoute], 0
	mov [HorizontalLine], 0
	mov [SlopeSize], 2 ;change 
	push ax
	push bx 
	push cx
	push dx 
	push di
	push si 
@@RightSide:
	cmp [QuizOrSearch], 1
	je @@ActuallyDrawingTheRoute
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y] , 164
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'i'
	call PrintColoredChar
	mov al, 'n'
	call PrintColoredChar
@@ActuallyDrawingTheRoute:
	mov [x], 180 ;maybe change 
	mov [HorizontalLine], 0
	xor si, si 
	mov [LooperLine], 20 ;change 
	call Line 
	mov [HorizontalLine], 1
	mov [LooperLine], 40 ;change 
	call Line
	cmp [QuizOrSearch], 1
	je @@FinishTheRoute
@@CheckForArrowAgain:
	xor di, di
	call CheckForArrow
	cmp di, 1
	je @@FinishTheRoute
	cmp [RightOrLeft], 0 
	je @@RightSide
@@LeftSide:
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y], 164 
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'i'
	call PrintColoredChar ;the letters for the route
	mov al, 'n'
	call PrintColoredChar
	mov [x], 130 ;maybe chnage 
	mov [HorizontalLine], 0
	mov [LooperLine], 20 ;change 
	call Line 
	mov si, 1 
	mov [HorizontalLine], 1
	mov [LooperLine], 40 ;change 
	call Line
	
	jmp @@CheckForArrowAgain
@@FinishTheRoute:
	pop si
	pop di
	pop dx 
	pop cx 
	pop bx 
	pop ax 
	ret
endp

proc OutRoute
	mov [OppositeRoute], 0
	mov [HorizontalLine], 0
	mov [SlopeSize], 2 ;change 
	push ax
	push bx 
	push cx
	push dx 
	push di
	push si 
@@RightSide:
	cmp [QuizOrSearch], 1
	je @@ActuallyDrawingTheRoute
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y] , 164
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'o'
	call PrintColoredChar ;the letters for the route
	mov al, 'u'
	call PrintColoredChar
	mov al, 't'
	call PrintColoredChar
@@ActuallyDrawingTheRoute:
	mov [x], 180 ;maybe change 
	mov [HorizontalLine], 0
	xor si, si 
	mov [LooperLine], 20 ;change 
	call Line 
	mov si, 1 
	mov [HorizontalLine], 1
	mov [LooperLine], 34 ;change 
	call Line
	cmp [QuizOrSearch], 1
	je @@FinishTheRoute
@@CheckForArrowAgain:
	xor di, di
	call CheckForArrow
	cmp di, 1
	je @@FinishTheRoute
	cmp [RightOrLeft], 0 
	je @@RightSide
@@LeftSide:
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y], 164 
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'o'
	call PrintColoredChar ;the letters for the route
	mov al, 'u'
	call PrintColoredChar
	mov al, 't'
	call PrintColoredChar
	mov [x], 130 ;maybe chnage 
	mov [HorizontalLine], 0
	mov [LooperLine], 20 ;change 
	call Line 
	xor si, si
	mov [HorizontalLine], 1
	mov [LooperLine], 40 ;change 
	call Line
	
	jmp @@CheckForArrowAgain
@@FinishTheRoute:
	pop si
	pop di
	pop dx 
	pop cx 
	pop bx 
	pop ax 
	ret
endp

proc Post
	mov [OppositeRoute], 0
	mov [HorizontalLine], 0
	mov [SlopeSize], 2
	push ax
	push bx 
	push cx
	push dx 
	push di
	push si 
@@RightSide:
	cmp [QuizOrSearch], 1
	je @@ActuallyDrawingTheRoute
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y] , 164
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'p'
	call PrintColoredChar
	mov al, 'o'
	call PrintColoredChar
	mov al, 's'
	call PrintColoredChar
	mov al, 't'
	call PrintColoredChar
@@ActuallyDrawingTheRoute:
	mov [LooperLine], 36
	mov [x], 216
	call Line
	mov [looperSlope], 20
	mov si, 1 
	call slope
	cmp [QuizOrSearch], 1
	je @@FinishTheRoute
@@CheckForArrowAgain:
	xor di, di
	call CheckForArrow
	cmp di, 1
	je @@FinishTheRoute
	cmp [RightOrLeft], 0 
	je @@RightSide
@@LeftSide:
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y], 164 
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'p'
	call PrintColoredChar ;the letters for the route
	mov al, 'o'
	call PrintColoredChar
	mov al, 's'
	call PrintColoredChar
	mov al, 't'
	call PrintColoredChar
	mov [LooperLine], 36
	mov [x], 90
	call line 
	mov [looperSlope], 20
	xor si, si 
	call Slope
	jmp @@CheckForArrowAgain
@@FinishTheRoute:
	pop si
	pop di
	pop dx 
	pop cx 
	pop bx 
	pop ax 
	ret
endp

proc Slant
	mov [HorizontalLine], 0
	mov [OppositeRoute], 0
	mov [SlopeSize], 3
	push ax
	push bx 
	push cx
	push dx 
	push di
	push si 
@@RightSide:
	cmp [QuizOrSearch], 1
	je @@ActuallyDrawingTheRoute
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y] , 164
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 's'
	call PrintColoredChar
	mov al, 'l'
	call PrintColoredChar
	mov al, 'a'
	call PrintColoredChar
	mov al, 'n'
	call PrintColoredChar
	mov al, 't'
	call PrintColoredChar
@@ActuallyDrawingTheRoute:
	mov [LooperLine], 30
	mov [x], 220
	call Line
	mov [looperSlope], 30
	xor si, si
	call slope
	cmp [QuizOrSearch], 1
	je @@FinishTheRoute
@@CheckForArrowAgain:
	xor di, di
	call CheckForArrow
	cmp di, 1
	je @@FinishTheRoute
	cmp [RightOrLeft], 0 
	je @@RightSide
@@LeftSide:
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y], 164 
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 's'
	call PrintColoredChar ;the letters for the route
	mov al, 'l'
	call PrintColoredChar
	mov al, 'a'
	call PrintColoredChar
	mov al, 'n'
	call PrintColoredChar
	mov al, 't'
	call PrintColoredChar
	mov [LooperLine], 30 
	mov [x], 90
	call line 
	mov [looperSlope], 30
	mov si, 1
	call Slope
	jmp @@CheckForArrowAgain
@@FinishTheRoute:
	pop si
	pop di
	pop dx 
	pop cx 
	pop bx 
	pop ax 
	ret
endp 

proc Streak
	mov [OppositeRoute], 0
	mov [HorizontalLine], 0
	mov [SlopeSize], 2
	push ax
	push bx 
	push cx
	push dx 
	push di
	push si 
@@RightSide:
	cmp [QuizOrSearch], 1
	je @@ActuallyDrawingTheRoute
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y] , 164
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 's'
	call PrintColoredChar
	mov al, 't'
	call PrintColoredChar
	mov al, 'r'
	call PrintColoredChar
	mov al, 'e'
	call PrintColoredChar
	mov al, 'a'
	call PrintColoredChar
	mov al, 'k'
	call PrintColoredChar
@@ActuallyDrawingTheRoute:
	mov [LooperLine], 74
	mov [x], 190
	call Line
	cmp [QuizOrSearch], 1
	je @@FinishTheRoute
@@CheckForArrowAgain:
	xor di, di
	call CheckForArrow
	cmp di, 1
	je @@FinishTheRoute
	cmp [RightOrLeft], 0 
	je @@RightSide
@@LeftSide:
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y], 164 
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 's'
	call PrintColoredChar
	mov al, 't'
	call PrintColoredChar
	mov al, 'r'
	call PrintColoredChar
	mov al, 'e'
	call PrintColoredChar
	mov al, 'a'
	call PrintColoredChar
	mov al, 'k'
	call PrintColoredChar
	mov [LooperLine], 74
	mov [x], 120
	call line 
	jmp @@CheckForArrowAgain
@@FinishTheRoute:
	pop si
	pop di
	pop dx 
	pop cx 
	pop bx 
	pop ax 
	ret
endp

proc Zig
	mov [OppositeRoute], 0
	mov [HorizontalLine], 1
	mov [SlopeSize], 2 ;change 
	push ax
	push bx 
	push cx
	push dx 
	push di
	push si 
@@RightSide:
	cmp [QuizOrSearch], 1
	je @@ActuallyDrawingTheRoute
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y] , 164
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'z'
	call PrintColoredChar
	mov al, 'i'
	call PrintColoredChar
	mov al, 'g'
	call PrintColoredChar
@@ActuallyDrawingTheRoute:
	mov [x], 180 ;maybe change 
	mov [looperSlope], 20 ;change 
	xor si, si
	call slope
	mov [LooperLine], 35 ;change 
	mov si, 1 
	call Line
	cmp [QuizOrSearch], 1
	je @@FinishTheRoute
@@CheckForArrowAgain:
	xor di, di
	call CheckForArrow
	cmp di, 1
	je @@FinishTheRoute
	cmp [RightOrLeft], 0 
	je @@RightSide
@@LeftSide:
	mov dh, [CursorPositionYRoute] ;row (y)
	mov dl, [CursorPositionXRoute] ;column (x)
	call ChangeCursor
	mov [y], 164 
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'z'
	call PrintColoredChar
	mov al, 'i'
	call PrintColoredChar
	mov al, 'g'
	call PrintColoredChar
	mov [x], 140 ;maybe chnage 
	mov [looperSlope], 20 ;change 
	mov si, 1 
	call Slope
	mov [LooperLine], 35 ;change 
	xor si, si 
	call line 
	
	jmp @@CheckForArrowAgain
@@FinishTheRoute:
	pop si
	pop di
	pop dx 
	pop cx 
	pop bx 
	pop ax 
	ret
endp
exit1:
	mov ax, 4c00h
	int 21h


