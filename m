Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 9BDFDDDF52
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 14:29:47 +1000 (EST)
Date: Fri, 6 Jun 2008 00:29:44 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080606002944.28ede529@lappy.seanm.ca>
In-Reply-To: <fa686aa40806052107r4f5903e6t1e408dff4dfa4eed@mail.gmail.com>
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<20080605024140.GA30980@yookeroo.seuss>
	<fa686aa40806052107r4f5903e6t1e408dff4dfa4eed@mail.gmail.com>
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

On Thu, 5 Jun 2008 22:07:31 -0600
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> The fallback is to just let the i2c layer auto-assign an ID.  The only
> reason I can think of to want to assign a specific id to an i2c bus is
> so that a userspace application can reference a specific bus.  The
> drivers really shouldn't care.

If we switch the iic driver to use i2c_add_adapter rather than
i2c_add_numbered_adapter, this is exactly what it does. i2c will use
the idr_ functions to assign a number.

Cheers,
   Sean
