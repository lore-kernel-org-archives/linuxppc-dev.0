Message-ID: <3957AB3D.7A0244D9@netx4.com>
Date: Mon, 26 Jun 2000 15:13:01 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Mark S. Mathews" <mark@absoval.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PLPRCR & Checkstop reset
References: <Pine.LNX.3.96.1000625172850.17884A-100000@tristar.cc.absoval.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark S. Mathews wrote:

> We're using the mvista 2.2.13-3 kernel sources and I'd like to add a
> software reboot capability.


How do you actually want to reboot?  At one time, I had modified
the kernel "gorom()" function to simply jump into the boot rom as
if a reset occurred.  I should make this work again for many reasons.

If you really want the hard reset, which in some cases on some
designs will reset some external hardware sometimes, then the
checkstop reset will do the trick.  This is often confused with
performing a hard reset function, which really isn't the same thing.

I will dig up the code for both cases.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
