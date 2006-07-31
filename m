Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 20F3B67B61
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jul 2006 19:00:16 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k6V9BtGT007904 for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jul 2006 02:11:55 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k6V8uTnU018311
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jul 2006 03:56:30 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: cpm_dpalloc
Date: Mon, 31 Jul 2006 16:56:54 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D071175@zch01exm20.fsl.freescale.net>
In-Reply-To: <20060731085022.138740@gmx.net>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: <GSM909@gmx.de>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

There is a bug in rheap for alignment.  The patch is still hanging =
around. =20
Search rheap and alignment on the linuxppc-dev list for patch previously =
posted.

Best Regards,
Leo
> -----Original Message-----
> From: linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org] On =
Behalf Of
> GSM909@gmx.de
> Sent: Monday, July 31, 2006 4:50 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: cpm_dpalloc
>=20
> Hi All
>=20
> I have a MPC82xx Processor from Freescale with Linux 2.6.14 ( Can=B4t =
chance to an
> new version).
>=20
> My Problem is that I want to allocate a 64byte of memory in the dual =
ported ram
> with an alignment of 64bytes. (Needed for SPI Parameter Ram)
>=20
> the funktion cpm_dpalloc(64,64) returned 0x220 but that are not in a =
64 byte
> alignment.
>=20
> Regards
> Fred
> --
>=20
>=20
> Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
> Ideal f=FCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
