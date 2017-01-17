setscreen ("graphics: 800,600")
process whereisit

 var x, y, button : int
	loop
	    Mouse.Where (x, y, button)
	    Text.Locate (1, 1)
	    if button = 0 then
		put x : 4, "  ", y : 4..
	    else
		put x : 4, "  ", y : 4..
	    end if
	end loop
end whereisit
fork whereisit


