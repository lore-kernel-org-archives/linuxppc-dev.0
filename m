Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id DEC3DDDF73
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 10:23:34 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 9/13] powerpc: Add arch/powerpc mv64x60 I2C platform data
	setup
Date: Thu, 26 Apr 2007 02:21:19 +0200
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426000043.GK4046@mag.az.mvista.com>
In-Reply-To: <20070426000043.GK4046@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704260221.20150.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 April 2007, Mark A. Greer wrote:
> +static int __init mv64x60_i2c_platform_device_init(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0struct device_node *np =3D NULL;
> +=A0=A0=A0=A0=A0=A0=A0int i;
> +=A0=A0=A0=A0=A0=A0=A0struct platform_device *pdev;
> +=A0=A0=A0=A0=A0=A0=A0int err;
> +
> +=A0=A0=A0=A0=A0=A0=A0for (i =3D 0;
> +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 (np =3D of_find_compatible_node(np, "i2c",=
 "mv64x60-i2c"));

Same comment as about the ethernet driver: You should register an
of_platform_driver from drivers/i2c/busses/i2c-mv64xxx.c.

Repeat after me:=20

I will not call of_find_compatible_node() from device drivers.
I will not call of_find_compatible_node() from device drivers.
I will not call of_find_compatible_node() from device drivers.

	Arnd <><
