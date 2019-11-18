IDEAL
MODEL small
jumps
STACK 100h
DATASEG
;BMP's
MAX_BMP_WIDTH = 320
MAX_BMP_HEIGHT = 200

SMALL_BMP_HEIGHT = 40
SMALL_BMP_WIDTH = 40
SecondTime db, 90                                                      ;|
	FrameTime dw 1;time in seconds between every frame										   ;|
																		   ;|
    OneBmpLine 	db MAX_BMP_WIDTH dup (0)  ; One Color line read buffer     ;|
                      
    ScreenLineMax 	db MAX_BMP_WIDTH dup (0)  ; One Color line read buffer

	;BMP File data
	FileHandle	dw ?
	Header 	    db 54 dup(0)
	Palette 	db 400h dup (0)
	BmpFileErrorMsg    	db 'Error At Opening Bmp File .', 0dh, 0ah,'$'
	ErrorFile           db 0
    BB db "BB..",'$'
	 
	BmpLeft dw 2
	BmpTop dw 2
	BmpColSize dw ?
	BmpRowSize dw ?
	LastKey db 0

;User messages
; StartArray db 10,13,"Hello, please enter what position you are",10,13 ,"For quarterback - press q",10,13,
 ; db"For Wide receiver - press w ", 10,13, "For Running back - press r",10,13,"$"
; BadCharArray db ' ERROR, Please enter a char that is supported ', 10,13,'$'

; QuizOrRouteArray db 10,13,"Would you like to get quized on routes or search for routes?",10,13,
; db "For quiz - press q",10,13,"To search routes - press r",10,13,"$"
; EnterRoute db 10,13,'Search for a route, all letters must be lower case',10,13,'$'
; NoRoute db 'No routes found, press any key to change your search',10,13,'$'
; BadNumMessage db 13,'you did not enter an english letter press any key to change it',13,'$'
ClearLine db 67 dup (20h),13,'$'

;Backend 
FirstPic db 'first.bmp',0 ;first pic displayed 
SecondPicChoosePosition db 'second.bmp',0 ;second pic displayed, choose your position 

WhiteForDropDown db 'White.bmp',0 ;used in drop down menu 
NoResultsFound db 'NRF.bmp',0 ;used in the drop down menu when no results are found
BackgroundForRoutesSearch db 'bgs.bmp',0 ;used as a background for the routes when searching for routes 
BackgroundForRoutesQuiz db 'bgq.bmp',0 ;used as background for the routes when getting quized 
BackgroundForDropDownMenu db 'bgdd.bmp',0 ; used in the drop down menu for instructions 
BlackScreen db 'blacks.bmp',0 ;resets the whole screen to be black 
randSize dw 0  
totalRand dw 0 
ReturnAddress db 0 ;used for procs that get value from the stack 
CursorAndRow db 10,13,'$'
LetterOrNumber db 0
KeyPress db 0 
RightOrLeft db 0 ; 0- right 1- left 
SlopeSize dw 0
CursorPositionXRoute db  17 ;column cursor position 
CursorPositionyRoute db  5 ;Row cursor position 
QuizOrSearch db 0
ChosenPosition db 0
CursorPositionXDDInstructions db 11 ;column cursor position 
CursorPositionYDDInstructions db 80 ;Row cursor position 
CursorPositionXPointer db 20
CursorPositionYPointer db 20
HowFarIntoRoute db 0 
OppositeRoute db 0
HorizontalLine db 0
FinishProgram db 0 
BackToSearchOrQuiz db 0 
PositionOfEnter db 0 
UserEnteredChar db 0 ; used in drop down 
NoMoreThenOne db 0
WhiteOrBlue db 0 ; 0- white version of the bmp 1- blue version of the bmp
YellowArrow db 'arrow.bmp',0  
CoverArrow db 'arrowc.bmp',0
DropDownWRCover db 'swr.bmp',0
DropDownRBCover db 'srb.bmp',0
DropDownQBCover db 'sqb2.bmp',0
SearchOrQuizBMP db 'sorq.bmp',0
BmpArrow db 40
CurrentArrow db 0
ThanksBMP db 'thanks.bmp',0 ;used at the end of the program


;Quizzes 
CorrectBMP db 'correct.bmp',0 ;used in the quiz
InCorrectBMP db 'wrong.bmp',0 ;used in the quiz
CorrectAnswer db 0 ;used in the quiz
ADone db 0
BDone db 0
CDone db 0
DDone db 0
SecondAnswer db 0
ThirdAnswer db 0
FourthAnswer db 0
AnswerAlreadyPrinted db 0


;WR
WRRoutesArray db "corner","curl","drag","fade","flat","hitch","in","out","post","slant","streak","zig" ;12 total 
RoutesOffsetArrayWR db 0,6,4,4,4,4,5,2,3,4,5,6,3,-1
NumberOfRoutesWR dw 0
;GoodRouteLineWR db 6 dup(20h)
LongestRouteWR db 6 ;in chars in order to limit maximum chars 
OffsetIntoRouteWR dw 0 
RoutePrintWR db 0
WRRoutesPrintedAndArrows db 0,0,0,0,0,0,0,0,0,0,0,0 ; 0 is unprinted 1 is printed 2 is blue 
;12 total 
HowManyCharsWR db 0
CharsForRoutesEntered db 0
slantblah db 'slant$'
streakblah db 'streak$'
;WR BMP's ; all are 180 X 28 
	CornerWhite db 'CrWhite.bmp',0 ;Corner
	CornerBlue db 'CrBlue.bmp',0
	
	CurlWhite db 'ClWhite.bmp',0 ;Curl
	CurlBlue db 'ClBlue.bmp',0
	
	DragWhite db 'DgWhite.bmp',0 ;Drag
	dragBlue db 'dgBlue.bmp',0
	
	FadeWhite db 'FeWhite.bmp',0 ;Fade
	FadeBlue db 'FeBlue.bmp',0
	
	FlatWhite db 'FlWhite.bmp',0 ;Flat 
	FlatBlue db 'FlBlue.bmp',0
	
	HitchWhite db 'HhWhite.bmp',0 ; Hitch
	HitchBlue db 'HhBlue.bmp',0
	
	InWhite db 'InWhite.bmp',0 ;In 
	InBlue db 'INBlue.bmp',0
	
	OutWhite db 'OtWhite.bmp',0 ;Out
	OutBlue db 'OtBlue.bmp',0
	
	PostWhite db 'PtWhite.bmp',0 ;Post 
	PostCornerBlue db 'PtBlue.bmp',0
	
	SlantWhite db 'StWhite.bmp',0 ;Slant 
	SlantBlue db 'StBlue.bmp',0
	
	StreakWhite db 'SkWhite.bmp',0 ;Streak
	StreakBlue db 'SkBlue.bmp',0
	
	ZigWhite db 'ZgWhite.bmp',0 ;Zig
	ZgBlue db 'ZgBlue.bmp',0

