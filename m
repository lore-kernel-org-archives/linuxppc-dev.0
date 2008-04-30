Return-Path: <jengelh@medozas.de>
Received: from sovereign.computergmbh.de (sovereign.computergmbh.de
	[85.214.69.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 62B8EDE1A4
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 06:29:07 +1000 (EST)
Date: Wed, 30 Apr 2008 22:21:01 +0200 (CEST)
From: Jan Engelhardt <jengelh@medozas.de>
Sender: jengelh@sovereign.computergmbh.de
To: Scott Wood <scottwood@freescale.com>
Subject: Re: drivers/net/fec_8xx config problem
In-Reply-To: <20080430192329.GA9150@ld0162-tx32.am.freescale.net>
Message-ID: <alpine.LNX.1.10.0804302218380.5623@fbirervta.pbzchgretzou.qr>
References: <6E2EBEAF-DF1E-4439-91EF-B15EE39CAF61@freescale.com>
	<20080430192030.GA9084@ld0162-tx32.am.freescale.net>
	<151BA0B1-A188-41C7-B2DB-E8D63D15C218@freescale.com>
	<20080430192329.GA9150@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wednesday 2008-04-30 21:23, Scott Wood wrote:
>> On Apr 30, 2008, at 2:20 PM, Scott Wood wrote:
>> >On Wed, Apr 30, 2008 at 02:19:21PM -0500, Becky Bruce wrote:
>> >>I just noticed that the fec_8xx driver is not currently reachable via
>> >>menuconfig because it depends on 8XX instead of 8xx.
>> >[snip]
>> >>Since nobody has noticed this problem, I'm wondering if this driver
>> >>is still in (infrequent) use, or if it's been superseded and should
>> >>be removed, or if I'm just completely missing something with respect
>> >>to the use of "8XX" instead of "8xx".

Blame those developers who had the brilliant idea of using lowercase in
kconfig symbols (these things emit cosmic particles en masse!) :-)

arch/arm/mach-pxa/Kconfig:config PXA3xx
