Return-Path: <timur@freescale.com>
Message-ID: <48922446.9060706@freescale.com>
Date: Thu, 31 Jul 2008 15:44:54 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
References: <4889EFFE.2070201@grandegger.com>	
	<20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com>	 <48921187.1090101@grandegger.com>
	<48921179.1080403@freescale.com>	 <48921888.3020900@grandegger.com>
	<48921954.4020103@freescale.com>	
	<48921DED.6010403@grandegger.com>	
	<9e4733910807311332q611b43b3y26f64b5269ccb657@mail.gmail.com>	
	<48922218.9020503@freescale.com>
	<9e4733910807311343h3a1b21dbub15754090a67fac6@mail.gmail.com>
In-Reply-To: <9e4733910807311343h3a1b21dbub15754090a67fac6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, Linux I2C <i2c@lm-sensors.org>,
	Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> It wouldn't go into the i2c driver, it would go into the mpc8xxx
> platform driver. Why is it bad to put it into the mpc8xxx platform
> driver? It is an accurate description of the mpc8xxx platform isn't
> it?

There's no need to put that code in the platform driver because U-Boot will put
the final result in the device tree!  That way, we won't need to update the
platform driver *and* U-Boot for any new SOC.

-- 
Timur Tabi
Linux kernel developer at Freescale
