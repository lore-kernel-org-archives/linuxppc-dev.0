Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 76938DE41C
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 02:30:12 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m55GRPnl016458
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 09:27:26 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m55GRPnp008287
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 11:27:25 -0500 (CDT)
Date: Thu, 5 Jun 2008 11:27:24 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080605162724.GA4150@ld0162-tx32.am.freescale.net>
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<4848028B.5060105@freescale.com>
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>
	<48480987.1070701@freescale.com>
	<935d90b908261c8e5862caeeb1f396aa@kernel.crashing.org>
	<48480FAC.3020406@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48480FAC.3020406@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 05, 2008 at 11:09:16AM -0500, Timur Tabi wrote:
> The fabric driver doesn't have access to any I2C structures when it starts
> looking for the codec driver.  The fabric driver is like an OF platform driver,
> in that it's OF-aware and machine-specific.  By parsing the device tree (which
> is the only tool I have to know how the board is laid out), the fabric driver
> can determine that SSI1 is attached to a CS4270 on I2C bus #1, address 0x4F.
> That's the only information it has.

No, it's not.  It can determine that it's at address 0x4f on the i2c bus
at 0xe0003100.  This is exactly how the ethernet phy lookup is done.

-Scott
