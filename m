Message-ID: <19991021124450.A22613@maxime.u-strasbg.fr>
Date: Thu, 21 Oct 1999 12:44:50 +0200
From: Sven LUTHER <luther@maxime.u-strasbg.fr>
To: anthony tong <atong@uiuc.edu>,
        "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: SuSE Rage 128 Xserver Source and XFree 3.3.6
Reply-To: luther@dpt-info.u-strasbg.fr
References: <v03110700b433ca16486c@[209.183.133.114]> <19991020150502.A2198@mango.genunix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19991020150502.A2198@mango.genunix.net>; from anthony tong on Wed, Oct 20, 1999 at 03:05:02PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 20, 1999 at 03:05:02PM -0500, anthony tong wrote:
> 
> Kevin B. Hendricks (Wed, Oct 20, 1999 at 03:43:06PM -0400):
> > I got tired of waiting for SuSE to release the source to its accelerated
> > Xserver for Rage 128, so I sent them a nasty gram and what they replied is
> > below:
> > 
> > So Anthony?, Tom?, Geert?, Anyone?
> > 
> > Do any of you know who has access to XFree 3.3.6 source code so that we can
> > get started porting this server to PPC?
> 
> I have the source, and also Precision Insights additions to it (a bit 
> cleaner layout + hw cursor).
> 
> I've also started merging into our xf68_fbdev but I won't have any free
> time to continue this (at least for a week or so). The problem is that
> they're using the xaa interface (which never was ported to ppc), so you
> have to wrapper all their accel functions by hand.

What about 3.9.16 ? it is publicly available, and does run on powerpc, at least
i think so (3.9.Px did for me). I think it has some compile problems though, so
you will have to configure the emux86 stuff out. Not sure it is needed anyway,
and was tested only on i386 (pretty stupid to have a i386 bios emulator that
only works on i386 i think, but then i know nothing of this stuff.)

So is the Rqge 128 driver stuff already in 3.9.16 ?

Friendly,

Sven LUTHER

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
