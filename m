From: hollis@andrew.cmu.edu
Message-ID: <3816973A.375F987D@andrew.cmu.edu>
Date: Wed, 27 Oct 1999 02:10:02 -0400
MIME-Version: 1.0
To: Neil Russell <caret@c-side.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: RevD iMac USB errors (was Problems compiling ppc kernels)
References: <19991027030045.28758.qmail@kunk.jriver.com> <381674D5.15A925B5@andrew.cmu.edu> <19991026225703.G11654@lx.c-side.com>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Neil Russell wrote:
> 
> On Tue, Oct 26, 1999 at 11:43:17PM -0400, hollis@andrew.cmu.edu wrote:
> > > Does anyone else have any insight into this?  Can anyone point me to
> > > a kernel binary that works on the iMac?  How about the config file for
> > > the said kernel?
> > >
> > > I have a rev.D iMac, purchased about a month ago (just before the new
> > > iMac came out).
> >
> > The kernels on rshaw's pages (http://www.linuxppc.org/blueg3) should
> > work fine. The trick is just to comment out the USB version-checking
> > code. I think he has the patch there as well.
> 
> I tried several of those kernels and they would not even boot.  I also
> built a kernel with the version checking commented out and those kernels
> would not even find the keyboard.

Those kernels should definately boot... are you downloading them from
the Mac OS side? Linux apparently has some issues copying to HFS that
can render kernels unbootable (this is from personal experience).

If those still don't work, try the kernel at
ftp://ftp.linuxppc.org/kernels/BlueG3/v2.2.6/vmlinux-2.2.6-rev1.gz

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
