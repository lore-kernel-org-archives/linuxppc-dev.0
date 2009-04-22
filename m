Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2CB24DDFB7
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 09:46:32 +1000 (EST)
Date: Thu, 23 Apr 2009 09:46:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: Refactor board check for quirk
Message-Id: <20090423094626.0dcd23ba.sfr@canb.auug.org.au>
In-Reply-To: <1240419370-1971-1-git-send-email-galak@kernel.crashing.org>
References: <1240419370-1971-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__23_Apr_2009_09_46_26_+1000_al8iTEk/lfdG=fsY"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__23_Apr_2009_09_46_26_+1000_al8iTEk/lfdG=fsY
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Wed, 22 Apr 2009 11:56:10 -0500 Kumar Gala <galak@kernel.crashing.org> w=
rote:
>
> Refactor the check to determine if the quirk is applicable to the boards
> into one inline function so we only have to change one place to add more
> boards that the quirks might be applicable to.
>=20
> Also removed a warning related to unused temp variable.

This commit message could be made better by giving the reader a hint as to
which board is being referred to.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__23_Apr_2009_09_46_26_+1000_al8iTEk/lfdG=fsY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknvrFIACgkQjjKRsyhoI8x1mwCcD6xDvXV+afQheaMUt22UBbC9
wVQAoJF6htUkIUbSFgGwRqJrQmG6I+z+
=Hytc
-----END PGP SIGNATURE-----

--Signature=_Thu__23_Apr_2009_09_46_26_+1000_al8iTEk/lfdG=fsY--
