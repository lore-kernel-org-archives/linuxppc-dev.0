Return-Path: <R61911@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F3992B7D1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Apr 2010 19:27:30 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3L9RR9A026450 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Apr 2010 02:27:27 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3L9ZZNa001642
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Apr 2010 04:35:35 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: U-boot support for MPC85xx eSPI
Date: Wed, 21 Apr 2010 17:27:24 +0800
Message-ID: <996B8FEA386F2F4886BC50A82C84649B063AFE@zch01exm23.fsl.freescale.net>
In-Reply-To: <DA601BED1671C24093F284F75082C9934B68EB@rtpwbee01.SIXIS.NS>
References: <DA601BED1671C24093F284F75082C9934B68EB@rtpwbee01.SIXIS.NS>
From: "Zang Roy-R61911" <r61911@freescale.com>
To: "Hillery, Nathan" <nhillery@sixisinc.com>, <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, you can get the u-boot eSPI code for MPC8536 in Freescale
BSP. Which can be downloaded from Freescale web site.
We are working on merge spi & espi code together.
Thanks.
Roy


________________________________

	From:
linuxppc-dev-bounces+tie-fei.zang=3Dfreescale.com@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+tie-fei.zang=3Dfreescale.com@lists.ozlabs.or=
g
] On Behalf Of Hillery, Nathan
	Sent: Wednesday, April 21, 2010 2:25 AM
	To: linuxppc-dev@lists.ozlabs.org
	Subject: U-boot support for MPC85xx eSPI
=09
=09

	I'm looking for U-boot support for the embedded SPI driver on
the MPC8536 to access a SPI flash device (Numonyx [ex-STmicro] M25P16).
The eSPI can read the SPI flash (that's how U-boot gets loaded into RAM)
and I can read/write from linux using the mtdblock driver.  I see code
that appears to support the MPC83xx, but it looks quite different than
the MPC85xx.  I am willing to backport the linux code to work in U-boot,
but am hoping that isn't necessary.