;RB
RBRoutesArray db "cutback","dive","misdir","outside","power","slam","strech","toss","wheel","zone" ;10 total 
RoutesOffsetArrayRB db 0,7,4,6,7,5,4,6,4,5,4,-1
NumberOfRoutesRB db 0
;GoodRouteLineRB db 7 dup(20h)
LongestRouteRB db 7 ;in chars in order to limit maximum chars 
OffsetIntoRouteRB dw 0 
;RB Bmp's

	CutbackWhite db 'CkWhite.bmp',0 ;Cutback 
	CutbackBlue db 'CkBlue.bmp',0
	
	DiveWhite db 'DeWhite.bmp',0 ;Dive 
	DiveBlue db 'DeBlue.bmp',0
	
	MisdirectionWhite db 'MnWhite.bmp',0 ; Misdirection 
	MisdirectionBlue db 'MnBlue.bmp',0
	
	OutsideWhite db 'OeWhite.bmp',0 ;Outside
	OutsideBlue db 'OeBlue.bmp',0
	
	PowerWhite db 'PrWhite.bmp',0 ;Power 
	PowerBlue db 'PrBlue.bmp',0
	
	SlamWhite db 'SmWhite.bmp',0 ; Slam
	SlamBlue db 'SmBlue.bmp',0
	
	StrechWhite db 'ShWhite.bmp',0 ; Strech
	StreachBlue db 'ShBlue.bmp',0
	
	TossWhite db 'TsWhite.bmp',0 ; Toss
	TossBlue db 'TsBlue.bmp',0
	
	WheelWhite db 'WlWhite.bmp',0 ; Wheel 
	WheelBlue db 'WlBlue.bmp',0
	
	ZoneWhite db 'ZeWhite.bmp',0 ; Zone 
	ZoneBlue db 'ZeBlue.bmp',0
	
;QB
QBRoutesArray db "corner","curl","cutback","dive","drag","fade","flat","hitch","in","misdir","out","outside","post","power","slam","slant","streak","strech","toss","wheel","zig","zone" ;22 total
RoutesOffsetArrayQB db 0,6,4,7,4,4,4,4,5,2,6,3,7,4,5,4,5,6,6,4,5,3,4,-1

;QB BMP's

RBWROrBothBMP db 'wrb.bmp',0 ;used for asking if he wantes RB routes WR routes or Both 
CaptialAsciiOfRoute db 0
CaptialFoundArray db 'The capital you choose is one of the routes in the system'

CursorPositionXDD db 10 ;column cursor position 
CursorPositionYDD db 1 ;Row cursor position 
MarginTop dw 0

;Routes makers 
LooperLine dw ?
LooperSlope dw ?

x dw 0 ; max 320 
; 280 for right arrow
; 140 for left arrow (check again)
y dw 164 ; max 200 
; always 200 the route starts from the bottom of the screen check later with qb bmp
color db 0eh  
; --------------------------
; Your variables here
; --------------------------
CODESEG
include "WRRoutes.asm"
include "RBRoutes.asm"
; input :
;	1.BmpLeft offset from left (where to start draw the picture) 
;	2. BmpTop offset from top
;	3. BmpColSize picture width , 
;	4. BmpRowSize bmp height 
;	5. dx offset to file name with zero at the end 
proc OpenShowBmp near
	push cx
	push bx
	
	
	call OpenBmpFile
	cmp [ErrorFile],1
	je @@ExitProc
	
	
	call ReadBmpHeader
	
	; from  here assume bx is global param with file handle. 
	call ReadBmpPalette
	
	call CopyBmpPalette
	
	call ShowBMP
	
	 
	call CloseBmpFile

@@ExitProc:
	pop bx
	pop cx
	ret
endp OpenShowBmp

 
 
	
; input dx filename to open
proc OpenBmpFile	near						 
	mov ah, 3Dh
	xor al, al
	int 21h
	jc @@ErrorAtOpen
	mov [FileHandle], ax
	jmp @@ExitProc
	
@@ErrorAtOpen:
	mov [ErrorFile],1
@@ExitProc:	
	ret
endp OpenBmpFile



proc CloseBmpFile near
	mov ah,3Eh
	mov bx, [FileHandle]
	int 21h
	ret
endp CloseBmpFile


; Read 54 bytes the Header
proc ReadBmpHeader	near					
	push cx
	push dx
	
	mov ah,3fh
	mov bx, [FileHandle]
	mov cx,54
	mov dx,offset Header
	int 21h
	
	pop dx
	pop cx
	ret
endp ReadBmpHeader



proc ReadBmpPalette near ; Read BMP file color palette, 256 colors * 4 bytes (400h)
						 ; 4 bytes for each color BGR + null)			
	push cx
	push dx
	
	mov ah,3fh
	mov cx,400h
	mov dx,offset Palette
	int 21h
	
	pop dx
	pop cx
	
	ret
endp ReadBmpPalette


; Will move out to screen memory the colors
; video ports are 3C8h for number of first color
; and 3C9h for all rest
proc CopyBmpPalette		near					
										
	push cx
	push dx
	
	mov si,offset Palette
	mov cx,256
	mov dx,3C8h
	mov al,0  ; black first							
	out dx,al ;3C8h
	inc dx	  ;3C9h
CopyNextColor:
	mov al,[si+2] 		; Red				
	shr al,2 			; divide by 4 Max (cos max is 63 and we have here max 255 ) (loosing color resolution).				
	out dx,al 						
	mov al,[si+1] 		; Green.				
	shr al,2            
	out dx,al 							
	mov al,[si] 		; Blue.				
	shr al,2            
	out dx,al 							
	add si,4 			; Point to next color.  (4 bytes for each color BGR + null)				
								
	loop CopyNextColor
	
	pop dx
	pop cx
	
	ret
endp CopyBmpPalette
 
 
 
 

proc ShowBMP 
; BMP graphics are saved upside-down.
; Read the graphic line by line (BmpRowSize lines in VGA format),
; displaying the lines from bottom to top.
	push cx
	
	mov ax, 0A000h
	mov es, ax
	
	mov cx,[BmpRowSize]
	
	mov ax,[BmpColSize] ; row size must dived by 4 so if it less we must calculate the extra padding bytes
	xor dx,dx
	mov si,4
	div si
	mov bp,dx
	
	mov dx,[BmpLeft]
	
@@NextLine:
	push cx
	push dx
	
	mov di,cx  ; Current Row at the small bmp (each time -1)
	add di,[BmpTop] ; add the Y on entire screen
	
 
	; next 5 lines  di will be  = cx*320 + dx , point to the correct screen line
	mov cx,di
	shl cx,6
	shl di,8
	add di,cx
	add di,dx
	
	; small Read one line
	mov ah,3fh
	mov cx,[BmpColSize]  
	add cx,bp  ; extra  bytes to each row must be divided by 4
	mov dx,offset ScreenLineMax
	int 21h
	; Copy one line into video memory
	cld ; Clear direction flag, for movsb
	mov cx,[BmpColSize]  
	mov si,offset ScreenLineMax
	rep movsb ; Copy line to the screen
	
	pop dx
	pop cx
	 
	loop @@NextLine
	
	pop cx
	ret
endp ShowBMP 

  
   
proc  SetGraphic
	mov ax,13h   ; 320 X 200 
				 ;Mode 13h is an IBM VGA BIOS mode. It is the specific standard 256-color mode 
	int 10h
	ret
endp 	SetGraphic

proc WaitTime
	push si
	push cx
	push dx
	push ax	
	mov ah, 2Ch
	int 21h
	xor ax, ax
	mov al, dh;seconds in al
	add ax, [FrameTime]
	cmp ax, 59
	JB CheckTime
	xor ax, ax
CheckTime:	
	mov ah, 2Ch
	int 21h
	cmp al, dh
	JA CheckTime
	pop ax
	pop dx
	pop cx
	pop si
	ret
endp WaitTime 

