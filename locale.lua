Locales = {}

function _(str, ...)  -- Translate string

	if Locales[Real.Locale] ~= nil then

		if Locales[Real.Locale][str] ~= nil then
			return string.format(Locales[Real.Locale][str], ...)
		else
			return 'Translation [' .. Real.Locale .. '][' .. str .. '] does not exist'
		end

	else
		return 'Locale [' .. Real.Locale .. '] does not exist'
	end

end

function _U(str, ...) -- Translate string first char uppercase
	return tostring(_(str, ...):gsub("^%l", string.upper))
end
