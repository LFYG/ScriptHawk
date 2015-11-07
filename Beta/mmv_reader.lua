local mmv_filename = forms.openfile(nil, nil, "Dega Movie Files (*.mmv)|*.mmv|All Files (*.*)|*.*");

console.clear()
if mmv_filename == "" then
	console.log("No movie selected. Exiting.");
	return;
end

console.log("Opening movie for playback: "..mmv_filename);

-- Open the file and read past the header data
local input_file = assert(io.open(mmv_filename, "rb"))
local header = input_file:read(0xF3);

-- Skip frames that have already happened
local currentFrame = emu.framecount();
if currentFrame > 0 then
	input_file:read((currentFrame - 1) * 2);
end

local function parseControllerByte(byte)
	byte = string.byte(byte, 1);
	return {
		["Up"] = (bit.band(byte, 0x01) ~= 0),
		["Down"] = (bit.band(byte, 0x02) ~= 0),
		["Left"] = (bit.band(byte, 0x04) ~= 0),
		["Right"] = (bit.band(byte, 0x08) ~= 0),
		["B1"] = (bit.band(byte, 0x10) ~= 0),
		["B2"] = (bit.band(byte, 0x20) ~= 0),
		["Pause"] = (bit.band(byte, 0x40) ~= 0),
		["Reset"] = false,
	};
end

local function getNextFrame()
	local controller1 = input_file:read(1);
	local controller2 = input_file:read(1);

	if not controller1 or not controller2 then
		return false;
	end

	joypad.set(parseControllerByte(controller1), 2);
	joypad.set(parseControllerByte(controller2), 1);

	return true;
end

while getNextFrame() do
	emu.frameadvance();
end

console.log("Done.");
client.pause();