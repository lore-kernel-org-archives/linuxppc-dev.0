Message-ID: <3BC5DC86.551DAF48@mvista.com>
Date: Thu, 11 Oct 2001 13:53:10 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: timebase_interrupts on MPC8xx ???
References: <3BC55726.AAC2D093@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:

> I pulled linuxppc_2_4_devel yesterday, built and ran it on my MPC8xx
> board.

I pulled it today and it won't boot on my 860....I've been trying
to fix it.  There is no reason for the timebase interrupts unless
somehow an external interrupt was routed there.  All of the interrupts
are disabled in the clock control registers.....have been forever :-).

I will post another message when I get it booting again.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
