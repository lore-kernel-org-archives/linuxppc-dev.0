Date: Mon, 4 Aug 2003 08:26:19 -0700
From: Larry McVoy <lm@bitmover.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Miles Lane <miles.lane@comcast.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6.0-test2-bk2 (linus' tree) -- arch/ppc/platforms/pmac_cpufreq.c:219: undefined reference to `cpufreq_frequency_table_verify'
Message-ID: <20030804152619.GA30195@work.bitmover.com>
References: <200308031456.11550.miles.lane@comcast.net> <1059948097.602.1.camel@gaston> <16174.17597.565364.862198@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16174.17597.565364.862198@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Here is what I have in a tree locally to go to Linus.  I can't push it
> out because ppc.bkbits.net seems to be down.

It's back.  If anyone has any insight into how to track down kernel hangs
I'd love to hear them.  bkbits.net has been flakey in the last couple of
months and sometimes just hangs, last night's was with pings still working
but no response at the console.
--
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