proc CountinuationBMP ;put in dx the offset of the bmp pic that needs to be printed 
	loopnitay: 
	


	;;background
	;[BmpColSize], constant ;size of x of the bmp 
	;[BmpRowSize], constant ;size of y of the bmp
	;[BmpLeft], constant ;actual both sides - col divided by 2
	;[BmpTop], constant ;margin from the top 

	;pic name 
	call OpenShowBmp 
	
	cmp [ErrorFile],1
	jne cont1
	jmp exitError
cont1:	
	
	jmp exitBMP
	
exitError:
	 
	
    mov dx, offset BmpFileErrorMsg
	mov ah,9
	int 21h		
exitBMP:
	; mov dx, offset BB
	; mov ah,9
	; int 21h
	
	; mov ah,0
	; int 16h
	
	; mov ax,2
	; int 10h
	ret
endp



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;OTHER PROCS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



proc PrintAString ; prints a string 
	;push seg of string 
	;pop ds
	;mov dx, offset of string 
	mov ah, 9h
	int 21h
	ret
endp

proc TakeAChar ; takes a char from the user
		;the char will be in al 
	mov ah, 1
	int 21h
	ret
endp

proc PrintAChar ; prints a char 
	; in dl put the char in ascii
	mov ah, 2
	int 21h
	ret
endp

proc GraphicMode
	mov ax, 13h ; graphics mode
	int 10h
	ret
endp

proc TextMode
	mov ah, 0 ; move back to text mode 
	mov al, 2
	int 10h
	ret
endp

proc Zeroing
	xor ax, ax 
	xor bx, bx
	xor cx, cx
	xor dx, dx
	xor si, si
	xor di, di
	ret
endp

proc CursorAndRowHelper ;resets the cursor to the starting position and goes one line down
	push seg CursorAndRow
	pop ds
	mov dx, offset CursorAndRow
	call PrintAString
	ret
endp

proc PrintColoredChar ; only in graphics mode 
	; in al put the char you want to print(Ascii)
	mov bh, 0 ;page number
	mov bl, 3  ;color of the char 
	mov ah, 0eh
	int 10h
	ret
endp

proc ChangeCursor ;80 X 25 
	; put in dh row 
	; put in dl column 
	mov bh, 0 ; for graphics mode
	mov ah, 02h
	int 10h
	ret 
endp

proc HowManyRoutes ; in bx put the routes offset of what u need in di will be how many routes there are 
	xor di, di
WhileLoopCounter:
	cmp [byte ptr bx], 0FFh
	je EndCounter
	inc bx
	inc di
	jmp WhileLoopCounter
EndCounter:
	dec di 
	ret
endp

proc Rand ;in a variable called [randSize] put the the max number of the rand +1(only up to 10 1-9)
	push ax
	push bx
	push cx 
	push si
	push di 
NoZero:
	mov ah, 2ch ;reading the clock
	int 21h
	mov al, dl ;again taking the milliseconds
	xor ah, ah
	mov ax, dx 
	xor dx, dx
	mov cx, [randSize] ; -1 this number are the options for the random number 
	div cx ; here dx contains the remainder of the division from 0-9 chosen number 
	cmp dx, 0 
	je NoZero 
	
	cmp [LetterOrNumber], 1
	je FinishRand
	
	cmp [totalRand], 0
	jne ContinueRand
	mov [totalRand], dx
	jmp FinishRand
ContinueRand:
	cmp [totalRand], dx
	je NoZero
	cmp [SecondAnswer], 0 ;second answer 
	jne ThirdCheck
	mov [SecondAnswer], dl
	jmp FinishRand
	
ThirdCheck:
	cmp dl,[SecondAnswer]
	je NoZero
	cmp [ThirdAnswer], 0; third answer 
	jne FourthCheck
	mov [ThirdAnswer], dl
	jmp FinishRand
	
FourthCheck:
	cmp dl,[ThirdAnswer]
	je NoZero
	cmp dl, [FourthAnswer] ; fourth answer 
	je NoZero
	mov [FourthAnswer], dl
FinishRand:
	pop di
	pop si
	pop cx
	pop bx 
	pop ax 
	ret
endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;; ACTUAL CODE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


proc StartOfProject
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset FirstPic
	call CountinuationBMP
	
	mov ah, 00h ; wait for key press
	int 16h
@@SecondPic:
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset SecondPicChoosePosition
	call CountinuationBMP
	call TakeAChar
	cmp al, 'q'
	je SuportedChar
	cmp al, 'w'
	je SuportedChar
	cmp al, 'r'
	je SuportedChar
	cmp al, 'f'
	je @@FinishProject
	jmp @@SecondPic
	
SuportedChar:
	mov [ChosenPosition], al
	cmp [ChosenPosition], 'q' ;QB
	je CaseForQuarterBack
	cmp [ChosenPosition], 'w' ;WR
	je CaseForWideReciever
	
	
CaseForRunningBack: ;RB
@@BeginningOfCaseRB:
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset SearchOrQuizBMP
	call CountinuationBMP
	
	call TakeAChar
	cmp al, 'q'
	je @@ChooseQuiz
	cmp al, 's'
	je @@ChooseSearch
	cmp al, 01bh ;escape 
	je @@ChooseEscape
	jmp @@BeginningOfCaseRB
@@ChooseQuiz:
	call QuizRB
	cmp [FinishProgram], 1
	je @@FinishProject
	jmp @@BeginningOfCaseRB
@@ChooseSearch:
	call DropDownRB
	cmp [FinishProgram], 1
	je @@FinishProject
	jmp @@BeginningOfCaseRB
@@ChooseEscape:
	jmp @@SecondPic
	
	
CaseForQuarterBack:
@@BeginningOfCaseQB:
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset RBWROrBothBMP
	call CountinuationBMP
@@TakeInput:
	call TakeAChar
	cmp al, 'r'
	je @@ChooseRB
	cmp al, 'w'
	je @@ChooseWR
	cmp al, 'b'
	je @@ChooseBoth
	jmp @@BeginningOfCaseQB
@@ChooseRB:
	jmp CaseForRunningBack
@@ChooseWR:
	jmp CaseForWideReciever
@@ChooseBoth:
	
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset SearchOrQuizBMP
	call CountinuationBMP
	
	call TakeAChar
	cmp al, 'q'
	je @@ChooseQuizQB
	cmp al, 's'
	je @@ChooseSearchQB
	cmp al, 01bh ;escape 
	je @@ChooseEscape
	jmp @@ChooseBoth
@@ChooseQuizQB:
	call QuizQB
	cmp [FinishProgram], 1
	je @@FinishProject
	jmp @@BeginningOfCaseWR
@@ChooseSearchQB:
	call DropDownQB
	cmp [FinishProgram], 1
	je @@FinishProject
	jmp @@BeginningOfCaseQB
	
	
CaseForWideReciever:
@@BeginningOfCaseWR:
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset SearchOrQuizBMP
	call CountinuationBMP
	
	call TakeAChar
	cmp al, 'q'
	je @@ChooseQuizWR
	cmp al, 's'
	je @@ChooseSearchWR
	cmp al, 01bh ;escape 
	je @@ChooseEscape
	jmp @@BeginningOfCaseWR
@@ChooseQuizWR:
	call QuizWR
	cmp [FinishProgram], 1
	je @@FinishProject
	jmp @@BeginningOfCaseWR
@@ChooseSearchWR:
	call DropDownWR
	cmp [FinishProgram], 1
	je @@FinishProject
	jmp @@BeginningOfCaseWR
