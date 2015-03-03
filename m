Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 24E581A026F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 05:46:16 +1100 (AEDT)
Date: Tue, 3 Mar 2015 18:44:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <20150303184403.GE21293@sirena.org.uk>
References: <20150226161142.D08681A2360@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BPgJ2GbR8X7BKSc9"
In-Reply-To: <20150226161142.D08681A2360@localhost.localdomain>
Subject: Re: [PATCH] spi: fsl-spi: use of_iomap() to map parameter ram on CPM1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--BPgJ2GbR8X7BKSc9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 26, 2015 at 05:11:42PM +0100, Christophe Leroy wrote:
> On CPM2, the SPI parameter RAM is dynamically allocated in the dualport RAM
> whereas in CPM1, it is statically allocated to a default address with
> capability to relocate it somewhere else via the use of CPM micropatch.
> The address of the parameter RAM is given by the boot loader and expected
> to be mapped via of_iomap()

Why are we using of_iomap() rather than a generic I/O mapping function
here?

--BPgJ2GbR8X7BKSc9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU9gDyAAoJECTWi3JdVIfQZeYH/0iTYbCGDUqESLRuSfhDbpdi
mPGeWIAHENbJODx9JOsTepCbk3sQ2fdmWq7LCmlv/j412/9LPSk8Y0X7GsC73tE0
vueM2sEm4ZAlo+FbfUg2dx4xqtc9aTj8sX75CkTNL/U4ZAhvc60Q/DK56qmE+JEQ
8D95NxXQxJER2AqSAA/GUOwXpLAM01eRDKFEI6Ap+TOM3pNGeTjCJUxmlf4EJuHR
8Xy9nOUpE8QaMPDFx1hprNZdSXz0xZ5AjrLqgS3tQVE5WxHcc7VdOUQBbQ0L9pLO
idvttOchxPldNxLhuBAQki7tyOETNUSOFhPf74x9FrOwGWSeV9cN4jdI9vzzMJ8=
=1Xz7
-----END PGP SIGNATURE-----

--BPgJ2GbR8X7BKSc9--
