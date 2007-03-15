Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id E733FDDE04
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 00:05:02 +1100 (EST)
Message-ID: <45F94472.6010803@freescale.com>
Date: Thu, 15 Mar 2007 08:04:50 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Li Yang-r58472 <LeoLi@freescale.com>
Subject: Re: [PATCH][POWERPC] QE: Make QUICC Engine support a
	configurableoption
References: <989B956029373F45A0B8AF02970818902DB124@zch01exm26.fsl.freescale.net>
In-Reply-To: <989B956029373F45A0B8AF02970818902DB124@zch01exm26.fsl.freescale.net>
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

Li Yang-r58472 wrote:

> QE is so generic that can be used across different sub-archs maybe even
> archs.  Why doesn't it deserve a place out of "platform support" menu?
> An option in the top menu is another choice.

Yes, but for now, the QE is marketed as an option for a few SOCs.  That 
means that when you select the SOC, you expect to see configuration 
options for that SOC.

> On another thought, it is very unlikely that user chooses a more
> expensive chip with QE and won't use it.  So make it non-configurable
> and be selected automatically is not a bad idea for me.

This was addressed earlier.  On some boards, the QE is not wired to 
anything, so there's no point in enabling it.  Disabling it will prevent 
any unused QE code from becoming part of the kernel.
