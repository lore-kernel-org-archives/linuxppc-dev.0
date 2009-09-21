Return-Path: <Sylvain.Cote@verint.com>
Received: from exprod7og105.obsmtp.com (exprod7og105.obsmtp.com [64.18.2.163])
	by ozlabs.org (Postfix) with SMTP id 4F452B7B6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Sep 2009 23:45:09 +1000 (EST)
From: "Cote, Sylvain" <Sylvain.Cote@verint.com>
To: Stefan Roese <sr@denx.de>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>
Date: Mon, 21 Sep 2009 09:44:30 -0400
Subject: RE: PPC_4xx synopsy USB driver
Message-ID: <579B119545DAEF4689C8FBEEFEC5793F01FA07D05186@ATLMBX.verint.corp.verintsystems.com>
References: <579B119545DAEF4689C8FBEEFEC5793F01FA07D04F37@ATLMBX.verint.corp.verintsystems.com>
	<200909210713.29238.sr@denx.de>
In-Reply-To: <200909210713.29238.sr@denx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stefan,


On Friday 18 September 2009 17:50:24 Cote, Sylvain wrote:
> USB gadget support --> y
>             Maximum VBUS power usage =3D 500
>             Synopsys DWC OTG controller
>             Synopsys DWC OTG internal DMA mode --> y
>             USB gadget --> M
>             gadget zero --> M
>             Ethernet Gadget --> M
>             RNDIS support --> y
>=20
> Any help will be appreciated

> Looks good so far. I suspect that the only thing missing for your 405EX=20
> custom=20
> board is the following line in the arch/powerpc/sysdev/Makefile:

> obj-$(CONFIG_KILAUEA)           +=3D amcc-usbotg.o

I have created a new platform (platform using 405ex).  I have missed this o=
ne for my new platform.  Do you know if there is a compilation switch that =
could be more generic (like CONFIG_40x) for the usbotg?

> to enable the device-tree to platform-device driver wrapper for the USB-
> OTG=20
> resources.

Thanks you,

Your help has been appreciated.

Sylvain

This electronic message may contain proprietary and confidential informat=
ion of Verint Systems Inc., its affiliates and/or subsidiaries.
The information is intended to be for the use of the individual(s) or
entity(ies) named above.  If you are not the intended recipient (or autho=
rized to receive this e-mail for the intended recipient), you may not use=
, copy, disclose or distribute to anyone this message or any information =
contained in this message.  If you have received this electronic message =
in error, please notify us by replying to this e-mail.
=0D
