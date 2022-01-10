// RADAR
// Start here | evalute the entire code

(
r = Dictionary.new;
"config.scd".loadRelative; "engine.scd".loadRelative;
r[\width]= 900; // window's 'width
r[\bpm1] = 2; r[\bpm2] = 1; r[\bpm3] = 0; // bpm for the 3 clocks
r[\homocentrics] = 5; // number of categories
r[\numOfGroups] = 8; // number of participants
r[\wedge] = 0; // between 0 & 1
r[\circleCol] = Color.new255(180, 100, 0); // colour
// r[\interpRGB].value(red: [180, 0], green:[100, 160], blue:[0, 0], time: 3);
r[\engine].value;
);

// *************************************************

/*
cmd+click: add/delete a dot
alt+drag: move a dot
ctrl+click: change dot size
cmd+shift+click: clear all dots
cmd+.: close window
*/