@@FinishProject:
	ret
endp

proc CaseQuarterBack
	mov [BmpColSize], 320 
	mov [BmpRowSize], 200 
	mov [BmpLeft], 0
	mov [BmpTop], 0
	mov dx, offset RBWROrBothBMP
	call CountinuationBMP
@@TakeInput:
	call TakeAChar
	cmp al, 'r'
	je @@ChooseRB
	cmp al, 'w'
	je @@ChooseWR
	cmp al, 'b'
	je @@ChooseBoth
	jmp @@TakeInput
@@ChooseRB:
	
	jmp @@FinishProc
@@ChooseWR:
	call CaseWideReciever
@@ChooseBoth:

@@FinishProc:
	ret
endp


; proc CaseRunningBack
; @@BeginningOfCaseRB:
	; mov [BmpColSize], 320 
	; mov [BmpRowSize], 200 
	; mov [BmpLeft], 0
	; mov [BmpTop], 0
	; mov dx, offset SearchOrQuizBMP
	; call CountinuationBMP
	
	; call TakeAChar
	; cmp al, 'q'
	; je @@ChooseQuiz
	; cmp al, 's'
	; je @@ChooseSearch
	; cmp al, 01bh ;escape 
	; je @@ChooseEscape
	; jmp @@BeginningOfCaseRB
; @@ChooseQuiz:
	; call QuizRB
; @@ChooseSearch:
	; call DropDownRB
; @@ChooseEscape:
	; mov [BackToChoosePosition], 1 
	; ret
; endp

proc CaseWideReciever
	; push seg QuizOrRouteArray 
	; pop ds
	; mov dx, offset QuizOrRouteArray
	; call PrintAString
	
OneMoreChanceWR:	
	call TakeAChar
	cmp al, 'q'
	je Quiz1WR
	cmp al, 'r'
	je SearchForRoutesWR
	
BadCharInputWR:
	; push seg BadCharArray ;wrong input bringing back the message to enter a char
	; pop ds
	; mov dx, offset BadCharArray
	; mov ah, 9h
	; int 21h
	; jmp OneMoreChanceWR
Quiz1WR:
	call QuizWR
SearchForRoutesWR:
	mov [NumberOfRoutesWR], 0
	mov bx, offset RoutesOffsetArrayWR
	call HowManyRoutes
	mov [NumberOfRoutesWR], di
	call DropDownWR
	
	ret
endp

proc DropDownRB
@@BeginningOfDropDown:
	mov [QuizOrSearch], 0 ;means need for arrow 
	
	mov [BmpColSize], 320 ;x
	mov [BmpRowSize], 200 ;y
	mov [BmpLeft],0 ;actual both sides - col divided by 2
	mov [BmpTop], 0 ; margin from the top
	mov dx, offset DropDownRBCover
	call CountinuationBMP
@@CheckingWhichRoute:
	call TakeAChar
	cmp al, 'a'
	je BMPCutback
	cmp al, 'b'
	je BMPDive
	cmp al, 'c'
	je BMPMisdirection
	cmp al, 'd'
	je BMPOutside
	cmp al, 'e'
	je BMPPower
	cmp al, 'f'
	je BMPSlam
	cmp al, 'g'
	je BMPStrech
	cmp al, 'h'
	je BMPToss
	cmp al, 'i'
	je BMPWheel
	cmp al, 'j'
	je BMPZone
	cmp al, '0'
	je @@FinishTheDD
	cmp al, 01bh
	je FoundEscapeRB
	jmp @@BeginningOfDropDown
BMPCutback:
	call Cutback 
	jmp @@BeginningOfDropDown
BMPDive:
	call Dive 
	jmp @@BeginningOfDropDown
BMPMisdirection:
	call Misdirection
	jmp @@BeginningOfDropDown
	
BMPOutside:
	call Outside
	jmp @@BeginningOfDropDown
	
BMPPower:
	call Power 
	jmp @@BeginningOfDropDown
	
BMPSlam:
	call Slam
	jmp @@BeginningOfDropDown
	
BMPStrech:
	call Strech
	jmp @@BeginningOfDropDown
BMPToss:
	call Toss
	jmp @@BeginningOfDropDown
	
BMPWheel:
	call Wheel
	jmp @@BeginningOfDropDown
	
BMPZone:
	call Zone
	jmp @@BeginningOfDropDown
	

FoundEscapeRB:
	mov [BackToSearchOrQuiz], 1
	jmp @@ActualFinish
@@FinishTheDD:
	mov [FinishProgram], 1
@@ActualFinish:
	ret 
endp

proc QuizRB
StartQuizRB:
	mov [ADone], 0
	mov [BDone], 0
	mov [CDone], 0
	mov [DDone], 0
	mov [totalRand], 0
	mov [SecondAnswer], 0
	mov [ThirdAnswer], 0
	mov [FourthAnswer], 0
	mov [AnswerAlreadyPrinted], 0
	mov [CorrectAnswer], 0
	mov [QuizOrSearch], 1
	mov [y], 164
	mov [BmpColSize], 320 ;x
	mov [BmpRowSize], 200 ;y
	mov [BmpLeft],0 ;actual both sides - col divided by 2
	mov [BmpTop], 0 ; margin from the top
	mov dx, offset BackgroundForRoutesQuiz
	call CountinuationBMP

	mov [randSize], 11 ;10
	call rand 
	
	cmp dx, 1 ;cutback 
	je RunCutback
	cmp dx, 2 ;dive
	je RunDive
	cmp dx, 3 ; misdirection
	je RunMisdirection
	cmp dx, 4 ; Outside
	je RunOutside
	cmp dx, 5 ; power
	je RunPower
	cmp dx, 6 ;slam
	je RunSlam
	cmp dx, 7 ; strech
	je RunStrech
	cmp dx, 8 ;toss
	je RunToss
	cmp dx, 9 ; wheel 
	je RunWheel
	cmp dx, 10 ; zone 
	je RunZone
	
RunCutback:
	call Cutback 
	jmp CountinueQuizRB
RunDive:
	call Dive
	jmp CountinueQuizRB
RunMisdirection:
	call Misdirection
	jmp CountinueQuizRB
RunOutside:
	call Outside
	jmp CountinueQuizRB
RunPower:
	call Power 
	jmp CountinueQuizRB
RunSlam:
	call Slam
	jmp CountinueQuizRB
RunStrech:
	call Strech 
	jmp CountinueQuizRB
RunToss:
	call toss
	jmp CountinueQuizRB
RunWheel:
	call Wheel
	jmp CountinueQuizRB
RunZone:
	call Zone 
	
CountinueQuizRB:
	mov si, offset RoutesOffsetArrayRB
	mov bx, offset RBRoutesArray
	mov cx, [totalRand]
GetToRouteRB:
	mov dx, [si]
	xor dh, dh
	add bx, dx 
	inc si 
	loop GetToRouteRB
	
	; push bx 
	; push si
	; push dx 
	
	mov [randSize], 5
	mov [LetterOrNumber], 1
	call rand 
	mov [CorrectAnswer], dl
	add [CorrectAnswer], 60h ;get to it's ascii value 
	mov [LetterOrNumber], 0
	
	cmp dx, 1 ;a
	je AIsAnswerRB
	cmp dx, 2 ;b
	je BIsAnswerRB
	cmp dx, 3 ;c
	je CIsAnswerRB
	cmp dx, 4 ;d
	je DIsAnswerRB
