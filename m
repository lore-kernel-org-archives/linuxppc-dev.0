Date: Wed, 18 Apr 2001 18:10:02 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Cc: Iain Sandoe <iain@sandoe.co.uk>,
	Tony Mantler <nicoya@apia.dhs.org>,
	martin costabel <costabel@wanadoo.fr>,
	michel =?iso-8859-1?Q?d=E4nzer?= <michdaen@iiic.ethz.ch>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
In-Reply-To: <5.1.0.14.2.20010418164729.040ef120@mail.munich.netsurf.de>
Message-ID: <Pine.HPX.4.10.10104181724460.11443-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 18 Apr 2001, Franz Sirl wrote:

> At 15:39 18.04.2001, Gabriel Paubert wrote:
> >If somebocy is going to touch the input layer, I would like the raw
> >keyboard mode to stay raw. Right now in some configuration combinations
> >there is no difference between raw and medium-raw (used by X). They both
> >return medium-raw keycodes, I can't get to the scancodes.
>
> Which config combinations? Which keys? PMAC, CHRP or PREP? ADB, USB or PS2
> keyboard?

Can't test for one week (I'm at the telescope until next Tuesday). But
this affected basically all the keys on a PMAC G4 with standard (latest)
Apple USB keyboard.

AFAIR compiling with CONFIG_ADB off butchered everything: CONFIG_MAC_HID
was Y in .config but there was no mac_hid in /proc/sys/dev and the
keyboard was crazy.

> Additionally note that XF 4.0.99 and later only will use MEDIUMRAW if you
> give "Option CustomKeycodes".

Didn't know, so X is going to use raw ?

But now raw means cooked ?

>
> God, I'll be *really* glad when the 2.5 kernel is started and support for
> ADB keycodes, the MEDIUMRAW mode and mouse button emulation in the kernel
> will be gone forever...

Fine for most of these, but how do you get to the raw scancodes if you
want them ? I mean raw byte for byte from the hardware, anything else
cannot be called raw in my opinion.

Do we need a new mode for this (crude?) or did I miss the way to get at
the scancodes ?

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
