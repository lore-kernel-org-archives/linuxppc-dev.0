Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 433EDB70CC
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 11:04:12 +1000 (EST)
Date: Thu, 19 Aug 2010 11:04:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Wolfgang Denk <wd@denx.de>
Subject: Re:
Message-Id: <20100819110405.4ccb74e1.sfr@canb.auug.org.au>
In-Reply-To: <20100818205646.57783157D71@gemini.denx.de>
References: <20100818205646.57783157D71@gemini.denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__19_Aug_2010_11_04_05_+1000_USMZVUJ_1XVssG+x"
Cc: linuxppc-dev@ozlabs.org, Rupjyoti Sarmah <rsarmah@amcc.com>,
	Prodyut Hazarika <phazarika@appliedmicro.com>,
	Mark Miesfeld <mmiesfeld@appliedmicro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__19_Aug_2010_11_04_05_+1000_USMZVUJ_1XVssG+x
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wolfgang,

On Wed, 18 Aug 2010 22:56:46 +0200 Wolfgang Denk <wd@denx.de> wrote:
>
> drivers/ata/sata_dwc_460ex.c: At top level:
> drivers/ata/sata_dwc_460ex.c:1592: warning: 'struct of_device' declared i=
nside parameter list
> drivers/ata/sata_dwc_460ex.c:1592: warning: its scope is only this defini=
tion or declaration, which is probably not what you want
> drivers/ata/sata_dwc_460ex.c: In function 'sata_dwc_probe':
> drivers/ata/sata_dwc_460ex.c:1607: error: dereferencing pointer to incomp=
lete type
> drivers/ata/sata_dwc_460ex.c:1614: error: dereferencing pointer to incomp=
lete type
> drivers/ata/sata_dwc_460ex.c:1616: error: dereferencing pointer to incomp=
lete type
> drivers/ata/sata_dwc_460ex.c:1622: error: dereferencing pointer to incomp=
lete type
> drivers/ata/sata_dwc_460ex.c:1628: error: dereferencing pointer to incomp=
lete type
> drivers/ata/sata_dwc_460ex.c:1630: error: dereferencing pointer to incomp=
lete type
> drivers/ata/sata_dwc_460ex.c:1646: error: dereferencing pointer to incomp=
lete type
> drivers/ata/sata_dwc_460ex.c:1650: error: dereferencing pointer to incomp=
lete type
> drivers/ata/sata_dwc_460ex.c:1652: error: dereferencing pointer to incomp=
lete type
> drivers/ata/sata_dwc_460ex.c:1658: error: dereferencing pointer to incomp=
lete type
> drivers/ata/sata_dwc_460ex.c:1660: error: dereferencing pointer to incomp=
lete type
> drivers/ata/sata_dwc_460ex.c:1667: error: dereferencing pointer to incomp=
lete type
> drivers/ata/sata_dwc_460ex.c:1676: error: dereferencing pointer to incomp=
lete type
> drivers/ata/sata_dwc_460ex.c:1678: error: dereferencing pointer to incomp=
lete type
> drivers/ata/sata_dwc_460ex.c:1691: error: dereferencing pointer to incomp=
lete type
> drivers/ata/sata_dwc_460ex.c:1693: error: dereferencing pointer to incomp=
lete type
> drivers/ata/sata_dwc_460ex.c: At top level:
> drivers/ata/sata_dwc_460ex.c:1705: warning: 'struct of_device' declared i=
nside parameter list
> drivers/ata/sata_dwc_460ex.c: In function 'sata_dwc_remove':
> drivers/ata/sata_dwc_460ex.c:1707: error: dereferencing pointer to incomp=
lete type
> drivers/ata/sata_dwc_460ex.c:1720: error: dereferencing pointer to incomp=
lete type
> drivers/ata/sata_dwc_460ex.c: At top level:
> drivers/ata/sata_dwc_460ex.c:1736: warning: initialization from incompati=
ble pointer type
> drivers/ata/sata_dwc_460ex.c:1737: warning: initialization from incompati=
ble pointer type

I think most of these (if not all) are fixed in Linus' tree today.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__19_Aug_2010_11_04_05_+1000_USMZVUJ_1XVssG+x
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMbIMFAAoJEDMEi1NhKgbsPfUH/2EMqgMwS9xkbIQTJwaa3c16
WGgHVdLZtRIV932hqKd05RcHJlGdwmLo1jRrzFG+JM+LpVQXyNCwQFfaVYgwPKBU
jUqcvwyxKGbelQs8VO3vMCpF8/+RGuus7ZSwkOmcuPcKdvWOp4NnPDOOL+qsNo9P
FuBwJMPP1kGugZugzx+aOV+4FlOpq11k7n7oypCyPwT6bxKmsZM0gjYWf450XB7v
3LYrQUI5HzgpwlmDjvoyltqsRocSyTIaTvRbxAXCyYN0YErm66FA9gXbSn3mOt+U
7GmNqeqYTGmaCxxW9+hnMuDI7EcGeA4NpeXVRbvnr6G+Gi40IyD1efmpBo8B4XU=
=yeMC
-----END PGP SIGNATURE-----

--Signature=_Thu__19_Aug_2010_11_04_05_+1000_USMZVUJ_1XVssG+x--
