Return-Path: <phazarika@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0D71ADDFB7
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 09:47:52 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Question on 4xx GIT tree
Date: Wed, 10 Sep 2008 16:47:48 -0700
Message-ID: <0CA0A16855646F4FA96D25A158E299D605014C18@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <20080908193856.0cfd1c86@zod.rchland.ibm.com>
References: <0CA0A16855646F4FA96D25A158E299D604F7F1A4@SDCEXCHANGE01.ad.amcc.com><20080908173509.7cccdbc7@zod.rchland.ibm.com><0CA0A16855646F4FA96D25A158E299D604F7F1E1@SDCEXCHANGE01.ad.amcc.com>
	<20080908193856.0cfd1c86@zod.rchland.ibm.com>
From: "Prodyut Hazarika" <phazarika@amcc.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Josh,
I have few questions.

> > Should I base my patch from your master branch or your 'next' =
branch?
> The 'next' branch would be best.

I saw that both your master and next branches have removed the 4xx dma =
and USB drivers.
The dma drivers for 4xx used to under: drivers/dma/ppc440spe-adma.c
The usb driver for 4xx used to be under: drivers/usb/gadget/dwc_otg/*
The whole dwc_otg directory got removed.

Do you know the reason why these drivers were removed? Also, are there =
plans to get these drivers back?
Please let me know.

Regards,
Prodyut Hazarika
