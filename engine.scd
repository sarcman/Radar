(
r[\engine] = {
	arg border = true, left = 1300, top = 600, width = r[\width];

	var win, uv, run = true;
	var phase1 = 0, phase2 = 0, phase3 = 0, bpm1=10, bpm2=10, bpm3=10;

	win = Window.new("Radar", Rect(left, top, width, width), border: border).front;
	win.onClose = {run = false;};

	uv= UserView(win, win.view.bounds);
	uv.resize = 5;
	uv.background_(Color.black);

	//	uv.acceptsMouseOver = true;

	// draw dots
	r[\getMouseClicks].value(uv, win.bounds.width).value;

	r[\circleCol] = Color.new255(180, 100, 0);

	uv.drawFunc={ arg uview;
		var wide = win.bounds.width;

		// the big circle
		Pen.fillColor = r[\circleCol]; // Color.new255(180, 100, 0)
		Pen.fillOval(
			Rect(wide * ((1-r[\scale])/2),wide*((1-r[\scale])/2),
				wide * r[\scale], wide * r[\scale]));

		//the small circle in the centre
		Pen.moveTo((wide/2)@(wide/2));
		Pen.fillColor = Color.new255(0, 0, 0);
		Pen.fillOval(Rect((wide/2)-5, (wide/2)-5, 10, 10));

		// draws the homocentric circles
		r[\circles].value(num: r[\homocentrics], wide: wide);

		// define number of players
		r[\numOfPlayersFunc].value(r[\numOfGroups], wide);

		// depicts numbers
		r[\depictNumsFunc].value(r[\numOfGroups], wide);

		// rotating line 2
		r[\rotateLineFunc].value(phase: phase2 + r[\lag2], wide: wide,rgb: [255,200,50] );

		// rotating line 1
		r[\rotateLineFunc].value(phase: phase1, wide: wide,rgb: [255,255,255] );

		// rotating line 3
		r[\rotateLineFunc].value(phase: phase3, wide: wide,rgb: [0,0,255] );

		// rotating wedge 1
		r[\rotateWedgeFunc].value(phase: phase1, wide: wide, dur: r[\wedge],rgb: [0,0,1]);

		r[\dotCollection].do{arg item, i ; item[0].value};
	};

	// Refresh framerate: 25
	{ while { run }
		{ win.refresh; (1/25).wait;
			phase1 = phase1 + r[\bpm2pi].value(r[\bpm1]);
			phase2 = phase2 + r[\bpm2pi].value(r[\bpm2]);
			phase3 = phase3 + r[\bpm2pi].value(r[\bpm3]);

	}}.fork(AppClock);

	CmdPeriod.add({{win.close}.defer(0.01)}); // close the window on cmd period
}
);

r[\lag2] = 0; // between 0 & 2pi, lag of yellow-clock
