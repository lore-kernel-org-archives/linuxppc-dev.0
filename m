Return-Path: <BlakesleeS@embeddedplanet.com>
Received: from tag-03.ashton-group.com (tag-03.ashton-group.com [66.94.86.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 91CAD679F0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Apr 2006 05:28:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How do you make linux 2.6.10 U-Boot aware?
Date: Wed, 26 Apr 2006 14:57:13 -0400
Message-ID: <1628E43D99629C46988BE46087A3FBB95466D2@ep-01.EmbeddedPlanet.local>
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> I'm using MontaVista linux 4.01 for the PPC440GX which is=20
> based on 2.6.10.  It doesn't read the bootargs from U-Boot=20
> however.  Does anyone out there have a synopsis of what needs=20
> to be modified (bd_info, etc.) to make this work with a=20
> 2.6.10 based release?
>=20

The bd_info structure needs to come from ppcboot.h and the make command
is "make uImage"  That should be about it.
