Message-ID: <381D20F9.C4EF2945@jlc.net>
Date: Mon, 01 Nov 1999 00:11:21 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: RevD iMac USB errors (was Problems compiling ppc kernels)
References: <19991027030045.28758.qmail@kunk.jriver.com> <381674D5.15A925B5@andrew.cmu.edu> <19991026225703.G11654@lx.c-side.com> <3816973A.375F987D@andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just to keep everyone up to date.......

Someone wrote:

> > > The kernels on rshaw's pages (http://www.linuxppc.org/blueg3) should
> > > work fine. The trick is just to comment out the USB version-checking
> > > code. I think he has the patch there as well.

I tried again today, and the vmlinux-2.2.10-rev1.gz booted on my RevD iMac.
The 2.2.6 wouldn't, and the anything prior to the recent Oct. 30 build
wouldn't either.  I used 2.2.10 to install Linux/PPC, you just don't have
any backspace/delete/kill keys, so be careful typing :-).

Thank you very much!  Now, if I could just get the video driver to
leave the monitor enabled, it would be great.  FYI, video=fbonly (check
the No Video box) works, but any other video option turns off the monitor.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
