# Maik Justus < fg # mjustus : de >, partly based on bo105.nas by Melchior FRANZ, < mfranz # aon : at >

if (!contains(globals, "cprint")) {
	globals.cprint = func {};
}

var optarg = aircraft.optarg;
var makeNode = aircraft.makeNode;

var sin = func(a) { math.sin(a * math.pi / 180.0) }
var cos = func(a) { math.cos(a * math.pi / 180.0) }
var pow = func(v, w) { math.exp(math.ln(v) * w) }
var npow = func(v, w) { math.exp(math.ln(abs(v)) * w) * (v < 0 ? -1 : 1) }
var clamp = func(v, min = 0, max = 1) { v < min ? min : v > max ? max : v }
var normatan = func(x) { math.atan2(x, 1) * 2 / math.pi }

var e_gear = props.globals.getNode("sim/model/pogo/erection-gear", 1);

setlistener("/sim/signals/fdm-initialized", func {

	e_gear.setDoubleValue(1);
	settimer(func { e_gear.setDoubleValue(0) }, 15);

	setlistener("/sim/signals/reinit", func {
		cmdarg().getBoolValue() and return;
		cprint("32;1", "reinit");
		e_gear.setDoubleValue(1);
		settimer(func { e_gear.setDoubleValue(0) }, 7);
	});

});


