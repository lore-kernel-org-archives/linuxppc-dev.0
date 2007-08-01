Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 1 Aug 2007 14:43:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Gabriel C <nix.or.die@googlemail.com>
Subject: Re: [PATCH] [POWERPC] Typo fixes interrrupt -> interrupt
Message-Id: <20070801144318.f81fd988.sfr@canb.auug.org.au>
In-Reply-To: <46AFFB0B.102@googlemail.com>
References: <46AFFB0B.102@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__1_Aug_2007_14_43_18_+1000_Jsi=DVbnGXmF21Ha"
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__1_Aug_2007_14_43_18_+1000_Jsi=DVbnGXmF21Ha
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 01 Aug 2007 05:16:27 +0200 Gabriel C <nix.or.die@googlemail.com> wr=
ote:
>
>  arch/powerpc/platforms/iseries/it_lp_naca.h       |   87 +++++++++++----=
------

NAK this part as it just makes a lot of the lines more than 80 characters
for no real gain on a platform that is moving on ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__1_Aug_2007_14_43_18_+1000_Jsi=DVbnGXmF21Ha
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGsA9qTgG2atn1QN8RAhaxAJ92SCCPf7BTvwaTepP0EvcPVzwqSACfReU3
tekm2LUkU4AWar31EVuoudQ=
=nA2f
-----END PGP SIGNATURE-----

--Signature=_Wed__1_Aug_2007_14_43_18_+1000_Jsi=DVbnGXmF21Ha--
