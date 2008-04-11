Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 9C645DE691
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 03:43:07 +1000 (EST)
Date: Fri, 11 Apr 2008 10:43:06 -0700 (PDT)
Message-Id: <20080411.104306.93639801.davem@davemloft.net>
To: jochen@scram.de
Subject: Re: [PATCH3/7] i2c: OF helpers for the i2c API
From: David Miller <davem@davemloft.net>
In-Reply-To: <47FF710D.2040208@scram.de>
References: <47FF710D.2040208@scram.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	scottwood@freescale.com, i2c@lm-sensors.org, khali@linux-fr.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jochen Friedrich <jochen@scram.de>
Date: Fri, 11 Apr 2008 16:09:17 +0200

> +
> +config OF_I2C
> +	def_bool y
> +	depends on OF && PPC_OF && I2C
> +	help
> +	  OpenFirmware I2C accessors

I wouldn't mind trying to use this infrastructure on
sparc64, and I don't see any powerpc specific interfaces
being invoked, so if you could remove the PPC_OF
requirement I'd appreciate it.

Thanks.
