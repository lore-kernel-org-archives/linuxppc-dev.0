Return-Path: <BlakesleeS@embeddedplanet.com>
Received: from embeddedplanet.com (unknown [66.94.95.194])
	by ozlabs.org (Postfix) with ESMTP id 73A8867A64
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jan 2005 00:52:04 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 18 Jan 2005 08:52:02 -0500
Message-ID: <1628E43D99629C46988BE46087A3FBB912F525@ep-01.EmbeddedPlanet.local>
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: "Dayton, Dean" <deand@aiinet.com>, <linux-usb-devel@lists.sourceforge.net>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: USB host on Freescale MPC880
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

http://www.heeltoe.com/ has a usb driver for the 823, 850 processors.
This should be able to get you started.  There is also text talking
about the pitfalls using the 8xx USB controller.=20

> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of=20
> Dayton, Dean
> Sent: Tuesday, January 18, 2005 8:32 AM
> To: linux-usb-devel@lists.sourceforge.net;=20
> linuxppc-embedded@ozlabs.org
> Subject: USB host on Freescale MPC880
>=20
> I need to provide a USB host interface on a propietary board=20
> using a Freescale (Motorola) MPC880. The MPC880 has a USB=20
> implemented in the CPM, but I haven't found any Linux support=20
> for it. Can anyone point me to existing drivers? Does anyone=20
> know of any problems that would/should prevent me from using=20
> the MPC880's USB interface?
>=20
> Thanks
>=20
> -------------
> Dean Dayton
> Staff Engineer - Applied Innovation Inc.=20
> (614)923-1174
> deand@aiinet.com=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
