Return-Path: <bunk@kernel.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by ozlabs.org (Postfix) with ESMTP id 0198FDE5B3
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 03:59:21 +1000 (EST)
Date: Fri, 6 Jun 2008 20:58:39 +0300
From: Adrian Bunk <bunk@kernel.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: 4xx support in arch/ppc is going away Real Soon Now
Message-ID: <20080606175839.GD2201@cs181133002.pp.htv.fi>
References: <20080605095253.7df9dbe0@zod.rchland.ibm.com>
	<fa686aa40806050811t4ab2fbfk9eed34d0972376c4@mail.gmail.com>
	<20080606115347.GC472@cs181133002.pp.htv.fi>
	<18505.10514.353016.230035@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <18505.10514.353016.230035@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 06, 2008 at 10:09:54PM +1000, Paul Mackerras wrote:
> Adrian Bunk writes:
> 
> > BTW:
> > I remember Paul wanted to get PReP under arch/powerpc/ working -
> > should this be done before the big ppc removal?
> 
> I have a PReP port for arch/powerpc that works for one machine, at
> least. :)  The key part is the residual to device-tree converter that
> I posted some time back with a request for people to test it on their
> PReP machines, but I haven't heard back from anybody.  I'm going to
> post the patch shortly anyway.

Meelis Roos <mroos@linux.ee> has a Motorola Powerstack II Pro4000 and 
recently reported (now fixed) 2.6.26-rc build problems with the rusty 
ppc code.

You might have luck asking him for testing, thereby doubling the number 
of known-working machines.  :)

> Paul.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
