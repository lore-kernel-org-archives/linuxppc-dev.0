Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F6C567DC7
	for <linuxppc-dev@ozlabs.org>; Sun, 31 Jul 2005 02:19:28 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergey Kolosov <freeserj@gmail.com>
In-Reply-To: <d39e2e70507261510edd0e8@mail.gmail.com>
References: <d39e2e70507261510edd0e8@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 30 Jul 2005 18:16:08 +0200
Message-Id: <1122740168.18835.84.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: cpufreq on powerbook lombard
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-07-27 at 02:10 +0400, Sergey Kolosov wrote:
> How i can enabled cpufreq on my powerbook lombard? In kernel(2.6.11) source:
> 
> file /usr/src/kernel-source-2.6.11/arch/ppc/platforms/pmac_cpufreq.c
> 
> <...>
> /* Currently, we support the following machines:
>  *
>  *  - Titanium PowerBook 1Ghz (PMU based, 667Mhz & 1Ghz)
>  *  - Titanium PowerBook 800 (PMU based, 667Mhz & 800Mhz)
>  *  - Titanium PowerBook 400 (PMU based, 300Mhz & 400Mhz)
>  *  - Titanium PowerBook 500 (PMU based, 300Mhz & 500Mhz)
>  *  - iBook2 500/600 (PMU based, 400Mhz & 500/600Mhz)
>  *  - iBook2 700 (CPU based, 400Mhz & 700Mhz, support low voltage)
>  *  - Recent MacRISC3 laptops
>  *  - iBook G4s and PowerBook G4s with 7447A CPUs
>  */
> static int __init pmac_cpufreq_setup(void)
> <...>
> 
>  But can be there is a way for addition of support cpufreq for
> powerbook lombard ?

Note sure the PMU supports it...

Ben.
