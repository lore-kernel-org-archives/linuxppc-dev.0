Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Till Adam <till@adam-lilienthal.de>
Subject: Re: [Linux-fbdev-devel] atyfb and the Mach64 LT PRO
Date: Sun, 18 Nov 2001 10:25:01 -0500
Cc: Linux Frame Buffer Device Development <Linux-fbdev-devel@lists.sourceforge.net>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
References: <Pine.GSO.4.21.0111181540180.2305-100000@mullein.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0111181540180.2305-100000@mullein.sonytel.be>
MIME-Version: 1.0
Message-Id: <20011118152214.LLAO13234.tomts8-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

BTW: if you are adventerous and if the Mach64 stretch registers are
anything like those iin Rage128 or Radeon, you can check out the latest
patches to either to see how this is done for those ATI cards and try to
implement it yourself if you want to.

A recent post to this mailing list (see the archive for a post whose
subject is "Scaling registers on r128" from Adrian Cox) supplied a patch
to the Rage128 that did exactly this.  You may be able to modify it easily.

Just a thought.

Kevin

On November 18, 2001 09:41, Geert Uytterhoeven wrote:
> On Sun, 18 Nov 2001, Till Adam wrote:
> > # Thus spake Geert Uytterhoeven (geert@linux-m68k.org):
> > > On Sat, 17 Nov 2001, Till Adam wrote:
> > > > So does the atyfb driver need to be extended to set the stretching
> > > > registers to a sane state to work properly with this card? If so,
> > > > is
> > >
> > > Yes.
> > >
> > > > there someone on this list for whom this would be a three minute
> > > > job and who'd be willing to hack this in? I'm willing to help and
> > > > test, but I'd appreciate the guidance of someone with more
> > > > experience in this.
> > >
> > > Some PPC people already started working on this.
> >
> > Any details on who to hook up with or where to find these folks? A
> > mailing list perhaps?
>
> linuxppc-dev@lists.linuxppc.org (CC'ed in this message)
>
> Gr{oetje,eeting}s,
>
> 						Geert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
