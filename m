Message-ID: <3ACB537B.99B851B9@netfall.com>
Date: Wed, 04 Apr 2001 10:01:47 -0700
From: Andrew Sharp <andy@netfall.com>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: Tuomas Kuosmanen <tigert@ximian.com>,
	"E. Jason Stewart" <jason@openinformatics.com>,
	debian-powerpc@lists.debian.org, stewart.sadler@roke.co.uk,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: External Monitor under Pismo
References: <20010404092143.EFE4C2F01B@apollo.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


One has to question whether anyone would be interested in adding
this to a frame buffer driver, assuming that it isn't already
there.  Perhaps you would be able to get a lot more direct info from
another list, like one dedicated more to laptops or X.

I've actually seen an XF86Config for driving the external monitor at
different resolution(s) from the LCD, but I can't find that info at
the moment.  I don't know if it works with the frame buffer
server/driver, but I know that it works with the mach64 server for
3.3.6.  If I could find it, it would be worth trying....

a

Iain Sandoe wrote:
>
> >> Since I'm mirroring the LCD I only get 1024x768, and the pismo can
> >> drive a 1600x1200@16 bit depth. So what needs to happen to aty128fb.c
> >> to support the external monitor, and what can I do to make it happen??
> >>
> >
> > That is beyond *me* but maybe someone else knows. I am just the artist
> > dude 'round the corner who likes to hack with perl and stuff.. :-)
> >
> > I think there is no support for the external monitor in that sense in
> > the driver. In macos it can do real dualhead, so that would be possible
> > at least in theory, and it would be pretty nice. But currently I think
> > the mirrored display is all we have for Pismo. Which works nice for
> > projectors though.
>
> My understanding is that it still needs adding - as a first step you need
> someone who has signed the NDA to get the specs for the ATI chips... and
> understands how to write X servers... ;-)
>
> you could try asking Ani Joshi?
> ciao,
> Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
