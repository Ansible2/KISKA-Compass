class RscTitles
{
	#include "Headers\Compass GUI Config.hpp"
};

class cfgFunctions
{
	class KISKA
	{

		class Compass
		{
			file = "Functions";

			class compass_addIcon
			{};
			class compass_configure
			{};
			class compass_mainLoop
			{};
			class compass_parseConfig
			{};
			class compass_refresh
			{};
			class compass_updateColors
			{};
			class compass_updateConstants
			{};

		};
	};
};



class KISKA_compass
{

	class compass
	{
		class standard
		{
			title = "Standard";
			image = "";
		};

		class ODST_compass
		{
			title = "ODST";
			image = "";
		};
	};

	class center
	{
		class standard_center
		{
			title = "Standard";
			image = "";
		};
	};
};


class Extended_PreInit_EventHandlers
{
    class compass_settings_preInitEvent
	{
        init = "call compileScript ['KISKA_Compass\Scripts\addCompassCbaSettings.sqf'];";
    };
};
