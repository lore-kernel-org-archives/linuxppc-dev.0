Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B89F0DDEE2
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 05:18:23 +1000 (EST)
In-Reply-To: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8183195dad79296e3986f561bf929067@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/5] powerpc: Document device nodes for I2C devices.
Date: Thu, 17 May 2007 21:18:15 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +   Required properties :
> +
> +    - reg : Unshifted 7-bit I2C address for the device

What about 10-bit addressing, etc.?

> +   Recommended properties :
> +
> +    - compatible : The name of the Linux device driver that
> +      handles this device.  If unspecified, the name of the
> +      node will be used.

NO WAY

> +    - interrupts : <a b> where a is the interrupt number and b is a

I2C doesn't do interrupts, this doesn't belong in
an I2C binding; it's redundant anyway (and incorrect
as well).


I second most of Kumar's sentiments, too.


Segher
