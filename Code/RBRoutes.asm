
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

;line and slope procs are in WRRoutes.asm

proc CutBack
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
	dec dl 
	call ChangeCursor
	
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
	mov al, 't'
	call PrintColoredChar
	mov al, 'b'
	call PrintColoredChar
	mov al, 'a'
	call PrintColoredChar
	mov al, 'c'
	call PrintColoredChar
	mov al, 'k'
	call PrintColoredChar
@@ActuallyDrawingTheRoute: 
	mov [y], 164
	mov [x], 158 ;maybe change 
	mov [looperSlope], 8 ;change 
	mov [SlopeSize], 1 
	mov si, 1 
	call Slope
	mov [SlopeSize], 2 
	mov [looperSlope], 14
	xor si, si 
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
	dec dl
	call ChangeCursor

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
	mov al, 't'
	call PrintColoredChar
	mov al, 'b'
	call PrintColoredChar
	mov al, 'a'
	call PrintColoredChar
	mov al, 'c'
	call PrintColoredChar
	mov al, 'k'
	call PrintColoredChar
	mov [y], 164 
	mov [x], 154 ;maybe change
	mov [looperSlope], 8 ;change 
	mov [SlopeSize], 1 
	xor si, si  
	call Slope
	mov [SlopeSize], 2 
	mov [looperSlope], 14
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

proc Dive
	mov [HorizontalLine], 0
	mov [OppositeRoute], 0
	mov [SlopeSize], 1 ;change 
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
	
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'd'
	call PrintColoredChar
	mov al, 'i'
	call PrintColoredChar
	mov al, 'v'
	call PrintColoredChar
	mov al, 'e'
	call PrintColoredChar
@@ActuallyDrawingTheRoute: 
	mov [y] , 164
	mov [x], 158 ;maybe change 
	mov [looperSlope], 18 ;change 
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

	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'd'
	call PrintColoredChar
	mov al, 'i'
	call PrintColoredChar
	mov al, 'v'
	call PrintColoredChar
	mov al, 'e'
	call PrintColoredChar
	mov [y], 164 
	mov [x], 154 ;maybe change
	mov [looperSlope], 18 ;change 
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

proc Misdirection
	mov [HorizontalLine], 0
	mov [OppositeRoute], 0
	mov [SlopeSize], 3 ;change 
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
	sub dl, 4
	call ChangeCursor
	
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'm'
	call PrintColoredChar
	mov al, 'i'
	call PrintColoredChar
	mov al, 's'
	call PrintColoredChar
	mov al, 'd'
	call PrintColoredChar
	mov al, 'i'
	call PrintColoredChar
	mov al, 'r'
	call PrintColoredChar
	mov al, 'e'
	call PrintColoredChar
	mov al, 'c'
	call PrintColoredChar
	mov al, 't'
	call PrintColoredChar
	mov al, 'i'
	call PrintColoredChar
	mov al, 'o'
	call PrintColoredChar
	mov al, 'n'
	call PrintColoredChar
@@ActuallyDrawingTheRoute: 
	mov [y], 164
	mov [x], 158 ;maybe change 
	mov [looperSlope], 4 ;change 
	mov [SlopeSize], 2 
	xor si, si 
	call Slope
	mov [SlopeSize], 3 
	mov [looperSlope], 16
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
	sub dl, 4
	call ChangeCursor

	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'm'
	call PrintColoredChar
	mov al, 'i'
	call PrintColoredChar
	mov al, 's'
	call PrintColoredChar
	mov al, 'd'
	call PrintColoredChar
	mov al, 'i'
	call PrintColoredChar
	mov al, 'r'
	call PrintColoredChar
	mov al, 'e'
	call PrintColoredChar
	mov al, 'c'
	call PrintColoredChar
	mov al, 't'
	call PrintColoredChar
	mov al, 'i'
	call PrintColoredChar
	mov al, 'o'
	call PrintColoredChar
	mov al, 'n'
	call PrintColoredChar
	mov [y], 164 
	mov [x], 154 ;maybe change
	mov [looperSlope], 4 ;change 
	mov [SlopeSize], 2 
	mov si, 1
	call Slope
	mov [SlopeSize], 3 
	mov [looperSlope], 16
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

proc Outside
	mov [HorizontalLine], 0
	mov [OppositeRoute], 0
	mov [SlopeSize], 4 ;change 
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
	sub dl, 2
	call ChangeCursor
	
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'o'
	call PrintColoredChar
	mov al, 'u'
	call PrintColoredChar
	mov al, 't'
	call PrintColoredChar
	mov al, 's'
	call PrintColoredChar
	mov al, 'i'
	call PrintColoredChar
	mov al, 'd'
	call PrintColoredChar
	mov al, 'e'
	call PrintColoredChar
@@ActuallyDrawingTheRoute: 
	mov [y] , 164
	mov [x], 158 ;maybe change 
	mov [looperSlope], 18 ;change 
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
	sub dl, 2
	call ChangeCursor

	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'o'
	call PrintColoredChar
	mov al, 'u'
	call PrintColoredChar
	mov al, 't'
	call PrintColoredChar
	mov al, 's'
	call PrintColoredChar
	mov al, 'i'
	call PrintColoredChar
	mov al, 'd'
	call PrintColoredChar
	mov al, 'e'
	call PrintColoredChar
	mov [y], 164 
	mov [x], 154 ;maybe change
	mov [looperSlope], 18 ;change 
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

