Message-ID: <19991026122200.D11654@lx.c-side.com>
Date: Tue, 26 Oct 1999 12:22:00 -0700
From: Neil Russell <caret@c-side.com>
To: Mike Panetta <mpanetta@realminfo.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems compiling ppc kernels.
References: <19991026134728.A25022@alice.realminfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19991026134728.A25022@alice.realminfo.com>; from Mike Panetta on Tue, Oct 26, 1999 at 01:47:28PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 26, 1999 at 01:47:28PM -0400, Mike Panetta wrote:
> I have been having some real weird problems with compiling 
> kernels for my iMAC. ....


I had basically the same problems compiling a kernel for iMac, and
fixed them by turning off config for the offending items.  I did not
get any of those kernels to boot on the iMac.  I ended up using 2.2.6
(the one shipped on the LinuxPPC CD).  The 226 kernel works, except for
the keyboard/mouse ("version 1.16 USB, only understand 1.0 problem").
I ended up hacking a small change into the ethernet code to snarf
specially formatted UDP packets and shove them into the console queue.
This works fine, but is rather ugly.
  
Does anyone else have any insight into this?  Can anyone point me to
a kernel binary that works on the iMac?  How about the config file for
the said kernel?

I have a rev.D iMac, purchased about a month ago (just before the new
iMac came out).


Thanks,
	Neil.


-- 
Neil Russell <caret@c-side.com>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
