// *************************************************
r[\scale] = 0.9;
r[\dotSizeMax] = 22; r[\dotSizeMin] =12 ;
// *************************************************
//  a function to relate bpm to radius, 25 is the constant frame rate
r[\bpm2pi] = {arg bpm; ((2pi/25)/60) * bpm };
// *************************************************
// rotating line
r[\rotateLineFunc] = {	arg phase = 0, wide, rgb = [255,255,255];
	Pen.use{
		Pen.line((wide/2)@(wide/2),(wide/2)@(wide * ((1-r[\scale])/2)));
		Pen.rotate(phase, (wide/2), (wide/2) );
		Pen.color = Color.new255(rgb[0],rgb[1],rgb[2]);
		Pen.width = 4;
		Pen.fillStroke;}};
// *************************************************
// define number of players (divides the cicrle)
r[\numOfPlayersFunc] = { arg num, wide;
	num.do({ arg i;
		Pen.use{
			Pen.moveTo((wide/2)@(0));
			Pen.line((wide/2)@(wide/2), (wide/2)@(wide * ((1-r[\scale])/2)));
			Pen.rotate((2pi/num) * i, (wide/2), (wide/2) );
			Pen.width = 1;
			Pen.stroke;}})};
// *************************************************
// draws homocentric circles
r[\circles] = { arg num, wide;
	num.do({ arg i;
		Pen.use{
			Pen.addArc( (wide/2)@(wide/2), i * ((r[\scale] * wide/2)/num), 0, 2pi);
			Pen.width = 0.5;
			Pen.stroke;
};})};
// *************************************************
// rotating wedge
r[\rotateWedgeFunc] = {	arg phase = 0, wide, dur = 0, rgb = [255,0,0];
	Pen.use{
		Pen.color = Color.new255(rgb[0],rgb[1],rgb[2]);
		Pen.rotate(phase, (wide/2), (wide/2) );
		Pen.addWedge((wide/2)@(wide/2), (wide/2)*r[\scale], (3/2)*pi, -2pi * dur);
		Pen.alpha = 0.3;
		Pen.fill;
}};
// *************************************************
// depict numbers
r[\depictNumsFunc] = {arg num, wide;
	var list;
	list = List.fill(num, { arg i; i +1 });
	Pen.use{num.do({ arg i;
		Pen.color = Color.white;
		Pen.font = Font( "Helvetica-Bold", wide/28 );
		Pen.stringAtPoint( list[i].asString, (wide/2)@0  );
		Pen.rotate((pi/(num/2)) , (wide/2), (wide/2) );
})}};
// *************************************************
// dot management
r[\dotCollection] = Dictionary.new;

// get mouse clicks
r[\getMouseClicks] = {arg userview, wide, dotSize = r[\dotSizeMax];
	var listcopy, keyForRemoval;

	userview.mouseDownAction = { arg view, x, y, modifiers;
		var centerX = x+((wide/dotSize)/2);
		var centerY = y+((wide/dotSize)/2);

		// add/remove a dot on cmd+click
		if (modifiers.isCmd) {

			keyForRemoval = nil;

			if ( r[\dotCollection].size == 0, { r[\makeADot].value(wide,x,y) },
				{
					r[\dotCollection].pairsDo{arg key, value;
						if (value[1].contains(Point(centerX,centerY)),
							{ keyForRemoval = key }
					)};

					if( keyForRemoval.notNil,
						{ r[\dotCollection].removeAt(keyForRemoval) },
						{ r[\makeADot].value(wide,x,y ) }  );
				}
			);
		};

		// clear all dots
		if (modifiers.isShift && modifiers.isCmd)
		{ r[\dotCollection] = Dictionary.new; keyForRemoval = nil; };

		// change dot size
		if (modifiers.isCtrl)
		{
			var copyArray;
			copyArray = r[\dotCollection].copy;

			copyArray.pairsDo{arg key, value;

				if ( value[1].contains(Point(centerX,centerY) ),
					{
						if ( (value[1].width == (wide/r[\dotSizeMax])),
							{ r[\changeSize].value(key, wide, r[\dotSizeMin]) },
							{ r[\changeSize].value(key, wide, r[\dotSizeMax]) }
						);
				})
			};
		};
	};

	// move dots
	userview.mouseMoveAction = { arg view, x, y, modifiers;
		var centerX = x+((wide/dotSize)/2);
		var centerY = y+((wide/dotSize)/2);

		if (modifiers.isAlt) {

			var copyArray;
			copyArray = r[\dotCollection].copy;

			copyArray.pairsDo{arg key, value;
				if (value[1].contains(Point(centerX,centerY)),
					{r[\moveADot].value(key, wide, x, y, 1/((value[1].width)/wide) );
					}
			)};
		}
	};

};
// *************************************************
// make a dot
r[\makeADot] = {arg wide, xx, yy, dotSize = r[\dotSizeMax] ;
	var rect;
	var penFunc;

	rect = Rect(xx,yy,wide/dotSize,wide/dotSize);

	penFunc = {
		Pen.use{
			Color.black;
			Pen.addOval(Rect(xx-((wide/dotSize)/2),
				yy-((wide/dotSize)/2), wide/dotSize,wide/dotSize));
			Pen.alpha = 0.8;
			Pen.fill}};

	r[\dotCollection].put(\dot ++ UniqueID.next,[penFunc, rect]);
};
// *************************************************
// move a dot
r[\moveADot] = {arg key, wide, xx, yy, size;
	var dot, rect;

	dot = r[\dotCollection][key];
	rect = dot[1];
	r[\dotCollection].removeAt(key);
	r[\makeADot].value(wide, xx, yy, size );
};
// *************************************************
// change size
r[\changeSize] = {arg key, wide, size;
	var dot, rect;

	dot = r[\dotCollection][key];
	rect = dot[1];
	r[\dotCollection].removeAt(key);
	r[\makeADot].value(wide, rect.left, rect.top, size);
};
// *************************************************
// interpolate color values Func
r[\interpRGB] = {
	arg red = [0,1], green = [0,1], blue = [0,1], time=1;
	var intArrayR, intArrayG, intArrayB, size;
	size = 100;
	intArrayR = Array.interpolation(size: size, start: red[0], end: red[1]);
	intArrayG = Array.interpolation(size: size, start: green[0], end: green[1]);
	intArrayB = Array.interpolation(size: size, start: blue[0], end: blue[1]);

	{
		size.do({ arg i;
			r[\circleCol] = Color.new255(intArrayR[i], intArrayG[i], intArrayB[i]);
			(time/size).wait; });
	}.fork;
};
// r[\interpRGB].value(red: [180, 180], green:[100, 100], blue:[0, 0], time: 3);
// *************************************************