Return-Path: <khali@linux-fr.org>
Received: from mallaury.nerim.net (smtp-105-friday.noc.nerim.net [62.4.17.105])
	by ozlabs.org (Postfix) with ESMTP id 7612EDDDFC
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 01:19:25 +1000 (EST)
Date: Fri, 18 May 2007 17:19:42 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
Message-ID: <20070518171942.4ea6e770@hyperion.delvare>
In-Reply-To: <8183195dad79296e3986f561bf929067@kernel.crashing.org>
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
	<8183195dad79296e3986f561bf929067@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 17 May 2007 21:18:15 +0200, Segher Boessenkool wrote:
> > +   Required properties :
> > +
> > +    - reg : Unshifted 7-bit I2C address for the device
> 
> What about 10-bit addressing, etc.?

Who needs this? Support for 10-bit I2C addressing has been broken for
years and nobody seems to care.

-- 
Jean Delvare
