Date: Sat, 15 Mar 2003 01:10:41 +0000
From: Magnus Damm <damm@opensource.se>
To: Guenther SOMMER <gue@rettung.at>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc on dsp-board
Message-Id: <20030315011041.6b6004de.damm@opensource.se>
In-Reply-To: <3E7261FB.2060904@rettung.at>
References: <3E725ACA.7080301@rettung.at>
	<3E7261FB.2060904@rettung.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
> > i'd like to start linux on a dsp-board (where no linux has gone before :)))
> >
> > it's a dsp-board with some dsp on board an a motorola 860 processor. the
> > board itself has 32mb sdram and 8 mb flash. the board has a bootloader
> > integrated, which configures the mpcs and start a simple "boot-aplication".
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
