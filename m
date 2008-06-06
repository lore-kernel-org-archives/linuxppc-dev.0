Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 37645DDF92
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 14:19:20 +1000 (EST)
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <4848028B.5060105@freescale.com>
References: <200806041706.21557.sr@denx.de>	<4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<4848028B.5060105@freescale.com>
Content-Type: text/plain
Date: Fri, 06 Jun 2008 14:19:04 +1000
Message-Id: <1212725944.12464.18.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-06-05 at 10:13 -0500, Timur Tabi wrote:
> Josh Boyer wrote:
> 
> > From a device tree perspective, index and cell-index are both
> > incorrect.  The IIC macros don't share register blocks with anything,
> > are enumerated as unique instances per macro in the device tree, and
> > should be able to be distinguished by "regs" and/or unit address.
> 
> I think we should just expand the definition of cell-index to include standard
> device enumeration for when it's needed.  The original definition is too
> limited, IMHO.

No. I disagree. Expanding the definition is the wrong thing to do, and
as I pointed out in an earlier mail, will not work well with SMP or
multi-chip setups.

Ben.
