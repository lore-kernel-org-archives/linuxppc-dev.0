From: hollis@andrew.cmu.edu
Message-ID: <381674D5.15A925B5@andrew.cmu.edu>
Date: Tue, 26 Oct 1999 23:43:17 -0400
MIME-Version: 1.0
To: bob@kunk.jriver.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: RevD iMac USB errors (was Problems compiling ppc kernels)
References: <19991027030045.28758.qmail@kunk.jriver.com>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


bob@kunk.jriver.com wrote:
> 
> Neil Russel Wrote:
> 
> On Tue, Oct 26, 1999 at 01:47:28PM -0400, Mike Panetta wrote:
> > I have been having some real weird problems with compiling
> > kernels for my iMAC. ....
> 
> I had basically the same problems compiling a kernel for iMac, and
> fixed them by turning off config for the offending items.  I did not
> get any of those kernels to boot on the iMac.  I ended up using 2.2.6
> (the one shipped on the LinuxPPC CD).  The 226 kernel works, except for
> the keyboard/mouse ("version 1.16 USB, only understand 1.0 problem").
> I ended up hacking a small change into the ethernet code to snarf
> specially formatted UDP packets and shove them into the console queue.
> This works fine, but is rather ugly.

I have no idea what you're saying... you hacked your iMac to make it
think custom-made packets coming at it are from the keyboard?

> Does anyone else have any insight into this?  Can anyone point me to
> a kernel binary that works on the iMac?  How about the config file for
> the said kernel?
> 
> I have a rev.D iMac, purchased about a month ago (just before the new
> iMac came out).

The kernels on rshaw's pages (http://www.linuxppc.org/blueg3) should
work fine. The trick is just to comment out the USB version-checking
code. I think he has the patch there as well.

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
