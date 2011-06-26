Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
	[88.96.1.126]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06893B6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jun 2011 08:51:51 +1000 (EST)
Subject: Re: Bug#630845: linux-image-2.6.39-2-powerpc: CHRP Pegasos2 boot
	failure
From: Ben Hutchings <ben@decadent.org.uk>
To: Gabriel Paubert <paubert@iram.es>, Michael Ellerman
	<michael@ellerman.id.au>
In-Reply-To: <20110623203654.04f151e1.andrewb@zagam.net>
References: <20110617222943.2188.34712.reportbug@chrp.ab.bgc.com.au>
	<1308545397.11457.107.camel@localhost>
	<20110620222812.6cd7e862.andrewb@zagam.net>
	<1308711698.3093.285.camel@localhost>
	<20110623203654.04f151e1.andrewb@zagam.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature";
	boundary="=-NWDrElkHd5rL4MG/st0E"
Date: Sun, 26 Jun 2011 23:14:13 +0100
Message-ID: <1309126453.3093.1555.camel@localhost>
Mime-Version: 1.0
Cc: 630845@bugs.debian.org, Andrew Buckeridge <andrewb@zagam.net>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-NWDrElkHd5rL4MG/st0E
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-06-23 at 20:36 +0800, Andrew Buckeridge wrote:
> Package: linux-image-3.0.0-rc3-powerpc
> Version: 3.0.0~rc3-1~experimental.1
>=20
> On Wed, 22 Jun 2011 04:01:38 +0100
> Ben Hutchings <ben@decadent.org.uk> wrote:
>=20
> > > linux-image-2.6.36-trunk-powerpc_2.6.36-1~experimental.1_powerpc.deb
> > > linux-image-2.6.37-1-powerpc_2.6.37-1_powerpc.deb
> > > linux-image-2.6.37-2-powerpc_2.6.37-2_powerpc.deb
> > > These failed to boot. In all cases stuck at the spinner.
> >=20
> > At a guess, this may be fixed by a change in Linux 3.0-rc1:
>=20
> > Please can you test Linux 3.0-rc3, currently available in experimental?
>=20
> linux-image-3.0.0-rc3-powerpc_3.0.0~rc3-1~experimental.1_powerpc.deb
> Also failed to boot and got stuck at spinner.

Gabriel, Michael, do you recognise this bug?  Are there any fixes for
Pegasos that are missing from 3.0-rc3?

Ben.

--=20
Ben Hutchings
If more than one person is responsible for a bug, no one is at fault.

--=-NWDrElkHd5rL4MG/st0E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUATgevL+e/yOyVhhEJAQpf2g/6A6gp6abSJhCAte7eV5hoYhlscoE5LTaW
7mAas5WAbHH7yAELUJusGU0QCblxKI5nWkR6r3PIRR0K+Brw9YhupKsElwxdcfu8
AF65/Dv5Hx5ZG5Wa7KYBP8DYYSDvuYkK2SRTMcf0ISc5h9AUxa7EbMX0/nNui0H6
O0VTC5xFtGECza6QwqqZIssYZbkPEUEsXCNfOmwoF4Sv2YxOHsdN5OYzyCTJcAEt
wBxfMv3mwD0xTX6DStdEPcawik0v4BQgxq2XZjo0nZoCgIw7zZR5pRbbpvC2Atk5
CYLpJyQcOkEThZBT/Fn5u4he4fxDAyjOJvVYFOZhw28ZifJVYXDfMzWfUrrg20yA
LIEjHXuAB9yr7/cTe9Hs7FHaYQWiUTcqQAddIE1FPafeZ9cQm4XoaszaYCK5KCPL
DjYGlakedbG8zFbUgANjWqj9cofNBjCmDyaeQwK5CYegBuX1VbFoaGsii7geUMTI
hB29YHB8juG4yYSf9J9NQIOF9NbD8AAZj+F6tD72NfHRXdnZ7rbhpeatzLm1X5im
K3Ou5JC4COq5BH2QafYJElNg27Qbfxw+XeoPkdor7Rs+vOcz5z5ANHkpIQD4sQ7J
Ynr/JAZSXMymTwbaznQrbKh6UUpCQzMR6VX0eTZ1q31QI1LF4vItvuEkncI1oXjw
ugDLQsyXR+4=
=B8mn
-----END PGP SIGNATURE-----

--=-NWDrElkHd5rL4MG/st0E--
