Return-Path: <tnt@246tNt.com>
Received: from outmx011.isp.belgacom.be (outmx011.isp.belgacom.be
	[195.238.3.3]) by ozlabs.org (Postfix) with ESMTP id 1402967A7E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Mar 2005 01:34:31 +1100 (EST)
Received: from outmx011.isp.belgacom.be (localhost [127.0.0.1])
	by outmx011.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2OEYNtI014606
	for <linuxppc-embedded@ozlabs.org>; Thu, 24 Mar 2005 15:34:23 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4242CFF8.7090908@246tNt.com>
Date: Thu, 24 Mar 2005 15:34:32 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Andrey Volkov <avolkov@varma-el.com>
References: <0.20050322_000905.tnt@patchsend.246tNt.com>	<556f5ce38ca914dce63ca24277af4b3e@freescale.com>	<423FC578.8040202@246tNt.com>
	<42427C2F.2070104@varma-el.com>
In-Reply-To: <42427C2F.2070104@varma-el.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC] MPC5200 PCI problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrey Volkov wrote:
> Hi Sylvain,
> 
> After last synchronization with your bk,
> PCI subsys stop calling drv->probe of driver for
> my external PCI board (UBoot meanwhile properly displayed and init this 
> board). May be I do something wrong? Or PCI is in disjoint state now?
> 

With which tree exactly ?

Try adding some delays in the pci configuration zone access routines in 
mpc52xx_pci.c  I remember someone needed those but still don't know why, 
the manual don't say anything about that.

What does /proc/pci shows ?


	Sylvain
