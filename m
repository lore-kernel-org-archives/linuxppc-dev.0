Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 28 Nov 2007 22:45:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: of_compat_cmp on various platforms
Message-Id: <20071128224518.b09c5b7f.sfr@canb.auug.org.au>
In-Reply-To: <9e4733910711271946q1b600d97mf5abe71cc64bbf81@mail.gmail.com>
References: <9e4733910711271946q1b600d97mf5abe71cc64bbf81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__28_Nov_2007_22_45_18_+1100_15x1ClGvSuGb_G_K"
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__28_Nov_2007_22_45_18_+1100_15x1ClGvSuGb_G_K
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Nov 2007 22:46:16 -0500 "Jon Smirl" <jonsmirl@gmail.com> wrote:
>
> Is this right or should it be the same everywhere?
>=20
> asm-powerpc/prom.h:#define of_compat_cmp(s1, s2, l)     strcasecmp((s1), =
(s2))
> asm-sparc/prom.h:#define of_compat_cmp(s1, s2, l)       strncmp((s1), (s2=
), (l))
> asm-sparc64/prom.h:#define of_compat_cmp(s1, s2, l)     strncmp((s1), (s2=
), (l))

The only reason these exist is because the sparc and powerpc versions
needed to be different when I was consolidating the of routines.  One of
the things we have to work on is finding the platforms/drivers where this
matters and fix them.

So, for now, these need to be there.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__28_Nov_2007_22_45_18_+1100_15x1ClGvSuGb_G_K
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHTVTWTgG2atn1QN8RArVYAJ0aOzAocZitDuQZ8h7TZws6cXzu4gCglnqo
Du1LmyRVU4hSzypZan6BSNY=
=9KQA
-----END PGP SIGNATURE-----

--Signature=_Wed__28_Nov_2007_22_45_18_+1100_15x1ClGvSuGb_G_K--
