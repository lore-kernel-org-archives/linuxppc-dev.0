Return-Path: <stuart.yoder@conformative.com>
Received: from relay3.mail.twtelecom.net (relay3.mail.twtelecom.net
	[216.136.95.10]) by ozlabs.org (Postfix) with ESMTP id 5DE3C67AC6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Apr 2005 05:16:25 +1000 (EST)
From: "Stuart Yoder" <stuart.yoder@conformative.com>
To: "'Kumar Gala'" <kumar.gala@freescale.com>
Date: Tue, 26 Apr 2005 14:16:14 -0500
Message-ID: <056601c54a94$6d0cae50$2f010a0a@foundation.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <9380e411aa15fa62ab142301af963314@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: PowerPC + SMP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks Kumar.

How can I know what assumptions the kernel makes about the state of the
CPU/system when it begins execution? Is this clearly documented
anywhere?

Do you know of open source bootloaders for Linux that would demonstrate
how to set up the CPUs as the Linux kernel expects.

Thanks,
Stuart

> -----Original Message-----
> From: Kumar Gala [mailto:kumar.gala@freescale.com]=20
> Sent: Monday, April 25, 2005 4:40 PM
> To: Stuart Yoder
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: PowerPC + SMP
>=20
>=20
> On Apr 25, 2005, at 4:10 PM, Stuart Yoder wrote:
>=20
> > Hi.
> > =A0
> > I am trying to figure out where in the PowerPC kernel the HID1
> > register is updated to enable bits dealing with cache=20
> coherency in an=20
> > SMP system.=A0=A0 Grepping through the arch/ppc source does not =
reveal=20
> > much.
> > =A0
> > I have=A0two 7447A processors and somewhere the ABE and SYNCBE bits =
in
> > HID1=A0need to be turned on to enable cache coherency.=A0=A0 Is=20
> supposed to=20
> > happen in the bootloader prior to the kernel running??
>=20
> The expectation is that the bootloader normally handles such things.
>=20
> - kumar
>=20
>=20
>=20
>=20
