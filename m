Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DA5FEDE0C4
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 00:39:03 +1000 (EST)
Message-ID: <4832E27C.1080902@freescale.com>
Date: Tue, 20 May 2008 09:38:52 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 1/7] [POWERPC] sysdev: implement FSL GTM support
References: <20080519174558.GA26229@polina.dev.rtsoft.ru>
	<20080519174651.GA28185@polina.dev.rtsoft.ru>
	<AAEC7B21-11B1-4922-9726-70E43DA3829B@kernel.crashing.org>
	<20080520124138.GA20813@polina.dev.rtsoft.ru>
In-Reply-To: <20080520124138.GA20813@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> Btw, this is silent config, selected by the board's Kconfig
> (same as QE block, for example). So "depends on" here is just
> no-op, since select disregards dependencies. Still want this?

FYI, I have plans to modify the Kconfigs so that CONFIG_QUICC_ENGINE is
user-selectable.

-- 
Timur Tabi
Linux kernel developer at Freescale
