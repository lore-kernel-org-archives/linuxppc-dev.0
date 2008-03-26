Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 95475DE69F
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 02:11:33 +1100 (EST)
In-Reply-To: <200803251744.46001.laurentp@cse-semaphore.com>
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<200803251651.42608.laurentp@cse-semaphore.com>
	<47E926FB.3030900@ru.mvista.com>
	<200803251744.46001.laurentp@cse-semaphore.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6c0f876f13b57f6d8cc28e004ed73313@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: OF compatible MTD platform RAM driver ?
Date: Wed, 26 Mar 2008 16:09:22 +0100
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Cc: ben@simtec.co.uk, David Gibson <david@gibson.dropbear.id.au>,
	linux-mtd@lists.infradead.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The nvram device descrived in the Device Support Extensions is 
> probably meant
> to describe the kind of nvram found in RTC chips.

It describes a generic interface _within OF_ for _all kinds_ of NVRAM,
both physical and virtual.


Segher