AIsAnswerRB:
	push bx
	push si
	mov dh, 3 ;row
	mov dl, 10 ;column
	call ChangeCursor
	mov al, 'a'
	call PrintColoredChar
	mov al, '.'
	call PrintColoredChar
	pop si 
	pop bx 
	mov [ADone], 1
	cmp [AnswerAlreadyPrinted], 1
	jne FinishARB
	mov [randSize], 11
	call rand 
	jmp NeedToPrintAnAnswerRB
FinishARB:
	jmp HereRB
BIsAnswerRB:
	push bx 
	push si 
	mov dh, 3 ;row
	mov dl, 20 ;column
	call ChangeCursor
	mov al, 'b'
	call PrintColoredChar
	mov al, '.'
	call PrintColoredChar
	pop si 
	pop bx 
	mov [BDone], 1
	cmp [AnswerAlreadyPrinted], 1
	jne FinishBRB
	mov [randSize], 11
	call rand 
	jmp NeedToPrintAnAnswerRB
FinishBRB:
	jmp HereRB
CIsAnswerRB:
	push bx 
	push si 
	mov dh, 6 ;row
	mov dl, 10 ;column
	call ChangeCursor
	mov al, 'c'
	call PrintColoredChar
	mov al, '.'
	call PrintColoredChar
	pop si 
	pop bx 
	mov [CDone], 1
	cmp [AnswerAlreadyPrinted], 1
	jne FinishCRB
	mov [randSize], 11
	call rand 
	jmp NeedToPrintAnAnswerRB
FinishCRB:
	jmp HereRB
DIsAnswerRB:
	push bx 
	push si 
	mov dh, 6 ;row
	mov dl, 20 ;column
	call ChangeCursor
	mov al, 'd'
	call PrintColoredChar
	mov al, '.'
	call PrintColoredChar
	pop si 
	pop bx 
	mov [DDone], 1
	cmp [AnswerAlreadyPrinted], 1
	jne FinishDRB
	mov [randSize], 11
	call rand 
	jmp NeedToPrintAnAnswerRB
FinishDRB:

HereRB:
	; pop dx
	; pop si
	; pop bx
	
	mov dx, [si]
	xor dh, dh
	mov cx, dx
PrintTheRouteRB:
	mov al, [bx]
	push bx 
	call PrintColoredChar
	pop bx 
	inc bx
	loop PrintTheRouteRB
	
	; mov dl, [CorrectAnswer]
	; add dl, 30h
	; call PrintAChar
	
	
CheckIfAllOptionsArePrintedRB:
	mov [AnswerAlreadyPrinted], 1 
	cmp [ADone], 1
	jne AIsAnswerRB
	cmp [BDone], 1
	jne BIsAnswerRB
	cmp [Cdone], 1
	jne CIsAnswerRB
	cmp [Ddone], 1
	jne DIsAnswerRB
	jmp CheckUserAnswerRB
	
NeedToPrintAnAnswerRB:
	mov si, offset RoutesOffsetArrayRB
	mov bx, offset RBRoutesArray
	mov cx, dx
GetToRouteRB2:
	mov dx, [si]
	xor dh, dh
	add bx, dx 
	inc si 
	loop GetToRouteRB2

	mov dx, [si]
	xor dh, dh
	mov cx, dx
PrintTheRouteRB1:
	mov al, [bx]
	push bx 
	call PrintColoredChar
	pop bx 
	inc bx
	loop PrintTheRouteRB1
	jmp CheckIfAllOptionsArePrintedRB
CheckUserAnswerRB:
	call TakeAChar ;char in al 
	mov cl, [CorrectAnswer]
	cmp al, cl 
	je CorrectAnsRB
	
	mov [BmpColSize], 320 ;x
	mov [BmpRowSize], 200 ;y
	mov [BmpLeft],0 ;actual both sides - col divided by 2
	mov [BmpTop], 0 ; margin from the top
	mov dx, offset InCorrectBMP
	call CountinuationBMP
	jmp CheckInputRB
CorrectAnsRB: 
	mov [BmpColSize], 320 ;x
	mov [BmpRowSize], 200 ;y
	mov [BmpLeft],0 ;actual both sides - col divided by 2
	mov [BmpTop], 0 ; margin from the top
	mov dx, offset CorrectBMP
	call CountinuationBMP
CheckInputRB:
	mov ah, 00h
	int 16h 
	in al, 60h 
	cmp al, 19h ;p - play again 
	je FoundPRB
	cmp al, 21h ;f -finish the program 
	je FoundFRB
	cmp al, 01h
	je FoundEscRB
	jmp CheckInputRB
FoundPRB:
	jmp StartQuizRB
FoundFRB:
	mov [FinishProgram], 1
	jmp FinishQuizRB
FoundEscRB:
	mov [BackToSearchOrQuiz], 1
FinishQuizRB:
	ret 
	
	ret
endp 

proc DropDownWR  
@@BeginningOfDropDown:

	mov [QuizOrSearch], 0 ;means need for arrow 
	
	mov [BmpColSize], 320 ;x
	mov [BmpRowSize], 200 ;y
	mov [BmpLeft],0 ;actual both sides - col divided by 2
	mov [BmpTop], 0 ; margin from the top
	mov dx, offset DropDownWRCover
	call CountinuationBMP
@@CheckingWhichRoute:
	call TakeAChar
	cmp al, 'a'
	je BMPCorner
	cmp al, 'b'
	je BMPCurl 
	cmp al, 'c'
	je BMPDrag
	cmp al, 'd'
	je BMPFade 
	cmp al, 'e'
	je BMPFlat
	cmp al, 'f'
	je BMPHitch
	cmp al, 'g'
	je BMPIn
	cmp al, 'h'
	je BMPOut
	cmp al, 'i'
	je BMPPost
	cmp al, 'j'
	je BMPSlant
	cmp al, 'k'
	je BMPStreak 
	cmp al, 'l'
	je BMPZig
	cmp al, '0'
	je @@FinishTheDD
	cmp al, 01bh
	je FoundEscapeWR
	jmp @@BeginningOfDropDown
BMPCorner:
	call Corner 
	jmp @@BeginningOfDropDown
BMPCurl:
	call Curl 
	jmp @@BeginningOfDropDown
BMPDrag:
	call Drag
	jmp @@BeginningOfDropDown
	
BMPFade:
	call Fade
	jmp @@BeginningOfDropDown
	
BMPFlat:
	call FlatRoute
	jmp @@BeginningOfDropDown
	
BMPHitch:
	call Hitch
	jmp @@BeginningOfDropDown
	
BMPIn:
	call InRoute
	jmp @@BeginningOfDropDown
BMPOut:
	call OutRoute
	jmp @@BeginningOfDropDown
	
BMPPost:
	call Post 
	jmp @@BeginningOfDropDown
	
BMPSlant:
	call Slant 
	jmp @@BeginningOfDropDown
	
BMPStreak:
	call Streak 
	jmp @@BeginningOfDropDown
BMPZig:
	call Zig 
	jmp @@BeginningOfDropDown


FoundEscapeWR:
	mov [BackToSearchOrQuiz], 1
	jmp @@ActualFinish
@@FinishTheDD:
	
@@ActualFinish:
	ret
endp

