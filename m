Return-Path: <linuxppc-embedded@ml.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E5C11DDEBA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 17:57:30 +1000 (EST)
Date: Thu, 18 Oct 2007 09:57:24 +0200
From: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: loading NOR flash from DT
Message-ID: <20071018075724.GC5501@Chamillionaire.breakpoint.cc>
References: <20071017192651.GA5192@Chamillionaire.breakpoint.cc>
	<47166860.6000705@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <47166860.6000705@ru.mvista.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

* Sergei Shtylyov | 2007-10-17 23:54:08 [+0400]:

> Hello.
Hello,

>    I guess you were using quite recent kernel version where the file that 
> published the node (arch/powerpc/sysdev/rom.c) had been already dremoved 
> and and the platform code still didn't publish the on-board devices via 
> of_platform_bus_probe().
>
>> After modprobing physmap_of nothing happend. Then I tried to make a tree
>> with plb -> opb -> ebc and finally nor_flash but still nothing changed.
>
>    Add either of_platform_bus_probe() or platform_device_create() to 
> arch/powerpc/platforms/85xx/85xx_ds.c.
>
>> Is there a user space dependency or did I just edit my device tree the
>> wrong way? Any hints are welcome :)
>

Thanks, that was the missing piece :)
>
> WBR, Sergei

Sebastian
