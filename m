Return-Path: <khali@linux-fr.org>
Received: from kraid.nerim.net (smtp-102-tuesday.nerim.net [62.4.16.102])
	by ozlabs.org (Postfix) with ESMTP id 84384DDF17
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 07:31:35 +1100 (EST)
Date: Tue, 6 Nov 2007 21:31:32 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
Message-ID: <20071106213132.58ba7e1c@hyperion.delvare>
In-Reply-To: <4730B817.3000201@genesi-usa.com>
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F7247.9070106@freescale.com>
	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>
	<472F8267.8070106@freescale.com> <472F9086.2060606@genesi-usa.com>
	<20071106183210.50058019@hyperion.delvare>
	<4730B817.3000201@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Tjernlund <tjernlund@tjernlund.se>, i2c@lm-sensors.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Matt,

On Tue, 06 Nov 2007 18:53:11 +0000, Matt Sealey wrote:
> Jean Delvare wrote:
> > On Mon, 05 Nov 2007 21:52:06 +0000, Matt Sealey wrote:
> >> Well, all i2c devices have a chip id you can probe for (...)
> > 
> > This statement is completely incorrect. I2C devices do NOT have
> > standard ID registers. Some devices have proprietary ID registers, some
> > don't, it's really up to the manfacturer.
> 
> All I2C slave devices have to have a 7- or 10-bit address to identify them
> by. They *may* not report what they ARE, but this is 9 times out of
> 10 a hardware design decision of soldering the chip to a board and
> the address is then coded into device trees or hardcoded into drivers.
> 
> Whoever designed the board and has the datasheets knows the address
> they're supposed to be at, and the device can accept this.
> 
> You simply cannot entertain an i2c bus with "anonymous and unnumbered
> devices", every one has to have an address it responds to, however
> it is defined, or it just does not work.

Of course, but it is all about addressing, NOT identifying.

> WRT cell-index this is an index of the bus on the chip (not the logical
> i2c bus but the physical difference between two i2c controllers) and
> then any i2c devices which need to be communicated with would be
> child nodes, their reg property reflecting their slave address, is
> that not correct?

I am not familiar with the OF tree, I can't tell, sorry.

-- 
Jean Delvare
