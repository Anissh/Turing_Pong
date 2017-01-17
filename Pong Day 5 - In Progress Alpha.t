setscreen ("graphics:600,600")

var x, y : int
var dirx, diry : int
var px, py, pxx, pyy : int
var dirpx, dirpy : int
var dirpxx, dirpyy : int
var c : int
var u : int
var score : int
var score1 : int
var font1 : int
var colour1 : int
var colour2 : int
var response : int

score := 0
score1 := 0

dirx := 1
diry := 1

var k : string (1)

x := 10
y := 280

dirpx := 10
dirpy := 10
dirpxx := 10
dirpyy := 3

pxx := 25
px := 550
py := 200
pyy := 200

font1 := Font.New ("Agency FB:20")
Draw.Text ("This is PONG, made by Anissh. Click a button to start game", 75, 400, font1, black)
getch (k)
cls

put "Press 1 to play Single Player (vs. AI)"
put "Press 2 to play Multiplayer"
get response
delay (1500)

setscreen ("graphics:650,650")
put "Enter a number between 1 and 247. This will be your paddle colour"
Pic.ScreenLoad ("Colour.jpg", 0, 0, picMerge)
get colour1
delay (1500)
cls
put "Enter a number between 1 and 247. This will be the opponent's paddle colour"
Pic.ScreenLoad ("Colour.jpg", 0, 0, picMerge)
get colour2
delay (1500)
cls
setscreen ("graphics:600,600")
delay (2000)
var finished : boolean
finished := false
process music (nme : string)
    loop
	exit when finished
	Music.PlayFile (nme)
    end loop
end music

procedure drawball
    drawfilloval (x, y, 5, 5, red)
end drawball

procedure eraseball
    drawfilloval (x, y, 5, 5, white)
end eraseball

procedure drawpaddle
    drawfillbox (px, py, px + 30, py + 80, colour2)
end drawpaddle

procedure erasepaddle
    drawfillbox (px, py, px + 30, py + 80, white)
end erasepaddle

procedure drawsecondpaddle
    drawfillbox (pxx, pyy, pxx + 30, pyy + 80, colour1)
end drawsecondpaddle

procedure erasesecondpaddle
    drawfillbox (pxx, pyy, pxx + 30, pyy + 80, white)
end erasesecondpaddle

process mousepaddle
    var mx, my, button : int
    loop
	Mouse.Where (mx, my, button)

	py := my
	drawpaddle
	delay (3)
	erasepaddle
    end loop
end mousepaddle
fork mousepaddle

k := "z"
locate (1, 20)
put "Time: ", Time.Elapsed / 1000

if response = 2 then
    loop
	if hasch () then
	    getch (k)
	end if
	if k = KEY_UP_ARROW then
	    dirpy := 1
	    py := py + dirpy
	end if

	if hasch () then
	    getch (k)
	end if
	if k = KEY_DOWN_ARROW then
	    dirpy := -1
	    py := py + dirpy
	end if

	if hasch () then
	    getch (k)
	end if
	if k = 'w' then
	    dirpyy := 1
	    pyy := pyy + dirpyy
	end if

	if hasch () then
	    getch (k)
	end if
	if k = 's' then
	    dirpyy := -1
	    pyy := pyy + dirpyy
	end if

	drawpaddle
	drawsecondpaddle
	drawball
	c := whatdotcolor (x + 10, y)
	if c = colour2 then
	    dirx := -1
	end if
	u := whatdotcolor (x - 10, y)
	if u = colour1 then
	    dirx := 1
	end if
	delay (5)
	eraseball
	erasepaddle
	erasesecondpaddle

	if py > 520 or py < 1 then
	    dirpy := 0
	    k := "z"
	end if

	if pyy > 520 or pyy < 1 then
	    dirpyy := 0
	    k := "z"
	end if

	if x > 599 or x < 1 then
	    dirx := dirx * -1
	end if

	if y > 599 or y < 1 then
	    diry := diry * -1
	end if

	x := x + dirx
	y := y + diry
	locate (1, 1)
	put score ..
	locate (1, 75)
	put score1 ..

	if x > 599 then
	    score := score + 1
	    exit when score = 10
	end if

	if x < 1 then
	    score1 := score1 + 1
	    exit when score1 = 10
	end if

	if Time.Elapsed > 5000 and dirx = 1 then
	    dirx := 2
	    diry := 2
	end if

    end loop
    cls
end if

if response = 1 then
    loop
	drawpaddle
	drawsecondpaddle
	drawball
	c := whatdotcolor (x + 10, y)
	if c = colour2 then
	    dirx := -1
	end if
	u := whatdotcolor (x - 10, y)
	if u = colour1 then
	    dirx := 1
	end if
	delay (5)
	eraseball
	erasepaddle
	erasesecondpaddle
	
	pyy := y - 50
	
	if py > 520 or py < 1 then
	    dirpy := 0
	    k := "z"
	end if

	if pyy > 520 or pyy < 1 then
	    dirpyy := 0
	    k := "z"
	end if

	if x > 599 or x < 1 then
	    dirx := dirx * -1
	end if

	if y > 599 or y < 1 then
	    diry := diry * -1
	end if

	x := x + dirx
	y := y + diry
	locate (1, 1)
	put score ..
	locate (1, 75)
	put score1 ..

	if x > 599 then
	    score := score + 1
	    exit when score = 10
	end if

	if x < 1 then
	    score1 := score1 + 1
	    exit when score1 = 10
	end if

	if Time.Elapsed > 5000 and dirx = 1 then
	    dirx := 2
	    diry := 2
	end if

    end loop
    cls
end if

put score : 4
put score1 : 4
cls
if Time.Elapsed > 10000 then
    put "The total Game length was ", Time.Elapsed / 1000 : 2, " seconds.  Well done!"
end if
getch (k)
erasepaddle
cls

