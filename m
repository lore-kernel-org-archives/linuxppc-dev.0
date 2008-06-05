Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 70C54DF3D5
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 03:52:19 +1000 (EST)
Message-ID: <484827C5.6030108@freescale.com>
Date: Thu, 05 Jun 2008 12:52:05 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<4848028B.5060105@freescale.com>
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>
	<48480987.1070701@freescale.com>
	<935d90b908261c8e5862caeeb1f396aa@kernel.crashing.org>
	<48480FAC.3020406@freescale.com>
	<20080605162724.GA4150@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080605162724.GA4150@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:

> No, it's not.  It can determine that it's at address 0x4f on the i2c bus
> at 0xe0003100.  This is exactly how the ethernet phy lookup is done.

But how does the fabric driver know whether e0003100 is I2C1 or I2C2?

And how does the codec driver, which sees only I2C information, know that it's
at e0003100?

-- 
Timur Tabi
Linux kernel developer at Freescale
