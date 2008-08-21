Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4AF44DEFF6
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 23:49:42 +1000 (EST)
Date: Thu, 21 Aug 2008 23:49:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] math-emu: Fix compiler warnings
Message-Id: <20080821234935.33de917e.sfr@canb.auug.org.au>
In-Reply-To: <1219323021-7273-1-git-send-email-galak@kernel.crashing.org>
References: <1219323021-7273-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__21_Aug_2008_23_49_35_+1000_oVgyvhHdt3dMfydk"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__21_Aug_2008_23_49_35_+1000_oVgyvhHdt3dMfydk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Thu, 21 Aug 2008 07:50:20 -0500 Kumar Gala <galak@kernel.crashing.org> w=
rote:
>
> Fix warnings of the form:
> arch/powerpc/math-emu/fsubs.c:15: warning: 'R_f1' may be used uninitializ=
ed in this function
> arch/powerpc/math-emu/fsubs.c:15: warning: 'R_f0' may be used uninitializ=
ed in this function
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>=20
> I intend these patches to go via the powerpc.git tree if no one has issue=
s.
>=20
> - k
>=20
>  include/math-emu/op-2.h |    2 +-

Are you modifying the right file here?  There is also
arch/powerpc/math-emu/op-2.h which contains the same construct.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__21_Aug_2008_23_49_35_+1000_oVgyvhHdt3dMfydk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkitcm8ACgkQjjKRsyhoI8y5IACgnNw4T0S5wpOPBdfFoRi6ns/P
iosAnjxE1tXJ99ADfsi+ySaYpGOOVpNx
=aTmr
-----END PGP SIGNATURE-----

--Signature=_Thu__21_Aug_2008_23_49_35_+1000_oVgyvhHdt3dMfydk--
