Subject: Re: Can software discover MPC8xx variant?
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3E399074.3040203@embeddededge.com>
References: <1043848594.10504.41.camel@zambia>
	<3E399074.3040203@embeddededge.com>
Content-Type: text/plain
Date: 03 Feb 2003 09:58:08 +0000
Message-Id: <1044266288.10504.152.camel@zambia>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you everyone for your suggestions.  It looks like I can't
determine the 8xx variant from software in a reliable way.  The idea
about using pull up/pull down resistors is a good one - but the boards
have already been manufactured, so I am not in the position to be able
to hard-wire the information in this way.

The reason I want to know the 8xx variant, however, is to optimise s/w
for the performance of the chip.  So, I guess I can get away with just
knowing the clock speeds, and the cache sizes.

I know how to determine the clock speeds (they're in /proc/cpuinfo), but
can anybody tell me how to determine the cache sizes (in a
non-destructive manner such as is used by ppcboot).

Thanks,

Alex


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
