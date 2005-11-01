Return-Path: <BlakesleeS@embeddedplanet.com>
Received: from tag-03.ashton-group.com (tag-03.ashton-group.com [66.94.86.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 48ECB68662
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Nov 2005 04:14:09 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 1 Nov 2005 11:43:59 -0500
Message-ID: <1628E43D99629C46988BE46087A3FBB93AE08B@ep-01.EmbeddedPlanet.local>
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: "Dick Hollenbeck" <dick@softplc.com>,
	<linuxppc-dev@ozlabs.org>
Subject: RE: AMCC440EP Boot Source
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> We are looking at the yosemite design but want a CF2 socket=20
> for the OS=20
> image.   Can U-Boot reside in the EEPROM accessible via I2C? =20

Are you sure that the 440EP can run code from the EEPROM on the I2C?
The 440EP loads configuration information from the EEPROM on the I2C but
I don't know it can run code.=20

>=20
> This would allow us to remove the flash entirely in favor of=20
> the CF2 flash.  If yes, are there any drawbacks to this vs.=20
> keeping a small bit of flash soldered to the board?

I'm pretty sure you need to have flash.  If you don't want the onboard
flash you can connect some through the PCI.
