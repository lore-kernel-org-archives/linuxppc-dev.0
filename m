Date: Mon, 6 Mar 2000 00:25:36 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        Michel Dänzer <michdaen@iiic.ethz.ch>, linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on pp
 cwith  r128
In-Reply-To: <Pine.LNX.4.05.10003052220090.11732-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.21.0003060013070.30614-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 5 Mar 2000, Geert Uytterhoeven wrote:

> On Sun, 5 Mar 2000, Kostas Gewrgiou wrote:
> >   Yeap its the same in the x86 side as well, atyfb doesn't support 565
> > either i imagine you remember the jdk problems that we had in xf68_fbdev
> > because of this.
>
> But since Mach64 CT/VT/GT do support RGB 565, adding support for it isn't that
> difficult. Patches?
>

 Unfortunately i don't have a mach64 card anymore, i'll take a look in the
xserver side though, right now it looks only in var.bits_per_pixel but this
is set to 16 even in the 555 case so we need to check green.length as well
right ?

> Gr{oetje,eeting}s,
>
> 						Geert
>

  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
