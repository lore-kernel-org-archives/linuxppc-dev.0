Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 52ECFDDE1F
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 10:59:19 +1000 (EST)
In-Reply-To: <18416.13196.812280.794832@cargo.ozlabs.ibm.com>
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<200803251914.24021.laurentp@cse-semaphore.com>
	<47EA4741.2050402@ru.mvista.com>
	<200803271013.32612.laurentp@cse-semaphore.com>
	<20080327100304.GC10397@localhost.localdomain>
	<7c44646510c3b98075de9aa57cad0bce@kernel.crashing.org>
	<18416.813.635397.559197@cargo.ozlabs.ibm.com>
	<56851566f85e117c42b078dd2d6a2028@kernel.crashing.org>
	<18416.13196.812280.794832@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b393df3f814388b5cd5ae2f3b2b7fd66@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: OF compatible MTD platform RAM driver ?
Date: Mon, 31 Mar 2008 02:59:03 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> [*] It seems to me the longtrail workaround code in prom_init.c is
>> incorrect though: it will match any node with name "memory" that
>> doesn't have a device_type?
>
> It only matches on children of the root node,

Oh okay, I misread that then.

> and it's that way
> because the /memory node in the longtrail device tree doesn't have a
> device_type.

Yeah.

> Actually we could probably remove the longtrail stuff
> now; I think mine has stopped working, and I only know of 2 others in
> existence. :)

I'll prepare a patch.


Segher