proc QuizWR
@@StartQuiz:
	mov [ADone], 0
	mov [BDone], 0
	mov [CDone], 0
	mov [DDone], 0
	mov [totalRand], 0
	mov [SecondAnswer], 0
	mov [ThirdAnswer], 0
	mov [FourthAnswer], 0
	mov [AnswerAlreadyPrinted], 0
	mov [CorrectAnswer], 0
	mov [y], 164
	mov [NumberOfRoutesWR], 0
	mov bx, offset RoutesOffsetArrayWR
	call HowManyRoutes
	mov [NumberOfRoutesWR], di
	mov [QuizOrSearch], 1 ;means no need for arrow 
	mov [BmpColSize], 320 ;x
	mov [BmpRowSize], 200 ;y
	mov [BmpLeft],0 ;actual both sides - col divided by 2
	mov [BmpTop], 0 ; margin from the top
	mov dx, offset BackgroundForRoutesQuiz
	call CountinuationBMP

	mov [randSize], 13
	call rand 
	
	cmp dx, 1 ;corner
	je RouteCorner
	cmp dx, 2 ;curl
	je RouteCurl
	cmp dx, 3 ; drag
	je RouteDrag
	cmp dx, 4 ; fade
	je RouteFade
	cmp dx, 5 ; flat 
	je RouteFlat
	cmp dx, 6 ;hitch
	je RouteHitch
	cmp dx, 7 ;in
	je RouteIn
	cmp dx, 8 ;out
	je RouteOut
	cmp dx, 9 ; post
	je RoutePost
	cmp dx, 10 ;slant
	je RouteSlant
	cmp dx, 11 ;streak
	je RouteStreak
	cmp dx, 12 ;zig
	je RouteZig
	
RouteCorner:
	call Corner
	jmp @@CountinueQuiz
RouteCurl:
	call Curl
	jmp @@CountinueQuiz
RouteDrag:
	call Drag
	jmp @@CountinueQuiz
RouteFade:
	call Fade
	jmp @@CountinueQuiz
RouteFlat:
	call FlatRoute
	jmp @@CountinueQuiz
RouteHitch:
	call Hitch
	jmp @@CountinueQuiz
RouteIn:
	call InRoute 
	jmp @@CountinueQuiz
RouteOut:
	call OutRoute
	jmp @@CountinueQuiz
RoutePost:
	call Post 
	jmp @@CountinueQuiz
RouteSlant:
	call Slant 
	jmp @@CountinueQuiz
RouteStreak:
	call Streak
	jmp @@CountinueQuiz
RouteZig: 
	call Zig
	
@@CountinueQuiz:
	mov si, offset RoutesOffsetArrayWR 
	mov bx, offset WRRoutesArray
	mov cx, [totalRand]
@@GetToRoute:
	mov dx, [si]
	xor dh, dh
	add bx, dx 
	inc si 
	loop @@GetToRoute
	
	; push bx 
	; push si
	; push dx 
	
	mov [randSize], 5
	mov [LetterOrNumber], 1
	call rand 
	mov [CorrectAnswer], dl
	add [CorrectAnswer], 60h ;get to it's ascii value 
	mov [LetterOrNumber], 0
	
	cmp dx, 1 ;a
	je @@AIsAnswer
	cmp dx, 2 ;b
	je @@BIsAnswer
	cmp dx, 3 ;c
	je @@CIsAnswer
	cmp dx, 4 ;d
	je @@DIsAnswer
@@AIsAnswer:
	push bx
	push si
	mov dh, 3 ;row
	mov dl, 10 ;column
	call ChangeCursor
	mov al, 'a'
	call PrintColoredChar
	mov al, '.'
	call PrintColoredChar
	pop si 
	pop bx 
	mov [ADone], 1
	cmp [AnswerAlreadyPrinted], 1
	jne @@FinishA
	mov [randSize], 13
	call rand 
	jmp @@NeedToPrintAnAnswer
@@FinishA:
	jmp @@Here
@@BIsAnswer:
	push bx 
	push si 
	mov dh, 3 ;row
	mov dl, 20 ;column
	call ChangeCursor
	mov al, 'b'
	call PrintColoredChar
	mov al, '.'
	call PrintColoredChar
	pop si 
	pop bx 
	mov [BDone], 1
	cmp [AnswerAlreadyPrinted], 1
	jne @@FinishB
	mov [randSize], 13
	call rand 
	jmp @@NeedToPrintAnAnswer
@@FinishB:
	jmp @@Here
@@CIsAnswer:
	push bx 
	push si 
	mov dh, 6 ;row
	mov dl, 10 ;column
	call ChangeCursor
	mov al, 'c'
	call PrintColoredChar
	mov al, '.'
	call PrintColoredChar
	pop si 
	pop bx 
	mov [CDone], 1
	cmp [AnswerAlreadyPrinted], 1
	jne @@FinishC
	mov [randSize], 13
	call rand 
	jmp @@NeedToPrintAnAnswer
@@FinishC:
	jmp @@Here
@@DIsAnswer:
	push bx 
	push si 
	mov dh, 6 ;row
	mov dl, 20 ;column
	call ChangeCursor
	mov al, 'd'
	call PrintColoredChar
	mov al, '.'
	call PrintColoredChar
	pop si 
	pop bx 
	mov [DDone], 1
	cmp [AnswerAlreadyPrinted], 1
	jne @@FinishD
	mov [randSize], 13
	call rand 
	jmp @@NeedToPrintAnAnswer
@@FinishD:

@@Here:
	; pop dx
	; pop si
	; pop bx
	
	mov dx, [si]
	xor dh, dh
	mov cx, dx
@@PrintTheRoute:
	mov al, [bx]
	push bx 
	call PrintColoredChar
	pop bx 
	inc bx
	loop @@PrintTheRoute
	
	; mov dl, [CorrectAnswer]
	; add dl, 30h
	; call PrintAChar
	
	
@@CheckIfAllOptionsArePrinted:
	mov [AnswerAlreadyPrinted], 1 
	cmp [ADone], 1
	jne @@AIsAnswer
	cmp [BDone], 1
	jne @@BIsAnswer
	cmp [Cdone], 1
	jne @@CIsAnswer
	cmp [Ddone], 1
	jne @@DIsAnswer
	jmp @@CheckUserAnswer
	
@@NeedToPrintAnAnswer:
	mov si, offset RoutesOffsetArrayWR 
	mov bx, offset WRRoutesArray
	mov cx, dx
@@GetToRoute2:
	mov dx, [si]
	xor dh, dh
	add bx, dx 
	inc si 
	loop @@GetToRoute2

	mov dx, [si]
	xor dh, dh
	mov cx, dx
@@PrintTheRoute2:
	mov al, [bx]
	push bx 
	call PrintColoredChar
	pop bx 
	inc bx
	loop @@PrintTheRoute2
	jmp @@CheckIfAllOptionsArePrinted
@@CheckUserAnswer:
	call TakeAChar ;char in al 
	mov cl, [CorrectAnswer]
	cmp al, cl 
	je @@CorrectAns
	
	mov [BmpColSize], 320 ;x
	mov [BmpRowSize], 200 ;y
	mov [BmpLeft],0 ;actual both sides - col divided by 2
	mov [BmpTop], 0 ; margin from the top
	mov dx, offset InCorrectBMP
	call CountinuationBMP
	jmp @@CheckInput
@@CorrectAns: 
	mov [BmpColSize], 320 ;x
	mov [BmpRowSize], 200 ;y
	mov [BmpLeft],0 ;actual both sides - col divided by 2
	mov [BmpTop], 0 ; margin from the top
	mov dx, offset CorrectBMP
	call CountinuationBMP
