Message-ID: <19991026225703.G11654@lx.c-side.com>
Date: Tue, 26 Oct 1999 22:57:03 -0700
From: Neil Russell <caret@c-side.com>
To: hollis@andrew.cmu.edu
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RevD iMac USB errors (was Problems compiling ppc kernels)
References: <19991027030045.28758.qmail@kunk.jriver.com> <381674D5.15A925B5@andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <381674D5.15A925B5@andrew.cmu.edu>; from hollis@andrew.cmu.edu on Tue, Oct 26, 1999 at 11:43:17PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 26, 1999 at 11:43:17PM -0400, hollis@andrew.cmu.edu wrote:
> > I ended up hacking a small change into the ethernet code to snarf
> > specially formatted UDP packets and shove them into the console queue.
> > This works fine, but is rather ugly.
> 
> I have no idea what you're saying... you hacked your iMac to make it
> think custom-made packets coming at it are from the keyboard?

That's it exactly.  I used this hacked kernel to allow me to type on the
console to get linux installed.  I never intended to use the console for
real work.  I just run X11 to a remote X server for that.

> > Does anyone else have any insight into this?  Can anyone point me to
> > a kernel binary that works on the iMac?  How about the config file for
> > the said kernel?
> > 
> > I have a rev.D iMac, purchased about a month ago (just before the new
> > iMac came out).
> 
> The kernels on rshaw's pages (http://www.linuxppc.org/blueg3) should
> work fine. The trick is just to comment out the USB version-checking
> code. I think he has the patch there as well.

I tried several of those kernels and they would not even boot.  I also
built a kernel with the version checking commented out and those kernels
would not even find the keyboard.


-- 
Neil Russell <caret@c-side.com>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
