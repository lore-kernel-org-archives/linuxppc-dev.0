Return-Path: <BlakesleeS@embeddedplanet.com>
Received: from tag-03.ashton-group.com (tag-03.ashton-group.com [66.94.86.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A280167B68
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 May 2006 05:27:43 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: USB on MPC8349EMDS
Date: Tue, 2 May 2006 15:26:27 -0400
Message-ID: <1628E43D99629C46988BE46087A3FBB9546A40@ep-01.EmbeddedPlanet.local>
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: "Prashant Viswanathan" <vprashant@echelon.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>=20
> / #  usb 1-2: new high speed USB device using fsl-usb2-mph=20
> and address 8 usb 1-2: khubd timed out on ep0in usb 1-2: new=20
> high speed USB device using fsl-usb2-mph and address 9 usb=20
> 1-2: khubd timed out on ep0in
>=20

When I used that driver I found it only worked with Full speed devices.
Low and High speed devices did not work.
