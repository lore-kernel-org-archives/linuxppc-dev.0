Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 8BFD8DDF0A
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 14:02:17 +1100 (EST)
Date: Fri, 26 Jan 2007 19:02:16 -0800 (PST)
Message-Id: <20070126.190216.95060896.davem@davemloft.net>
To: ebiederm@xmission.com
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
From: David Miller <davem@davemloft.net>
In-Reply-To: <m18xfpuqyp.fsf@ebiederm.dsl.xmission.com>
References: <m1ejpiw9s8.fsf@ebiederm.dsl.xmission.com>
	<17850.33971.762011.194195@cargo.ozlabs.ibm.com>
	<m18xfpuqyp.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: grundler@parisc-linux.org, greg@kroah.com, kyle@parisc-linux.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, brice@myri.com,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 26 Jan 2007 19:46:22 -0700

> Paul Mackerras <paulus@samba.org> writes:
> 
> > Eric W. Biederman writes:
> >
> >> I believe the ppc model is to allocate an interrupt source on their
> >> existing interrupt controller and use that instead of the normal x86
> >> case of having the MSI interrupt go transparently to the cpu.
> >
> > Do you mean that x86 cpus themselves can actually be the target of a
> > write on the bus?  That's the first time I've heard of the CPU itself
> > being a target for a bus operation.
> 
> Yes.  The cpu front side bus is packet based on all modern x86 processors,
> and an irq message is one type of packet. 

Interesting.

This is exactly how all sparc64 chips have always worked too.  On
sparc64 the cpu can actually read in the packets and process them.
Can the x86 interrupt handler get at the full packet data?