@@CheckInput:
	mov ah, 00h
	int 16h 
	in al, 60h 
	cmp al, 19h ;p - play again 
	je @@FoundP
	cmp al, 21h ;f -finish the program 
	je @@FoundF
	cmp al, 01h
	je @@FoundEsc
	jmp @@CheckInput
@@FoundP:
	jmp @@StartQuiz
@@FoundF:
	mov [FinishProgram], 1
	jmp @@FinishQuiz
@@FoundEsc:
	mov [BackToSearchOrQuiz], 1
@@FinishQuiz:
	ret 
endp

proc DropDownQB
@@BeginningOfDropDown:

	mov [QuizOrSearch], 0 ;means need for arrow 
	
	mov [BmpColSize], 320 ;x
	mov [BmpRowSize], 200 ;y
	mov [BmpLeft],0 ;actual both sides - col divided by 2
	mov [BmpTop], 0 ; margin from the top
	mov dx, offset DropDownQBCover
	call CountinuationBMP
@@CheckingWhichRoute:
	call TakeAChar
	cmp al, 'a'
	je BMPCornerQB
	cmp al, 'b'
	je BMPCurlQB
	cmp al, 'c'
	je BMPCutbackQB
	cmp al, 'd'
	je BMPDiveQB
	cmp al, 'e'
	je BMPDragQB
	cmp al, 'f'
	je BMPFadeQB
	cmp al, 'g'
	je BMPFlatQB
	cmp al, 'h'
	je BMPHitchQB
	cmp al, 'i'
	je BMPInQB
	cmp al, 'j'
	je BMPMisdirectionQB
	cmp al, 'k'
	je BMPOutQB 
	cmp al, 'l'
	je BMPOutsideQB
	cmp al, 'm'
	je BMPPostQB
	cmp al, 'n'
	je BMPPowerQB
	cmp al, 'o'
	je BMPSlamQB
	cmp al, 'p'
	je BMPSlantQB
	cmp al, 'q'
	je BMPStreakQB
	cmp al, 'r'
	je BMPStrechQB
	cmp al, 's'
	je BMPTossQB
	cmp al, 't'
	je BMPWheelQB
	cmp al, 'u'
	je BMPZigQB
	cmp al, 'v'
	je BMPZoneQB
	cmp al, '0'
	je @@FinishTheDD
	cmp al, 01bh
	je FoundEscapeQB
	jmp @@BeginningOfDropDown
	
	
BMPCutbackQB:
	call Cutback 
	jmp @@BeginningOfDropDown
BMPDiveQB:
	call Dive 
	jmp @@BeginningOfDropDown
BMPMisdirectionQB:
	call Misdirection
	jmp @@BeginningOfDropDown
	
BMPOutsideQB:
	call Outside
	jmp @@BeginningOfDropDown
	
BMPPowerQB:
	call Power 
	jmp @@BeginningOfDropDown
	
BMPSlamQB:
	call Slam
	jmp @@BeginningOfDropDown
	
BMPStrechQB:
	call Strech
	jmp @@BeginningOfDropDown
BMPTossQB:
	call Toss
	jmp @@BeginningOfDropDown
	
BMPWheelQB:
	call Wheel
	jmp @@BeginningOfDropDown
	
BMPZoneQB:
	call Zone
	jmp @@BeginningOfDropDown

BMPCornerQB:
	call Corner 
	jmp @@BeginningOfDropDown
BMPCurlQB:
	call Curl 
	jmp @@BeginningOfDropDown
BMPDragQB:
	call Drag
	jmp @@BeginningOfDropDown
	
BMPFadeQB:
	call Fade
	jmp @@BeginningOfDropDown
	
BMPFlatQB:
	call FlatRoute
	jmp @@BeginningOfDropDown
	
BMPHitchQB:
	call Hitch
	jmp @@BeginningOfDropDown
	
BMPInQB:
	call InRoute
	jmp @@BeginningOfDropDown
BMPOutQB:
	call OutRoute
	jmp @@BeginningOfDropDown
	
BMPPostQB:
	call Post 
	jmp @@BeginningOfDropDown
	
BMPSlantQB:
	call Slant 
	jmp @@BeginningOfDropDown
	
BMPStreakQB:
	call Streak 
	jmp @@BeginningOfDropDown
BMPZigQB:
	call Zig 
	jmp @@BeginningOfDropDown


FoundEscapeQB:
	mov [BackToSearchOrQuiz], 1
	jmp @@ActualFinish
@@FinishTheDD:
	
@@ActualFinish:
	ret
	
endp


proc QuizQB
@@StartQuiz:
	mov [ADone], 0
	mov [BDone], 0
	mov [CDone], 0
	mov [DDone], 0
	mov [totalRand], 0
	mov [SecondAnswer], 0
	mov [ThirdAnswer], 0
	mov [FourthAnswer], 0
	mov [AnswerAlreadyPrinted], 0
	mov [CorrectAnswer], 0
	mov [y], 164
	mov [QuizOrSearch], 1 ;means no need for arrow 
	mov [BmpColSize], 320 ;x
	mov [BmpRowSize], 200 ;y
	mov [BmpLeft],0 ;actual both sides - col divided by 2
	mov [BmpTop], 0 ; margin from the top
	mov dx, offset BackgroundForRoutesQuiz
	call CountinuationBMP

	mov [randSize], 23
	call rand 
	
	cmp dx, 1 ;corner
	je RouteCornerQB
	cmp dx, 2 ;curl
	je RouteCurlQB
	cmp dx, 3 ;cutback
	je RunCutbackQB
	cmp dx, 4 ;dive
	je RunDiveQB
	cmp dx, 5 ; drag
	je RouteDragQB
	cmp dx, 6 ; fade
	je RouteFadeQB
	cmp dx, 7 ; flat 
	je RouteFlatQB
	cmp dx, 8 ;hitch
	je RouteHitchQB
	cmp dx, 9 ;in
	je RouteInQB
	cmp dx, 10 ;misdir
	je RunMisdirectionQB
	cmp dx, 11 ; out
	je RunOutQB
	cmp dx, 12 ;outside
	je RunOutsideQB
	cmp dx, 13 ;post 
	je RoutePostQB
	cmp dx, 14 ;power
	je RunPowerQB
	cmp dx, 15 ;slam
	je RunSlamQB
	cmp dx, 16 ;slant
	je RouteSlantQB
	cmp dx, 17 ;streak
	je RouteStreakQB
	cmp dx, 18 ;strech
	je RunStrechQB
	cmp dx, 19 ;toss
	je RunTossQB
	cmp dx, 20 ;wheel
	je RunWheelQB
	cmp dx, 21 ;zig
	je RouteZigQB
	cmp dx, 22 ;zone
	je RunZoneQB
	
RouteCornerQB:
	call Corner 
	jmp CountinueQuizQB
RouteCurlQB:
	call Curl
	jmp CountinueQuizQB
RunCutbackQB:
	call Cutback 
	jmp CountinueQuizQB
RunDiveQB:
	call Dive
	jmp CountinueQuizQB
RouteDragQB:
	call Drag
	jmp CountinueQuizQB
RouteFadeQB: 
	call Fade
	jmp CountinueQuizQB
RouteFlatQB: 
	call RouteFlat
	jmp CountinueQuizQB
