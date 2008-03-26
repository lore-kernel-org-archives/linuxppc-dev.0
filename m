Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 195FFDE0A9
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 08:04:39 +1100 (EST)
Message-ID: <47EAB885.7000006@freescale.com>
Date: Wed, 26 Mar 2008 15:56:37 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 4/5] i2c: MPC837xRDB Power Management and GPIO expander
	driver
References: <20080326202511.GD1772@localhost.localdomain>
In-Reply-To: <20080326202511.GD1772@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> +config MCU_MPC837XRDB
> +	tristate "MPC837XRDB MCU driver"
> +	depends on I2C && MPC837x_RDB && OF_GPIO

The MPC8349E-mITX also has this chip.  Can you include support for that board as
well?

-- 
Timur Tabi
Linux kernel developer at Freescale
