Message-ID: <3ABA33FA.4FD3B2B0@mvista.com>
Date: Thu, 22 Mar 2001 12:18:50 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Michael E Crowe <mike@timesys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EST SBC8260
References: <3ABA21C9.4090003@timesys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Michael E Crowe wrote:

> .... In order to put a linux kernel
> onto this board, do I have to also purchase a JTAG from WindRiver like
> the VisionProbe or is the monitor that resides on the board enough to
> get PPCBoot working on it?

The early boards I used didn't have much of a monitor, so I always
used JTAG.

The main problem is the Wind tools assume the monitor is in the on-board
flash, and the SIMM is a flash disk.  If you power up the board, the
monitor will re-write the SIMM into something it understands, so you
can't put code out there and expect it to survive (at least with the
recent versions I have seen).  If you can convince the on-board monitor
the flash the local part, well, you get one chance at PPCBoot :-).

Buy an Abatron BDI2000.  You can use it for lots of things, including
programming/debugging PPCBoot and the Linux kernel once you get to
that point.  It's worth every penny if you place any value on your
time.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
