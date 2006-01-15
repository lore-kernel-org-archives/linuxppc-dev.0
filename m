Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2289C689F1
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jan 2006 08:48:41 +1100 (EST)
Subject: Re: AGPGART driver for ArticiaS - ioremap() problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <19351.1137053713@www55.gmx.net>
References: <1137041067.7774.25.camel@localhost.localdomain>
	<19351.1137053713@www55.gmx.net>
Content-Type: text/plain; charset=utf-8
Date: Mon, 16 Jan 2006 08:48:28 +1100
Message-Id: <1137361708.4823.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Please take a look at the end of my previous mail, where I included the
> debug messages of the driver and the driver code itself. The log shows that
> the physical address is mapped (IMHO) to the PCI memory range (>
> 0x0c0000000). Is this correct? Shouldn't it be mapped to the system memory
> address range?

I don't understand. I would need to now more about what the bridge
actually does to get any sense out of that.

> The aperture size is 4MB, page_order should be 1 and num_entries = 1024.
> 
> Hope this helps!? :-)
> 
> Thanks!
> 
> Regards,
> 
> Gerhard
> 
> -- 
> DSL-Aktion wegen großer Nachfrage bis 28.2.2006 verlängert:
> GMX DSL-Flatrate 1 Jahr kostenlos* http://www.gmx.net/de/go/dsl
> 
> 
