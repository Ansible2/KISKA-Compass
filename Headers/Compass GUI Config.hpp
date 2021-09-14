#include "gridMacros.hpp"
#include "Compass IDCs.hpp"
import ctrlMapEmpty;
import ctrlStaticPicture;
import ctrlStaticPictureKeepAspect;
import ctrlControlsGroupNoScrollbars;
#define COMPASS_USEABLE_RES_BY_2 840
#define COMPASS_PIXEL_HEIGHT 64

class KISKA_compass_uiLayer {
	idd = COMPASS_IDD;

	duration = 10e6;
	fadeIn = 0;
	fadeOut = 0;
	onLoad = "_this spawn KISKA_fnc_compass_mainLoop";

	class controls {

		class compassGroup : ctrlControlsGroupNoScrollbars {
			idc = COMPASS_GRP;

			x = safeZoneX + ( safeZoneW / 2 ) - (( COMPASS_USEABLE_RES_BY_2 / 2 ) * pixelW );
			y = safeZoneY + GRID_Y(1,8);
			w = COMPASS_USEABLE_RES_BY_2 * pixelW;
			h = COMPASS_PIXEL_HEIGHT * pixelH;


			class controls {
				class compassBackground : ctrlStaticPicture {
					idc = COMPASS_BACK;

					x = 0;
					y = 0;
					w = COMPASS_USEABLE_RES_BY_2 * pixelW;
					h = COMPASS_PIXEL_HEIGHT * pixelH;
				};

				class compassPicture : ctrlStaticPictureKeepAspect {
					idc = COMPASS_IMG;

					x = -( 2610 * pixelW );
					y = 0;
					w = 4096 * pixelW;
					h = COMPASS_PIXEL_HEIGHT * pixelH;
				};

				class center : ctrlStaticPictureKeepAspect {
					idc = COMPASS_CENTER;

					x = pixelW * COMPASS_USEABLE_RES_BY_2;
					y = 0;
					w = 16 * pixelW;
					h = COMPASS_PIXEL_HEIGHT * pixelH;
				};
			};
		};

	};
};
