Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 713CCDE4BF
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 01:24:40 +1000 (EST)
Message-ID: <4848028B.5060105@freescale.com>
Date: Thu, 05 Jun 2008 10:13:15 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
References: <200806041706.21557.sr@denx.de>	<4846B39F.3010601@freescale.com>	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
In-Reply-To: <20080604211942.2bddc860@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:

> From a device tree perspective, index and cell-index are both
> incorrect.  The IIC macros don't share register blocks with anything,
> are enumerated as unique instances per macro in the device tree, and
> should be able to be distinguished by "regs" and/or unit address.

I think we should just expand the definition of cell-index to include standard
device enumeration for when it's needed.  The original definition is too
limited, IMHO.

-- 
Timur Tabi
Linux kernel developer at Freescale
