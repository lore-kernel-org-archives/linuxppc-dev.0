Message-ID: <C78540EA349B2D4BB83D1B0AD748E26F1BE49C@amer20.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Magnus Damm'" <damm@opensource.se>,
	Guenther SOMMER <gue@rettung.at>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: linuxppc on dsp-board
Date: Fri, 14 Mar 2003 17:18:41 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


For more information on how to do that:

http://lists.linuxppc.org/linuxppc-embedded/200302/msg00138.html

Also I can send you a small tar file with source, upon request.


-----Original Message-----
From: Magnus Damm [mailto:damm@opensource.se]
Sent: Friday, March 14, 2003 6:11 PM
To: Guenther SOMMER
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc on dsp-board



I've actually run Linux on a hardware that might be something like
yours, but it was 3 years ago now. A 2.2-kernel.
The board we used had a 860 and a Texas DSP + some kind of FPGA,
great for telecommunications...
I wrote a small piece of boot software that could be compiled to
be placed in the internal DPRAM by a BDM or be burned into flash.
The boot software then started a zImage from ram or from flash.

I would suggest you to burn a zImage.embedded into the flash.

/ magnus

On Sat, 15 Mar 2003 00:12:59 +0100
Guenther SOMMER <gue@rettung.at> wrote:

>
> > i'd like to start linux on a dsp-board (where no linux has gone before
:)))
> >
> > it's a dsp-board with some dsp on board an a motorola 860 processor. the
> > board itself has 32mb sdram and 8 mb flash. the board has a bootloader
> > integrated, which configures the mpcs and start a simple
"boot-aplication".
>
> i didn't write it straightforward. i mean it should run on the
> control-processor (the mpc860), not on the dsps itself. but i think it
> would be cool, if linux lets the "dsp-dolls" dance :)
>
> grettings, guenther sommer.
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
