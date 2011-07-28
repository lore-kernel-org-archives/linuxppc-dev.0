Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E8A12B6F62
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Jul 2011 06:02:33 +1000 (EST)
Message-ID: <4E31C04D.7040700@freescale.com>
Date: Thu, 28 Jul 2011 15:02:21 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [RFC PATCH] powerpc: 85xx: Make e500/e500v2 depend on !E500MC
References: <fef1cfc9a418ec5aa3302915dcb392882f7dd5d2.1308545584.git.baruch@tkos.co.il>
	<CAOZdJXVsJUrCaNVHjhLkL=-GwAr79S9xQdoRLvjFG--k1jdRvw@mail.gmail.com>
In-Reply-To: <CAOZdJXVsJUrCaNVHjhLkL=-GwAr79S9xQdoRLvjFG--k1jdRvw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Kumar Gala <kumar.gala@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 wrote:
> On Sun, Jun 19, 2011 at 11:56 PM, Baruch Siach <baruch@tkos.co.il> wrote:
>> CONFIG_E500MC breaks e500/e500v2 systems. It defines L1_CACHE_SHIFT to 6, thus
>> breaking clear_pages(), probably others too.
>>
>> Cc: Kumar Gala <galak@kernel.crashing.org>
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>> Is this the right approach?
> 
> It doesn't work for me.

I also get this error if I try to build corenet32_smp_defconfig:

arch/powerpc/platforms/Kconfig.cputype:136:error: recursive dependency detected!
arch/powerpc/platforms/Kconfig.cputype:136:	symbol PPC_E500MC is selected by
P2040_RDB
arch/powerpc/platforms/85xx/Kconfig:176:	symbol P2040_RDB depends on PPC_E500MC

-- 
Timur Tabi
Linux kernel developer at Freescale
