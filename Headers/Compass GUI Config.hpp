#include "gridMacros.hpp"
#include "Compass IDCs.hpp"
import ctrlMapEmpty;
import ctrlStaticPicture;
import ctrlStaticPictureKeepAspect;
import ctrlControlsGroupNoScrollbars;

class KISKA_compass_uiLayer {
	idd = COMPASS_IDD;

	duration = 10e6;
	fadeIn = 0;
	fadeOut = 0;
	onLoad = "_this spawn KISKA_fnc_compass_mainLoop";

	class controls {

		class compassGroup : ctrlControlsGroupNoScrollbars {
			idc = COMPASS_GRP;

			x = safeZoneX + ( safeZoneW / 2 ) - (( 768 / 2 ) * pixelW );
			y = safeZoneY + VERTICAL_GUTTER;
			w = 768 * pixelW;
			h = 64 * pixelH;


			class controls {
				class compassBackground : ctrlStaticPicture {
					idc = COMPASS_BACK;

					x = 0;
					y = 0;
					w = 768 * pixelW;
					h = 64 * pixelH;

				};

				class compassPicture : ctrlStaticPictureKeepAspect {
					idc = COMPASS_IMG;

					x = -( 1536 * pixelW );
					y = 0;
					w = 4096 * pixelW;
					h = 64 * pixelH;

				};

				class center : ctrlStaticPictureKeepAspect {
					idc = COMPASS_CENTER;

					x = pixelW * (( 768 / 2 ) - 8 );
					y = 0;
					w = 16 * pixelW;
					h = 64 * pixelH;

				};
			};
		};

	};
};
