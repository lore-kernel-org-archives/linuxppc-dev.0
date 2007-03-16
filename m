Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6CB2EDDEB9
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 06:45:33 +1100 (EST)
In-Reply-To: <45FAEE43.2040006@freescale.com>
References: <989B956029373F45A0B8AF02970818902DB124@zch01exm26.fsl.freescale.net>
	<45F94472.6010803@freescale.com>
	<Pine.LNX.4.64.0703151006110.28961@localhost.localdomain>
	<45FAEE43.2040006@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <03ECE1F6-5048-44FA-86FD-A42C954E4071@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][POWERPC] QE: Make QUICC Engine support a
	configurableoption
Date: Fri, 16 Mar 2007 14:44:42 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 16, 2007, at 2:21 PM, Timur Tabi wrote:

> Kumar Gala wrote:
>> Here's the new patch, we will add in the 85xx version once 8568 is
>> functional.
>
> The patch works, but I was wondering if you could move the QE  
> Options (i.e. fast and/or slow UCC support) to this same menu?   
> Right now, that menu appears on the top level. Instead, it should  
> just appear on the Platform menu under "QUICC Engine Support".

This will get fixed up as part of my larger arch/powerpc/Kconfig cleanup

> Also, one thing I did notice is that currently, you can only select  
> platforms, but not processors.  Basing QE support on a processor  
> sub-family seems kinda weird, now.  Should we expand the 83xx  
> Platforms menu to include specific processors as an option?

No, right now the platform implies the processor.

- k
