Date: Wed, 18 Apr 2001 15:39:07 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: Tony Mantler <nicoya@apia.dhs.org>,
	martin costabel <costabel@wanadoo.fr>,
	michel d=?ISO-8859-1?B?5A==?=nzer <michdaen@iiic.ethz.ch>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
In-Reply-To: <20010418124421.7E7702EFE5@apollo.valhalla.net>
Message-ID: <Pine.HPX.4.10.10104181533390.11443-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 18 Apr 2001, Iain Sandoe wrote:

>
> >>I guess we could use <CNTL>-power as the SysRq modifier - but it starts to
> >>become a little unwieldy - because you need to hold down three keys to get
> >>the SysRq action (well, you do now as it happens)...
> >>
> >>so, perhaps, <CNTL>-<Power>-k etc.
> >>
> >>thoughts?
> >
> > On my Apple Adjustable keyboard, control and power are about as far away
> > from eachother as you can get and still be on the same keyboard. Not
> > exactly 2-of-3-key-combo material. I don't have very small hands, but even
> > on my AppleDesign, it's a bit of a stretch.
>
> yeah, on mine too - which is why I was originally attracted to just <power>
> as the modifier.
>
> > Also, what happens if someone wants to hook up a PC USB keyboard to their
> > mac? Obviously not generating an NMI is a given, but no access to SAK is
> > avoidable.
>
> Apparently, some Apple keyboards don't have a <power> key either.

Unless I missed it there is no power key on the keyboard delivered with my
2001 G4/466 (109 keys including volume/mute/media-eject, but nothing
looking like a power key.)

> Anyway the SysRq key for USB must be handled somewhere else - I'm looking at
> the mac_hid/adb/mac_keyb code which is specific to adb-based machines IIUC.
>
> >(Also can't forget non-mac PPCs)
>
> Which must handle it in their hid section... depending on whether they have
> serial or USB (or something special).

If somebocy is going to touch the input layer, I would like the raw
keyboard mode to stay raw. Right now in some configuration combinations
there is no difference between raw and medium-raw (used by X). They both
return medium-raw keycodes, I can't get to the scancodes.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
