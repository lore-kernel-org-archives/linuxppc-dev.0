Message-Id: <5.1.0.14.2.20010418164729.040ef120@mail.munich.netsurf.de>
Date: Wed, 18 Apr 2001 16:54:26 +0200
To: Gabriel Paubert <paubert@iram.es>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
Cc: Iain Sandoe <iain@sandoe.co.uk>,
	Tony Mantler <nicoya@apia.dhs.org>,
	martin costabel <costabel@wanadoo.fr>,
	michel =?iso-8859-1?Q?d=E4nzer?= <michdaen@iiic.ethz.ch>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.HPX.4.10.10104181533390.11443-100000@gra-ux1.iram.es>
References: <20010418124421.7E7702EFE5@apollo.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 15:39 18.04.2001, Gabriel Paubert wrote:
>If somebocy is going to touch the input layer, I would like the raw
>keyboard mode to stay raw. Right now in some configuration combinations
>there is no difference between raw and medium-raw (used by X). They both
>return medium-raw keycodes, I can't get to the scancodes.

Which config combinations? Which keys? PMAC, CHRP or PREP? ADB, USB or PS2
keyboard?

Additionally note that XF 4.0.99 and later only will use MEDIUMRAW if you
give "Option CustomKeycodes".

God, I'll be *really* glad when the 2.5 kernel is started and support for
ADB keycodes, the MEDIUMRAW mode and mouse button emulation in the kernel
will be gone forever...

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
