To: Brendan.Simon@ctam.com.au
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
        glibc-linux <glibc-linux@ricardo.ecn.wfu.edu>
Subject: Re: MPC860 patches for glibc
References: <20000105233607.0D48DED@elph.research.canon.com.au> <otg0wb8hk8.fsf@thinktwice.zoftcorp.dk> <38754508.976B932F@ctam.com.au>
From: Jesper Skov <jskov@cygnus.co.uk>
Date: 08 Jan 2000 09:46:38 +0100
In-Reply-To: Brendan J Simon's message of "Fri, 07 Jan 2000 12:44:41 +1100"
Message-ID: <otpuvd6jdd.fsf@thinktwice.zoftcorp.dk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Brendan" == Brendan J Simon <Brendan.Simon@ctam.com.au> writes:

Brendan> Would the changes suggested below, to the cache line size
Brendan> (mpc8xx = 16 bytes, others = 32 bytes) make any difference if
Brendan> my Instruction Cache and Data Cache was disabled.  My current
Brendan> linux kernel has them all disabled for now.

I can't imagine so. But you may want someone with more experience to
answer your question :)

Jesper

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
