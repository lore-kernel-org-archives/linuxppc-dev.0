Message-ID: <3958E040.15B86909@netx4.com>
Date: Tue, 27 Jun 2000 13:11:28 -0400
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

Here is the first installment.  It will allow commands that use
the reboot system call (like 'reboot') to properly jump into the
system reset vector.  If you want to write some custom programs
to execute code somewhere else, you can call reboot with a
starting address parameter.  I use this to use Linux to load a
new Linux kernel.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
