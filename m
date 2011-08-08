Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 13715B6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Aug 2011 05:43:02 +1000 (EST)
Message-ID: <4E403C3C.1050001@freescale.com>
Date: Mon, 8 Aug 2011 14:42:52 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v2] powerpc: 85xx: separate e500 from e500mc
References: <1fb57aeaeefcc40f6646d026caba8d40371d18fb.1312175199.git.baruch@tkos.co.il>
	<029dda0b5fef124811bd4c577bdade25d7f93fba.1312794031.git.baruch@tkos.co.il>
In-Reply-To: <029dda0b5fef124811bd4c577bdade25d7f93fba.1312794031.git.baruch@tkos.co.il>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/08/2011 04:07 AM, Baruch Siach wrote:
> CONFIG_E500MC breaks e500/e500v2 systems. It defines L1_CACHE_SHIFT to 6, thus
> breaking clear_pages(), probably others too.
> 
> This patch adds a new "Processor Type" entry for e500mc, and makes e500 systems
> depend on PPC_E500.

I can see confusion coming from having CONFIG_E500 and CONFIG_PPC_E500...

Maybe CONFIG_PPC_E500V1_2?  Or CONFIG_PPC_E500V2, with a note in the
kconfig help that it supports e500v1 as well.

-Scott
