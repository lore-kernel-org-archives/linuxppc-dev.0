Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Pass PID argument to _tlbie (WAS:
	Apparent kernel bug with GDB on ppc405)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071029151546.5af0e843@weaponx.rchland.ibm.com>
References: <20071024194640.GB19691@waste.org>
	<1193363202.7018.36.camel@pasglop>
	<fa686aa40710251945l51604c5vdf0b49b03b9a1a57@mail.gmail.com>
	<1193369005.7018.46.camel@pasglop> <20071026144134.GW19691@waste.org>
	<1193448653.18243.9.camel@pasglop> <1193470322.18243.63.camel@pasglop>
	<20071029070824.72854629@weaponx.rchland.ibm.com>
	<20071029151546.5af0e843@weaponx.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 30 Oct 2007 07:35:06 +1100
Message-Id: <1193690106.9928.32.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Matt Mackall <mpm@selenic.com>,
	Kumar Gala <galak@gate.crashing.org>, linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Did a boot test on my ebony board with this patch included.  It seems
> to be happy about things so far.  If Matt gets around to trying this
> out and it works, we should probably look at getting this into 2.6.24.
> 
> Oh, and I'd need a signed-off-by for it Ben :)

Sure, I'll send you a cleaned up version (the version I posted for test
breaks 64 bits builds :-)

But I'm also waiting for Matt to test first.

Cheers,
Ben.
