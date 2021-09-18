#include "Compass IDCs.hpp"
#include "Compass Image Resolutions.hpp"

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

			y = 0;
			w = 0;
			h = COMPASS_IMAGE_RES_H * pixelH;


			class controls {
				class compassBackground : ctrlStaticPicture {
					idc = COMPASS_BACK;

					x = 0;
					y = 0;
					w = 0;
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

					y = 0;
					w = COMPASS_CENTER_MARKER_RES_W * pixelW;
					h = COMPASS_IMAGE_RES_H * pixelH;
				};
			};
		};

	};
};
