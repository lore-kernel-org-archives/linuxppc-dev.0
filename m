Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 324B8DDFBA
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 22:22:04 +1000 (EST)
In-Reply-To: <200803311021.28919.laurentp@cse-semaphore.com>
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<18416.813.635397.559197@cargo.ozlabs.ibm.com>
	<56851566f85e117c42b078dd2d6a2028@kernel.crashing.org>
	<200803311021.28919.laurentp@cse-semaphore.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <598a037de29f1c080ef96207b7d73949@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: OF compatible MTD platform RAM driver ?
Date: Mon, 31 Mar 2008 14:21:14 +0200
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Cc: ben@simtec.co.uk, linux-mtd@lists.infradead.org,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> So, all in all, I think we should just give these "auxiliary memory"
>> devices a name of "ram" c.q. "rom", and some "reg", and that should
>> be all that is needed: the main memory probe stuff won't consider
>> these nodes, and the (platform) device probe code can do whatever it
>> wants (create mtd devices, I guess).
>
> Ok, I get your point. I'll prepare a new documentation patch; changes 
> to
> physmap_of.c will go away.

Thanks.

> If I understand you correctly, there should be no "compatible" 
> property on the
> ram and rom devices.

They aren't normally needed here, I think.

> Should the "non-volatile", "slow" and "static ram"
> properties still be expressed in the device tree ?

If those are useful.  I'll need to see a proposed binding to form
an opinion on this, it's too vague now, sorry.


Segher
