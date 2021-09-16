#include "gridMacros.hpp"
#include "Compass IDCs.hpp"
#include "Compass Image Resolutions.hpp"

import ctrlStaticPicture;
import ctrlStaticPictureKeepAspect;
import ctrlControlsGroupNoScrollbars;

#define COMPASS_USEABLE_RES_BY_2 840


class KISKA_compass_uiLayer {
	idd = COMPASS_IDD;

	duration = 10e6;
	fadeIn = 0;
	fadeOut = 0;
	onLoad = "_this spawn KISKA_fnc_compass_mainLoop";

	class controls {

		class compassGroup : ctrlControlsGroupNoScrollbars {
			idc = COMPASS_GRP;

			//x = safeZoneX + ( safeZoneW / 2 ) - (( COMPASS_USEABLE_RES_BY_2 / 2 ) * pixelW );
			y = safeZoneY + GRID_Y(1,8);
			//w = COMPASS_USEABLE_RES_BY_2 * pixelW;
			w = 0;
			h = COMPASS_IMAGE_RES_H * pixelH;


			class controls {
				class compassBackground : ctrlStaticPicture {
					idc = COMPASS_BACK;

					x = 0;
					y = 0;
					w = 0; 
					//w = COMPASS_USEABLE_RES_BY_2 * pixelW;
					h = COMPASS_IMAGE_RES_H * pixelH;
				};

				class compassPicture : ctrlStaticPictureKeepAspect {
					idc = COMPASS_IMG;

					x = -( MAX_COMPASS_WIDTH * pixelW );
					y = 0;
					w = COMPASS_IMAGE_RES_W * pixelW;
					h = COMPASS_IMAGE_RES_H * pixelH;
				};

				class center : ctrlStaticPictureKeepAspect {
					idc = COMPASS_CENTER;

					//x = pixelW * COMPASS_USEABLE_RES_BY_2;
					y = 0;
					w = COMPASS_CENTER_MARKER_RES_W * pixelW;
					h = COMPASS_IMAGE_RES_H * pixelH;
				};
			};
		};

	};
};
