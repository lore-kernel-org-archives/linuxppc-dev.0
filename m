Message-ID: <38A1F7A6.F7DD8ED4@zeta.org.au>
Date: Thu, 10 Feb 2000 10:26:30 +1100
From: Peter Allworth <linsol@zeta.org.au>
MIME-Version: 1.0
To: Jesper Skov <jskov@redhat.com>
CC: duncanp@research.canon.com.au, linuxppc-embedded@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Low memory problems in 8xx Linux
References: <20000201235813.4F5611B51A@elph.research.canon.com.au>
		<38977960.40E014A1@zeta.org.au>
		<ot1z6of1ws.fsf@thinktwice.zoftcorp.dk>
		<38A0AE0D.2EB99353@zeta.org.au> <14497.10437.498606.647038@thinktwice.zoftcorp.dk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jesper Skov wrote:

<snip>

> I read the patch and think I understand what's going on, but I don't
> see where the GUARDED bits comes in. Maybe I'm missing some subtlety
> from other patches (cllf?) and should not use the code at all. I'd
> better back it out.
>
> Jesper
>

Apologies for being vague. I have a head-cold and my brain seems to be
on vacation. :(

The guarded flag doesn't appear in the patch but in

cllf-2.2.13/arch/ppc/kernel/head.S
(from Dan's distribution for the Classic Lite Low Fat board)

near where the head.S-patch is applied.

Somewhere in the DataStoreTLBMiss routine, I think, you'll see the comment:

/* Insert the Guarded flag into the TWC from the Linux PTE.
<snip>
*/

This is one of the areas where cllf-2.2.13 differs from mpc8xx-2.2.13.

HTH,

PeterA.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
