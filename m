Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id A4A58DDE18
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 12:54:35 +1000 (EST)
Date: Wed, 4 Jun 2008 22:54:32 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080604225432.1a6c15e4@lappy.seanm.ca>
In-Reply-To: <20080604211942.2bddc860@zod.rchland.ibm.com>
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 4 Jun 2008 21:19:42 -0500
"Josh Boyer" <jwboyer@linux.vnet.ibm.com> wrote:

> From a device tree perspective, index and cell-index are both
> incorrect.  The IIC macros don't share register blocks with anything,
> are enumerated as unique instances per macro in the device tree, and
> should be able to be distinguished by "regs" and/or unit address.

So say I have an i2c bus and I want to call i2c_get_adapter.
Would I have to know the register address of the i2c bus to lookup the
adapter?

Or would they have aliases like serial ports do?

Cheers,
   Sean
