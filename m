Return-Path: <BlakesleeS@embeddedplanet.com>
Received: from tag-03.ashton-group.com (tag-03.ashton-group.com [66.94.86.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6BF72679EB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 May 2005 01:35:20 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 18 May 2005 11:05:08 -0400
Message-ID: <1628E43D99629C46988BE46087A3FBB9247587@ep-01.EmbeddedPlanet.local>
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: <extabe@bredband.net>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: USB-host driver for 440ep (bamboo)?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 > -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of=20
> extabe@bredband.net
> Sent: Wednesday, May 18, 2005 9:16 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: USB-host driver for 440ep (bamboo)?
>=20
> Is there any driver for the USB-host-controller built-in the=20
> 440ep CPU.
> I=B4m using the Bamboo board and need USB-host support.
> Does anyone have any experience with that?
>=20

U-boot 1.1.3 has a usb_ohci.c driver for the MPC5200.  That driver with =
just a few changes worked like a champ on the 440EP.
