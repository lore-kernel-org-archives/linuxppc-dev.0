Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4FCF2DE3E1
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 02:33:09 +1000 (EST)
Message-ID: <48481373.8010706@freescale.com>
Date: Thu, 05 Jun 2008 11:25:23 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
References: <200806041706.21557.sr@denx.de>	<4846B39F.3010601@freescale.com>	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>	<20080604211942.2bddc860@zod.rchland.ibm.com>	<4848028B.5060105@freescale.com>	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>	<48480987.1070701@freescale.com>	<fa686aa40806050900i40f0aa62o4bab3b8c7409b15f@mail.gmail.com>	<484810A3.5070301@freescale.com>
	<20080605112122.0381a338@zod.rchland.ibm.com>
In-Reply-To: <20080605112122.0381a338@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, Stefan Roese <sr@denx.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:

> And it does.  It does so by the unique "regs" properties and
> unit-names.  You can assign the index that the i2c subsystem needs
> based on probe order, like I already said.

The probe order is not sufficient on platforms that specifically enumerate their
I2C (or whatever) devices.  For instance, in order to do audio playback on an
MPC8610, SSI1 needs to use DMA channel 0.  The SSI driver specifically needs to
find the register addresses for DMA channel 0.

-- 
Timur Tabi
Linux kernel developer at Freescale