RouteHitchQB:
	call Hitch
	jmp CountinueQuizQB
RouteInQB: 
	call RouteIn
	jmp CountinueQuizQB
RunMisdirectionQB:
	call Misdirection
	jmp CountinueQuizQB
RunOutQB: 
	call RouteOut
	jmp CountinueQuizQB
RunOutsideQB: 
	call Outside
	jmp CountinueQuizQB
RoutePostQB: 
	call Post 
	jmp CountinueQuizQB
RunPowerQB: 
	call Power
	jmp CountinueQuizQB
RunSlamQB: 
	call Slam
	jmp CountinueQuizQB
RouteSlantQB:
	call Slant 
	jmp CountinueQuizQB
RouteStreakQB: 
	call Streak
	jmp CountinueQuizQB
RunStrechQB: 
	call Strech
	jmp CountinueQuizQB
RunTossQB: 
	call Toss
	jmp CountinueQuizQB
RunWheelQB: 
	call Wheel 
	jmp CountinueQuizQB
RouteZigQB: 
	call Zig
	jmp CountinueQuizQB
RunZoneQB:
	call Zone
	
	
CountinueQuizQB:
	mov si, offset RoutesOffsetArrayQB 
	mov bx, offset QBRoutesArray
	mov cx, [totalRand]
@@GetToRoute:
	mov dx, [si]
	xor dh, dh
	add bx, dx 
	inc si 
	loop @@GetToRoute
	
	; push bx 
	; push si
	; push dx 
	
	mov [randSize], 5
	mov [LetterOrNumber], 1
	call rand 
	mov [CorrectAnswer], dl
	add [CorrectAnswer], 60h ;get to it's ascii value 
	mov [LetterOrNumber], 0
	
	cmp dx, 1 ;a
	je @@AIsAnswer
	cmp dx, 2 ;b
	je @@BIsAnswer
	cmp dx, 3 ;c
	je @@CIsAnswer
	cmp dx, 4 ;d
	je @@DIsAnswer
@@AIsAnswer:
	push bx
	push si
	mov dh, 3 ;row
	mov dl, 10 ;column
	call ChangeCursor
	mov al, 'a'
	call PrintColoredChar
	mov al, '.'
	call PrintColoredChar
	pop si 
	pop bx 
	mov [ADone], 1
	cmp [AnswerAlreadyPrinted], 1
	jne @@FinishA
	mov [randSize], 23
	call rand 
	jmp @@NeedToPrintAnAnswer
@@FinishA:
	jmp @@Here
@@BIsAnswer:
	push bx 
	push si 
	mov dh, 3 ;row
	mov dl, 20 ;column
	call ChangeCursor
	mov al, 'b'
	call PrintColoredChar
	mov al, '.'
	call PrintColoredChar
	pop si 
	pop bx 
	mov [BDone], 1
	cmp [AnswerAlreadyPrinted], 1
	jne @@FinishB
	mov [randSize], 23 
	call rand 
	jmp @@NeedToPrintAnAnswer
@@FinishB:
	jmp @@Here
@@CIsAnswer:
	push bx 
	push si 
	mov dh, 6 ;row
	mov dl, 10 ;column
	call ChangeCursor
	mov al, 'c'
	call PrintColoredChar
	mov al, '.'
	call PrintColoredChar
	pop si 
	pop bx 
	mov [CDone], 1
	cmp [AnswerAlreadyPrinted], 1
	jne @@FinishC
	mov [randSize], 23
	call rand 
	jmp @@NeedToPrintAnAnswer
@@FinishC:
	jmp @@Here
@@DIsAnswer:
	push bx 
	push si 
	mov dh, 6 ;row
	mov dl, 20 ;column
	call ChangeCursor
	mov al, 'd'
	call PrintColoredChar
	mov al, '.'
	call PrintColoredChar
	pop si 
	pop bx 
	mov [DDone], 1
	cmp [AnswerAlreadyPrinted], 1
	jne @@FinishD
	mov [randSize], 23
	call rand 
	jmp @@NeedToPrintAnAnswer
@@FinishD:

@@Here:
	; pop dx
	; pop si
	; pop bx
	
	mov dx, [si]
	xor dh, dh
	mov cx, dx
@@PrintTheRoute:
	mov al, [bx]
	push bx 
	call PrintColoredChar
	pop bx 
	inc bx
	loop @@PrintTheRoute
	
	; mov dl, [CorrectAnswer]
	; add dl, 30h
	; call PrintAChar
	
	
@@CheckIfAllOptionsArePrinted:
	mov [AnswerAlreadyPrinted], 1 
	cmp [ADone], 1
	jne @@AIsAnswer
	cmp [BDone], 1
	jne @@BIsAnswer
	cmp [Cdone], 1
	jne @@CIsAnswer
	cmp [Ddone], 1
	jne @@DIsAnswer
	jmp @@CheckUserAnswer
	
@@NeedToPrintAnAnswer:
	mov si, offset RoutesOffsetArrayQB 
	mov bx, offset QBRoutesArray
	mov cx, dx
@@GetToRoute2:
	mov dx, [si]
	xor dh, dh
	add bx, dx 
	inc si 
	loop @@GetToRoute2

	mov dx, [si]
	xor dh, dh
	mov cx, dx
@@PrintTheRoute2:
	mov al, [bx]
	push bx 
	call PrintColoredChar
	pop bx 
	inc bx
	loop @@PrintTheRoute2
	jmp @@CheckIfAllOptionsArePrinted
@@CheckUserAnswer:
	call TakeAChar ;char in al 
	mov cl, [CorrectAnswer]
	cmp al, cl 
	je @@CorrectAns
	
	mov [BmpColSize], 320 ;x
	mov [BmpRowSize], 200 ;y
	mov [BmpLeft],0 ;actual both sides - col divided by 2
	mov [BmpTop], 0 ; margin from the top
	mov dx, offset InCorrectBMP
	call CountinuationBMP
	jmp @@CheckInput
@@CorrectAns: 
	mov [BmpColSize], 320 ;x
	mov [BmpRowSize], 200 ;y
	mov [BmpLeft],0 ;actual both sides - col divided by 2
	mov [BmpTop], 0 ; margin from the top
	mov dx, offset CorrectBMP
	call CountinuationBMP
@@CheckInput:
	mov ah, 00h
	int 16h 
	in al, 60h 
	cmp al, 19h ;p - play again 
	je @@FoundP
	cmp al, 21h ;f -finish the program 
	je @@FoundF
	cmp al, 01h
	je @@FoundEsc
	jmp @@CheckInput
@@FoundP:
	jmp @@StartQuiz
@@FoundF:
	mov [FinishProgram], 1
	jmp @@FinishQuiz
@@FoundEsc:
	mov [BackToSearchOrQuiz], 1
@@FinishQuiz:
	ret
endp 
proc EndOfProject
	mov [BmpColSize], 320 ;x
	mov [BmpRowSize], 200 ;y
	mov [BmpLeft],0 ;actual both sides - col divided by 2
	mov [BmpTop], 0 ; margin from the top
	mov dx, offset ThanksBMP
	call CountinuationBMP
	mov ah, 00h
	int 16h
	ret
endp

start:
	mov ax, @data
	mov ds, ax
	
	call Zeroing
	call GraphicMode
	call StartOfProject
	call EndOfProject
	call TextMode
; --------------------------
; Your code here
; --------------------------
	
exit:
	mov ax, 4c00h
	int 21h
END start


