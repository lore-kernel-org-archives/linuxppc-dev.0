Message-ID: <3A7863F9.906D65F9@convergence.de>
Date: Wed, 31 Jan 2001 20:14:01 +0100
From: Andreas Hundt <andi@convergence.de>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Michel Ddnzer <michdaen@iiic.ethz.ch>,
        Benjamin
	Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Re: r128 DRI driver now fully functional on PPC
References: <Pine.LNX.4.05.10101311942170.9168-100000@callisto.of.borg>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The disadvantage is that if you change the palette, the text colors don't
> change until you redraw the screen (or switch VC back-and-forth). That's why I
> decided to use the hardware palette in directcolor modes.

I dont think it is good to use a palette in >8bpp modes. At least it
breaks
my fbdev software.

--
Andreas Hundt                              andi@convergence.de
Convergence Integrated Media GmbH          http://www.convergence.de
Rosenthaler Str. 51                        fon: +49(0)30-72 62 06 50
D-10178 Berlin                             fax: +49(0)30-72 62 06 55

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
