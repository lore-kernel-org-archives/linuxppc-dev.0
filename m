Message-ID: <3A785F34.A1258711@iiic.ethz.ch>
Date: Wed, 31 Jan 2001 19:53:40 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Andreas Hundt <andi@convergence.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Re: r128 DRI driver now fully functional on PPC
References: <Pine.LNX.4.05.10101311942170.9168-100000@callisto.of.borg>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
>
> On Wed, 31 Jan 2001, Michel Dänzer wrote:
> > > - no more messed up colors in modes > 8 bpp. driver no longer uses
> > >   hardware palette in modes > 8bpp, sets fbcon palette correctly
> > >   instead.
> >
> > Sounds great!
>
> The disadvantage is that if you change the palette, the text colors don't
> change until you redraw the screen (or switch VC back-and-forth). That's why
> I decided to use the hardware palette in directcolor modes.

I don't mind using the hardware palette if you (or anyone) tell me how to get
RGB565 working with that. :)


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
