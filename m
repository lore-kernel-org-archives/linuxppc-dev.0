Date: Tue, 25 Feb 2003 19:34:37 -0600
From: "William A. Gatliff" <bgat@billgatliff.com>
To: Chris Zimman <chris@cryptoapps.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Unstable MPC8245 board
Message-ID: <20030225193437.A3753@saturn.billgatliff.com>
Reply-To: bgat@billgatliff.com
References: <20030225164619.B2761@saturn.billgatliff.com> <20030225230333.GA20099@mail.cryptoapps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030225230333.GA20099@mail.cryptoapps.com>; from chris@cryptoapps.com on Tue, Feb 25, 2003 at 03:03:33PM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Chris:


> I'm not familiar with uMON, but I would guess it has some memory tests
> in it.  Can you do burst reads/writes inside of uMON reliably?

Good question.  I have the source, I could add such a test.  (uMON has
a memory test, but it's a "walking ones and zeros" for verifying
hardware connectivity, not all that other stuff that's a problem with
SDRAMs).

What's a C construct that would virtually guarantee a burst read or
write?

> Without knowing anything else, from what I see here, I'm guessing that
> your problem is related to memory.  But testing outside of the kernel
> will definitely help to rule that out.

Ok.  Thanks, that's a start...


b.g.
--
Bill Gatliff
http://billgatliff.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
