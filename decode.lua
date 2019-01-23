local function decode(str)
	local one = string.gmatch(str, "[\\](%d%d%d)")
	for b1 in one do
		if tonumber(b1) >= 240 then
			local four = string.gmatch(str, "[\\]"..b1.."[\\](%d%d%d)[\\](%d%d%d)[\\](%d%d%d)")
			for b2, b3, b4 in four do
				str = str:gsub("\\"..b1.."\\"..b2.."\\"..b3.."\\"..b4, string.char(b1, b2, b3, b4))
			end
		elseif tonumber(b1) >= 224 then
			local three = string.gmatch(str, "[\\]"..b1.."[\\](%d%d%d)[\\](%d%d%d)")
			for b2, b3 in three do
				str = str:gsub("\\"..b1.."\\"..b2.."\\"..b3, string.char(b1, b2, b3))
			end
		elseif tonumber(b1) >= 192 then
			local three = string.gmatch(str, "[\\]"..b1.."[\\](%d%d%d)")
			for b2 in three do
				str = str:gsub("\\"..b1.."\\"..b2, string.char(b1, b2))
			end
		end
	end
	for b1 in one do
		str = str:gsub("\\"..b1, string.char(b1))
	end
	return str
end
