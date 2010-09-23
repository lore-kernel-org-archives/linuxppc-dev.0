Return-Path: <rdunlap@xenotime.net>
Received: from xenotime.net (xenotime.net [72.52.115.56])
	by ozlabs.org (Postfix) with SMTP id 1E7F3B70DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 04:38:15 +1000 (EST)
Received: from chimera.site ([173.50.240.230]) by xenotime.net for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 23 Sep 2010 11:38:08 -0700
Date: Thu, 23 Sep 2010 11:38:07 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [BUG 2.6.36-rc5] of_i2c.ko <-> i2c-core.ko dependency loop
Message-Id: <20100923113807.4643fbbb.rdunlap@xenotime.net>
In-Reply-To: <19611.16302.262307.129176@pilspetsen.it.uu.se>
References: <19611.16302.262307.129176@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 23 Sep 2010 13:53:18 +0200 Mikael Pettersson wrote:

> Running modules_install from a newly built 2.6.36-rc5 kernel
> on my 32-bit PowerMac results in:
> 
> WARNING: Module /lib/modules/2.6.36-rc5/kernel/drivers/i2c/busses/i2c-powermac.ko ignored, due to loop
> WARNING: Loop detected: /lib/modules/2.6.36-rc5/kernel/drivers/i2c/i2c-core.ko needs of_i2c.ko which needs i2c-core.ko again!
> WARNING: Module /lib/modules/2.6.36-rc5/kernel/drivers/i2c/i2c-core.ko ignored, due to loop
> WARNING: Module /lib/modules/2.6.36-rc5/kernel/drivers/i2c/i2c-dev.ko ignored, due to loop
> WARNING: Module /lib/modules/2.6.36-rc5/kernel/drivers/of/of_i2c.ko ignored, due to loop
> WARNING: Module /lib/modules/2.6.36-rc5/kernel/sound/ppc/snd-powermac.ko ignored, due to loop
> 
> > grep '.*I2C.*=' .config
> CONFIG_OF_I2C=m
> CONFIG_I2C=m
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_CHARDEV=m
> CONFIG_I2C_POWERMAC=m
> 
> I can't say exactly when this started, haven't built kernels on this
> box in a while.


No kconfig warnings?  Please post your full .config file.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
