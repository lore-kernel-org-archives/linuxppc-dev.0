Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 9164967B89
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Sep 2006 21:18:35 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k87BIYC0004013
	for <linuxppc-embedded@ozlabs.org>; Thu, 7 Sep 2006 04:18:34 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k87BIW38014579
	for <linuxppc-embedded@ozlabs.org>; Thu, 7 Sep 2006 06:18:33 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: MPC8360E USB Host Controller Driver
Date: Thu, 7 Sep 2006 19:19:05 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D14C7B1@zch01exm20.fsl.freescale.net>
In-Reply-To: <44FFFB70.2080903@cambridgebroadband.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Alex Zeffertt" <ajz@cambridgebroadband.com>
Cc: n.balaji@gdatech.co.in, linuxppc-embedded@ozlabs.org
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
> From: Alex Zeffertt [mailto:ajz@cambridgebroadband.com]=20
> Sent: Thursday, September 07, 2006 6:59 PM
> To: Li Yang-r58472
> Cc: n.balaji@gdatech.co.in; linuxppc-embedded@ozlabs.org
> Subject: Re: MPC8360E USB Host Controller Driver
>=20
> >> manual, they told that this controller does not belong to UHCI or=20
> >> OHCI standard.
> >=20
> > Yes, you can call it FHCI if you like. :)
>=20
> I heard that on the PQII (82xx) devices the FHCI required=20
> intervention from the core, even when there was zero traffic=20
> on the USB.  I think this was because the core had to=20
> continuously service a 1ms interrupt.  This generates=20
> significant extra loading, making it worth considering using=20
> a cheap EHCI chip instead....

There are improvements on future chips with a QE.  However it is still
full-speed and need CPU intervention.  But keep in mind that USB is not
a key feature for netcomm devices which PQ is targeting.
>=20
> Does anyone know if this is still the case with the PQII Pro (83xx)?

834x has a integrated EHCI controller instead.

- Leo