proc Power
	mov [HorizontalLine], 0
	mov [OppositeRoute], 0
	mov [SlopeSize], 3 ;change 
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
	mov al, 'w'
	call PrintColoredChar
	mov al, 'e'
	call PrintColoredChar
	mov al, 'r'
	call PrintColoredChar
@@ActuallyDrawingTheRoute: 
	mov [y], 164
	mov [x], 158 ;maybe change 
	mov [looperSlope], 18 ;change 
	xor si, si 
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
	mov al, 'w'
	call PrintColoredChar
	mov al, 'e'
	call PrintColoredChar
	mov al, 'r'
	call PrintColoredChar
	mov [y], 164 
	mov [x], 154 ;maybe change
	mov [looperSlope], 18 ;change 
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

proc Slam 
	mov [HorizontalLine], 0
	mov [OppositeRoute], 0
	mov [SlopeSize], 1 ;change 
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
	mov al, 'm'
	call PrintColoredChar
@@ActuallyDrawingTheRoute: 
	mov [y], 164
	mov [x], 158 ;maybe change 
	mov [looperSlope], 18 ;change 
	xor si, si 
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
	mov al, 'm'
	call PrintColoredChar
	mov [y], 164 
	mov [x], 154 ;maybe change
	mov [looperSlope], 18 ;change 
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

proc Strech
	mov [HorizontalLine], 0
	mov [OppositeRoute], 0
	mov [SlopeSize], 3 ;change 
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
	mov al, 'c'
	call PrintColoredChar
	mov al, 'h'
	call PrintColoredChar
@@ActuallyDrawingTheRoute: 
	mov [y] , 164
	mov [x], 158 ;maybe change 
	mov [looperSlope], 18 ;change 
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
	mov al, 'c'
	call PrintColoredChar
	mov al, 'h'
	call PrintColoredChar
	mov [y], 164 
	mov [x], 154 ;maybe change
	mov [looperSlope], 18 ;change 
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

proc Toss 
	mov [HorizontalLine], 0
	mov [OppositeRoute], 0
	mov [SlopeSize], 3 ;change 
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
	
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 't'
	call PrintColoredChar
	mov al, 'o'
	call PrintColoredChar
	mov al, 's'
	call PrintColoredChar
	mov al, 's'
	call PrintColoredChar
@@ActuallyDrawingTheRoute: 
	mov [y], 164
	mov [x], 158 ;maybe change 
	mov [looperSlope], 8 ;change 
	mov [SlopeSize], 3
	mov si, 1 
	call Slope 
	mov [SlopeSize] ,1 
	mov [looperSlope], 12
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

	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 't'
	call PrintColoredChar
	mov al, 'o'
	call PrintColoredChar
	mov al, 's'
	call PrintColoredChar
	mov al, 's'
	call PrintColoredChar
	mov [y], 164 
	mov [x], 154 ;maybe change
	mov [looperSlope], 10 ;change 
	mov [SlopeSize], 3
	xor si, si
	call Slope 
	mov [SlopeSize] ,1 
	mov [looperSlope], 12
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

proc Wheel
	mov [OppositeRoute], 0
	mov [HorizontalLine], 1
	mov [SlopeSize], 1 ;change 
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
	dec dl 
	call ChangeCursor
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'w'
	call PrintColoredChar
	mov al, 'h'
	call PrintColoredChar
	mov al, 'e'
	call PrintColoredChar
	mov al, 'e'
	call PrintColoredChar
	mov al, 'l'
	call PrintColoredChar
@@ActuallyDrawingTheRoute:
	mov [y], 162
	mov [x], 158 ;maybe change 
	mov [LooperLine], 20 ;change 
	call Line
	mov [looperSlope], 24 ;change 
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
	dec dl 
	call ChangeCursor
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'w'
	call PrintColoredChar
	mov al, 'h'
	call PrintColoredChar
	mov al, 'e'
	call PrintColoredChar
	mov al, 'e'
	call PrintColoredChar
	mov al, 'l'
	call PrintColoredChar
	mov [y], 162
	mov [x], 154 ;maybe change
	mov si, 1 
	mov [LooperLine], 20 ;change 
	call Line
	mov [looperSlope], 24 ;change 
	mov si, 1 
	call slope
	
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

proc Zone 
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
	
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'z'
	call PrintColoredChar
	mov al, 'o'
	call PrintColoredChar
	mov al, 'n'
	call PrintColoredChar
	mov al, 'e'
	call PrintColoredChar
@@ActuallyDrawingTheRoute: 
	mov [y], 164
	mov [x], 158 ;maybe change 
	mov [looperSlope], 18 ;change 
	xor si, si 
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

	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset BackgroundForRoutesSearch
	call CountinuationBMP
	mov al, 'z'
	call PrintColoredChar
	mov al, 'o'
	call PrintColoredChar
	mov al, 'n'
	call PrintColoredChar
	mov al, 'e'
	call PrintColoredChar
	mov [y], 164 
	mov [x], 154 ;maybe change
	mov [looperSlope], 18 ;change 
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


exit2:
	mov ax, 4c00h
	int 21h

