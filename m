Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <39ABC306.BDA989EA@lucent.com>
Date: Tue, 29 Aug 2000 09:04:54 -0500
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
To: Alex Shnitman <alexsh@hectic.net>
Subject: Re: Linux on Motorola Sandpoint/PPMC7400
References: <20000828225504.B23679@hectic.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alex Shnitman wrote:
> I've seen that Hard Hat Linux supports the Sandpoint board with
> MPC8240 and MPC755. We have a 7400 processor there though. Does anyone
> have any experience with this configuration? Can Linux run on it?

While I have no experience with this board, I have run Linux on our
own boards, with MPC750, MPC755, and MPC7400. Note these three can
all be obtained in APPROXIMATELY pin-compatible packages, and their
architecthres are compatible (the 7400 adds AltiVec; I'm ignoring
differences in clock speed, cache size, etc). The MPC8240 is I believe
a completely different beast (I've never used one).

I used Linux Kernel 2.2.15 from YellowDog, heavily customized to run
on our boards. I made no MPC7400-specific changes, however. Note I
made no effort at all to optimize it for the 7400 (other than adding
the proper l2cr parameter -- yes, your software has to be aware of
the hardware platform's details (:-().

	I have only 1 board with 7400s, and we are modifying it to
	try and evaluate SMP architecture....


Tom Roberts	tjroberts@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
