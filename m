Return-Path: <mike@terascala.com>
Received: from hermes.terascala.com (terascala.com [75.147.14.129])
	by ozlabs.org (Postfix) with ESMTP id A0AA5B7B7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Oct 2009 03:23:20 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Regression detecting memory size on PPC440EPx
Date: Mon, 5 Oct 2009 12:23:16 -0400
Message-ID: <2C7DE72B9BD00F44BAECA5B0CBB873955CADF5@hermes.terascala.com>
In-Reply-To: <4ACA194A.6070907@lebon.org.ua>
From: "Mike Nuss" <mike@terascala.com>
To: "Mikhail Zolotaryov" <lebon@lebon.org.ua>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mikhail Zolotaryov wrote:
> Hi Mike,
>=20
> you wrote:
> "Row address bits : 13
> DDR0_02 =3D 0x020C0E01
> DDR0_42 =3D 0x00000006"
>=20
> Register values above define that memory has 14 row address bits. The
> correct setting is (for CAS Latency =3D 3):
> DDR0_42 =3D 0x01000006
>=20
> Best regards,
> Mikhail Zolotaryov
>=20

Thank you! It was a bug in U-Boot (they were encoding that register
incorrectly). I'll submit a patch to them.

Mike
