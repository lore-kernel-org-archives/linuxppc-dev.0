Return-Path: <tnt@246tNt.com>
Received: from outmx007.isp.belgacom.be (outmx007.isp.belgacom.be
	[195.238.3.234]) by ozlabs.org (Postfix) with ESMTP id E565A67A8A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Mar 2005 01:00:19 +1100 (EST)
Received: from outmx007.isp.belgacom.be (localhost [127.0.0.1])
	by outmx007.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2PE0GVY011850
	for <linuxppc-embedded@ozlabs.org>; Fri, 25 Mar 2005 15:00:16 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4244197C.7080804@246tNt.com>
Date: Fri, 25 Mar 2005 15:00:28 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Andrey Volkov <avolkov@varma-el.com>
References: <0.20050322_000905.tnt@patchsend.246tNt.com>	<556f5ce38ca914dce63ca24277af4b3e@freescale.com>	<423FC578.8040202@246tNt.com>	<42427C2F.2070104@varma-el.com>	<4242CFF8.7090908@246tNt.com>
	<42430DF0.2050304@varma-el.com> <424404E2.2030602@varma-el.com>
In-Reply-To: <424404E2.2030602@varma-el.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC] MPC5200 Kernel/UBoot PCI problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Andrey,


Andrey Volkov wrote:
>>> Try adding some delays in the pci configuration zone access routines 
>>> in mpc52xx_pci.c  I remember someone needed those but still don't 
>>> know why, the manual don't say anything about that.
>>
>>
>> Board started, after I add udelay(7) in read/write config. Really 
>> strange.
> 
> 
> Sylvain, answer was in PCI2.2 specification, not in manual.
> 

Indeed good catch ! Never imagined the delay was so long.

It should be possible to use the sched_clock(void) to know if we're
booting since long enough, because just waiting 1 full second is ... long.


	Sylvain
