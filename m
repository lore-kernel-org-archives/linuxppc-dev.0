Date: Sat, 14 Aug 2004 09:40:56 -0500
From: Chris Zimman <chris@wmpp.com>
To: "Cordes, Aaron M" <aaron.m.cordes@lmco.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.27-pre6-bk hangs on MPC8540 board
Message-ID: <20040814144056.GA9300@dingdong.cryptoapps.com>
Reply-To: Chris Zimman <chris@wmpp.com>
References: <EE7CAF713952AC4A970DD7CD8B4C12A042DCAD@emss09m06.us.lmco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EE7CAF713952AC4A970DD7CD8B4C12A042DCAD@emss09m06.us.lmco.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Aug 12, 2004 at 05:07:30PM -0500, Cordes, Aaron M wrote:

> I completely disabled L1 and L2 cache in the processor and I am not
> seeing the memory corruption anymore.  So, good news is board is now
> booting, bad news is it's dog slow and we have a memory design to debug.
> Thanks to everyone for your prompt and helpful advice.

Before you spend too much time debugging the memory design, did you follow
Wolfgang's advice and take another look at your memory controller setup?

If it's working with cache disabled, and then failing in burst mode, 9 out of
10 times, it's because the SDRAM controller setup is wrong.  It only has to
be very subtly wrong to fail like this.

If you're using DIMMs versus having memory right on the board, are you
reading from the SPD for the config parameters?

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
