Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id D2B75DDED4
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 06:21:50 +1100 (EST)
Message-ID: <45FAEE43.2040006@freescale.com>
Date: Fri, 16 Mar 2007 14:21:39 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][POWERPC] QE: Make QUICC Engine support a
	configurableoption
References: <989B956029373F45A0B8AF02970818902DB124@zch01exm26.fsl.freescale.net>
	<45F94472.6010803@freescale.com>
	<Pine.LNX.4.64.0703151006110.28961@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0703151006110.28961@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Here's the new patch, we will add in the 85xx version once 8568 is
> functional.

The patch works, but I was wondering if you could move the QE Options (i.e. fast and/or 
slow UCC support) to this same menu?  Right now, that menu appears on the top level. 
Instead, it should just appear on the Platform menu under "QUICC Engine Support".

Also, one thing I did notice is that currently, you can only select platforms, but not 
processors.  Basing QE support on a processor sub-family seems kinda weird, now.  Should 
we expand the 83xx Platforms menu to include specific processors as an option?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
