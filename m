Return-Path: <kylo.ginsberg@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.200])
	by ozlabs.org (Postfix) with ESMTP id 0363067A39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 07:50:19 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id g11so1412756rne
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 May 2005 14:50:18 -0700 (PDT)
Message-ID: <61cc712d05051614507b688c6e@mail.gmail.com>
Date: Mon, 16 May 2005 14:50:18 -0700
From: Kylo Ginsberg <kylo.ginsberg@gmail.com>
To: Guillaume Autran <gautran@mrv.com>
In-Reply-To: <4284E379.1060907@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <005b01c557bd$c04e2770$0301a8c0@chuck2>
	<ed43f07150d50a594be2bc2589e902a0@freescale.com>
	<4284E379.1060907@mrv.com>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC885 - USB HCI drivers.
Reply-To: Kylo Ginsberg <kylo.ginsberg@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Guillaume,

There is a driver in the linux-2.4 tree at denx.de, although I have no
experience with it.  Here's info on the cvs repository:=20
http://www.denx.de/e/solution-se.php.  Look in drivers/usb for
m8xxhci.[ch]  This code is not in the 2.4/2.6 trees on kernel.org, not
sure if patches have been submitted.  I don't know the history here.

I will shortly be in need of a 2.6-based driver for the mpc8555e, but
haven't found any patches.  I'll probably look to port this driver, so
if you need to modify it, please post patches.

Cheers,
Kylo


On 5/13/05, Guillaume Autran <gautran@mrv.com> wrote:
> Hi,
>=20
> Is there any driver for the USB host controller interface built-in the
> MPC885 processors.
> Does anyone have any experience with it ?
>=20
> Thanks.
> Guillaume.
>=20
> --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Guillaume Autran
> Senior Software Engineer
> MRV Communications, Inc.
> Tel: (978) 952-4932 office
> E-mail: gautran@mrv.com
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
