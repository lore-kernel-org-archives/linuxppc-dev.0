Message-ID: <3ACBD134.3ECFACAD@netfall.com>
Date: Wed, 04 Apr 2001 18:58:12 -0700
From: Andrew Sharp <andy@netfall.com>
MIME-Version: 1.0
To: debian-powerpc@lists.debian.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: External Monitor under Pismo
References: <20010404172943.E1AD92EFBC@apollo.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
>
> > One has to question whether anyone would be interested in adding
> > this to a frame buffer driver, assuming that it isn't already
> > there.
>
> because it's useful? ;-)

Interesting word.  I wonder what it means.  But all seriousness
aside, what I meant was that if I was going to do some development
on this, I would also simultaneously work on getting the aty128
direct driver to work.  In other words if it's already in the 128
driver, then I would try to get that working on Pismo, rather than
try adding CRT support to the fb driver.  I'm trying to make sense,
really I am.  Someone else mentioned that X4 and X3 vary greatly.  I
am aware of those differences.

> > I've actually seen an XF86Config for driving the external monitor at
> > different resolution(s) from the LCD, but I can't find that info at
> > the moment.  I don't know if it works with the frame buffer
> > server/driver, but I know that it works with the mach64 server for
> > 3.3.6.  If I could find it, it would be worth trying....

OK, some I'm starting to get the clue that Pismo is the G3 powerbook
w/ rage128, as opposed to Wallstreet, which is G3 PB w/mach64?  A
couple more years and I'm sure I'll have it straight.

a

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
