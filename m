Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18722.2107.970887.768477@cargo.ozlabs.ibm.com>
Date: Tue, 18 Nov 2008 11:11:39 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Large stack usage in fs code (especially for PPC64)
In-Reply-To: <alpine.LFD.2.00.0811171522030.18283@nehalem.linux-foundation.org>
References: <alpine.DEB.1.10.0811171508300.8722@gandalf.stny.rr.com>
	<alpine.LFD.2.00.0811171300410.18283@nehalem.linux-foundation.org>
	<1226963596.7178.254.camel@pasglop>
	<alpine.LFD.2.00.0811171522030.18283@nehalem.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus Torvalds writes:

> > > It's made worse by the fact that they 
> > > also have horribly bad TLB fills on their broken CPU's, and years and 
> > > years of telling people that the MMU on ppc's are sh*t has only been 
> > > reacted to with "talk to the hand, we know better".
> > 
> > Who are you talking about here precisely ? I don't think either Paul or
> > I every said something nearly around those lines ... Oh well.
> 
> Every single time I've complained about it, somebody from IBM has said ".. 
> but but AIX".
> 
> This time it was Paul. Sometimes it has been software people who agree, 

Maybe I wasn't clear.  I was reporting the reaction I get from the
hardware designers, who often like to push off the hard problems to
software to fix.

Keep flaming, by the way.  It provides me with some amount of
assistance in my quest to get the hardware designers to do better. ;)

Also, you didn't respond to my comments about the purely software
benefits of a larger page size.

Paul.
