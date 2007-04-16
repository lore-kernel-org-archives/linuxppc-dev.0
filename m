Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 1E9C7DDE4A
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 09:07:18 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [5/5] pasemi: GPIO MDIO of_platform driver
Date: Tue, 17 Apr 2007 01:07:12 +0200
References: <20070416062634.GB20196@lixom.net>
	<20070416063139.GC20319@lixom.net>
In-Reply-To: <20070416063139.GC20319@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704170107.12709.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 16 April 2007, Olof Johansson wrote:
> +static int __devinit hack_init(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0struct platform_device *pdev;
> +
> +=A0=A0=A0=A0=A0=A0=A0pdev =3D platform_device_register_simple("gpio-mdio=
=2Dbitbang", 0, NULL, 0);
> +
> +=A0=A0=A0=A0=A0=A0=A0return 0;
> +}
> +late_initcall(hack_init);

Why do you need this? The name already suggests that you are aware that this
should be autoprobed, but it would be good to have a comment explaining
why you did it this way.

	Arnd <><
