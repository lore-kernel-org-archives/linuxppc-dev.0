Date: Mon, 2 Oct 2000 23:33:27 +0200
From: Olaf Hering <olh@suse.de>
To: Michel Dänzer <daenzerm@student.ethz.ch>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 + atidriverwith rage II/rage pro)
Message-ID: <20001002233327.B22983@suse.de>
References: <20001001224427.A18368@suse.de> <Pine.LNX.4.10.10010021658320.1581-100000@cassiopeia.home> <20001002224703.A15425@suse.de> <39D8F684.B949BA1F@student.ethz.ch> <20001002230454.C15425@suse.de> <39D8F9F1.48D9A627@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <39D8F9F1.48D9A627@student.ethz.ch>; from daenzerm@student.ethz.ch on Mon, Oct 02, 2000 at 11:11:13PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 02, Michel Dänzer wrote:

> Olaf Hering wrote:
> >
> > On Mon, Oct 02, Michel Dänzer wrote:
> >
> > > > plum:~ # fbset -depth 24
> > > > ioctl FBIOPUT_VSCREENINFO: Invalid argument
> > >
> > > What about -depth 32? Maybe X uses depth 24, 32 bpp.
> >
> > Same error.
> >
> > X can use 8,15,24.  But 32 doesnt work:
> > (**) ATI(0): Depth 32, (--) framebuffer bpp 32
> > (EE) ATI(0): Weight given (000) is inconsistent with the depth (32)
>
> I was talking about fbset... there is no depth 32 yet in X until the alpha
> channel is supported :)

Ok, first the console, then the alpha channel ;)

I got that in syslog when I try to switch the color depth:

Oct  2 23:02:45 plum kernel: not enough video RAM



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
