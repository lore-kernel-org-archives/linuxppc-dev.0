Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 496E21A127A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Nov 2014 05:14:30 +1100 (AEDT)
Date: Fri, 21 Nov 2014 18:12:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <20141121181253.GX3815@sirena.org.uk>
References: <20141120162418.04FAC1A9BFC@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="RyRVxeT1fPSLkipE"
In-Reply-To: <20141120162418.04FAC1A9BFC@localhost.localdomain>
Subject: Re: [PATCH] spi: fsl-spi: Don't use cpm_command on CPM1
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


--RyRVxeT1fPSLkipE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2014 at 05:24:17PM +0100, Christophe Leroy wrote:
> On CPM1, when the SPI parameter RAM is relocated to somewhere else than t=
he
> default location, in accordance with freescale documentation
> (refer micropatch SPI application note EB662), init RX/TX params command =
shall
> not be used because it doesn't take into account the new location, and
> overwrites data that is in original location of SPI param ram at addresse=
s=20
> SCC2 param base +  (u32*)0x88 (u16*)0x90 (u32*)0x98 (u16*)0xA0, hence bre=
aking
> activity on SCC2 if SCC2 is used in a mode like QMC for instance.

Applied, thanks.

--RyRVxeT1fPSLkipE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUb4CkAAoJECTWi3JdVIfQzEIIAIBpGFtzX4a+MGQh8q+sJtEs
AwPTpoaGY/EzbgYSx39srYrjQD17FK5uogXnDRYcg62BEIbvix2PQrNgADXK0xLi
wF6VY2ApnMnyoBZQKx+yT0d1esADAswtX8pfkD2yL2WroIwIfCtC1six4uXZB2WC
UEantw8K25PTJfNLT3N82Cb21qclcuA1vUYe/Q+8dtQKJzz+kt+v4Q8dZCKqoiWf
lvA43RWlFLXfjjQnCfpb4v4Cm1sNglJkuMsJS+opiKMvjq9b1NkPL3rs3ysb5NyG
9haY99ntFjTYydZEmsQT1YBAsjfR01rCuaJnee6jWJZWMx46t5oLG1OGaymWQf8=
=uMc0
-----END PGP SIGNATURE-----

--RyRVxeT1fPSLkipE--
