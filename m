From: dank@kegel.com
Message-ID: <3D4028DD.31E575B3@kegel.com>
Date: Thu, 25 Jul 2002 09:35:41 -0700
Reply-To: dank@kegel.com
MIME-Version: 1.0
To: Charles Lockhart <lockhart@jeans.ifa.hawaii.edu>
Cc: orbit-list@gnome.org,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: embedded devices
References: <Pine.SOL.3.96.1020724232006.5583A-100000@jeans>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Charles Lockhart wrote:
>
> Has anyone had much luck porting orbit to embedded linux devices?  I'm
> looking at trying to port it to an ipEngine (product of Brightstar
> Engineering, www.brightstareng.com), running an embedded version of Linux
> on a ppc (mpc823).  What problems have people had?  What kind of
> performance did you get?  What kind of footprint did you end up with?
> A summary of what it might entail?

Yes, I've done it; we ported it to the ppc405, sh4, and ppc750.
Footprint was as small as any commercial corba server.
There were some minor annoying bits to the port,
mostly having to do with cross-compiling.
Oh, and gcc-3.0.2 wasn't up to the task of running orbitcpp,
at least on sh4; I think you need gcc-3.0.4 if you want that to work.

This is a work in progress, so be kind.  It's at
http://www.kegel.com/xgcc3/orbit.html

- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
