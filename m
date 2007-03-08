Return-Path: <Haiying.Wang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 6CB5EDDF22
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 06:19:10 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l28JJ7MN029260
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 12:19:07 -0700 (MST)
Received: from az33exm23.fsl.freescale.net (az33exm23.am.freescale.net
	[10.64.32.8])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l28JJ6ki004613
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 13:19:06 -0600 (CST)
Subject: Re: [PATCH] Better timer and RTC handling for 8641HPCN.
From: Haiying Wang <Haiying.Wang@freescale.com>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1173381017.23776.211.camel@ld0161-tx32>
References: <1173293364.23776.128.camel@ld0161-tx32>
	<150E096E-0304-4E48-985C-2F4D599196FE@kernel.crashing.org>
	<20070307193438.GA30721@ld0162-tx32.am.freescale.net>
	<CBC6BDF5-EB84-463C-A53C-1204CC396D5F@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C0DBE14@zch01exm26.fsl.freescale.net>
	<011CC9FF-E609-43A1-BC66-C57CC6233B4B@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C0DBE68@zch01exm26.fsl.freescale.net>
	<1AEDE9F3-E4D4-4BB8-A0C7-D7D82BE29A4C@kernel.crashing.org>
	<1173381017.23776.211.camel@ld0161-tx32>
Content-Type: text/plain
Date: Thu, 08 Mar 2007 14:19:03 -0500
Message-Id: <1173381543.2968.10.camel@udp097531uds.am.freescale.net>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> And we're to change the NR_IRQS-10 to a hard 64 as well, right?
> 
If we need change to hard value here, we should use 80 instead 64
because there are 16 interrupt sources for 8259, 48 for internal, 12 for
external.

Haiying
