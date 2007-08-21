Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 14596DDED2
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 23:16:00 +1000 (EST)
In-Reply-To: <12253417.post@talk.nabble.com>
References: <12253417.post@talk.nabble.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5FEB1695-5F0F-46AA-8030-75F9FCFE5243@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Skipping the host bridge in arch/powerpc
Date: Tue, 21 Aug 2007 08:17:59 -0500
To: sivaji <rameshmrm@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 21, 2007, at 7:13 AM, sivaji wrote:

>
> Hai,
>         I am using the kernel 2.6.21. In the file
> (arch/ppc/syslib/pci_auto.c) we have the function pciauto_bus_scan 
> (). In
> this function it will skip the host birdge. But in the arch/powepc  
> directory
> we don't have that types of file and the function pciauto_bus_scan 
> () also
> removed.
> I want to know where the function was moved in arch/powerpc  
> directory ?

This code doesn't exist in arch/powerpc we use more of the generic  
drivers/pci code

> How the host bridge was skip in the arch/powerpc directory.

Again, if you look 2.6.23-rc3 there have been some fixes so you don't  
need to skip the host bridge anymore for Freescale PPC.

- k
