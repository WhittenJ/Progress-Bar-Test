#SingleInstance,Force

myMax := 100
myMin := 0

Gui,1:+AlwaysOnTop

Gui,1:Add,Progress,x10 y10 w310 h30 BackgroundBlack cMaroon vProgress1 Range%myMin%-%myMax%,0
Gui,1:Add,Button,x10 w150 h30 vButton1 gAdd_Subtract, Add To Progress
Gui,1:Add,Button,x+10 w150 h30 vButton2 gAdd_Subtract, Subtract From Progress
Gui,1:Add,Button,x10 w150 h30 gLooping, Loop over list
Gui,1:Add,Button,x+10 w150 h30 gChange_Range, Change Range

Gui,1:Show
Gui,1:Submit,NoHide

Gui,2:Add,Progress,x10 y10 w310 h30 BackgroundBlack cMaroon vProgress1 Range%myMin%-%myMax%,0
return

GuiClose:
	ExitApp
	
Add_Subtract:
	if(A_GuiControl="Button1" && (Progress1 <= (myMax-1)))
		{
			Progress1++
			GuiControl,1: ,Progress1, % Progress1
		}
	else if(A_GuiControl="Button2" && (Progress1 >= (myMin+1)))
		{
			Progress1--
			GuiControl,1: ,Progress1, % Progress1
		}
	return
		
Looping:
	Gui,1:Hide
	Gui,2:Show

	List1 := [1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0]
	Progress1 := 0
	GuiControl,2: ,Progress1, % Progress1
	Temp := ""
	Loop, 100 ; This is bad. Check list length.
		{
			Temp .= List1[A_Index]
			Progress1++
			GuiControl,2: ,Progress1, % Progress1
			Sleep, 33
		}
		
	Gui,1:Show
	Gui,2:Hide
	
	return
		
Change_Range:
	; Ranges
	Low_Range := 10
	High_Range := 100
	
	; Reset Progress Bar
	Progress1 := 0
	GuiControl,1: ,Progress1, % Progress1
	
	; Set flag to flip between Low/High Range
	Range_Flag := !Range_Flag
	
	; Set Range
	if(Range_Flag)
		{
		GuiControl,1: +Range%myMin%-%Low_Range%, Progress1
		}
	else if(!Range_Flag)
		{
		GuiControl,1: +Range%myMin%-%High_Range%, Progress1
		}
	
	return
	
*ESC::ExitApp