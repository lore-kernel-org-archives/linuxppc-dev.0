Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 4A4E6DE088
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 09:48:37 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Add USB support to mpc8349-mitx board port
Date: Sat, 7 Jul 2007 01:48:20 +0200
References: <20070706222909.19943.39455.stgit@trillian.secretlab.ca>
In-Reply-To: <20070706222909.19943.39455.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707070148.20526.arnd@arndb.de>
Cc: leoli@freescale.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 07 July 2007, Grant Likely wrote:
> --- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
> +++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
> @@ -63,6 +63,8 @@ static void __init mpc834x_itx_setup_arch(void)
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0ppc_md.pci_exclude_device =3D mpc83xx_exclude_dev=
ice;
> =A0#endif
> +
> +=A0=A0=A0=A0=A0=A0=A0mpc834x_usb_cfg();
> =A0}

Why is that necessary? Shouldn't there be an of_platform_driver that
simply does all the setup automatically if the device is present?

	Arnd <><
