Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 91386B7BD0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Oct 2009 17:46:25 +1100 (EST)
Date: Tue, 6 Oct 2009 17:46:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/iseries: remove compiler version dependent hack
Message-Id: <20091006174618.b3b1defc.sfr@canb.auug.org.au>
In-Reply-To: <20091006172847.440e8798.sfr@canb.auug.org.au>
References: <20091006172847.440e8798.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__6_Oct_2009_17_46_18_+1100_oVvuP3hSA5+hA/Tk"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__6_Oct_2009_17_46_18_+1100_oVvuP3hSA5+hA/Tk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Tue, 6 Oct 2009 17:28:47 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> The creation of the flattened device tree depended on the compiler
> putting the constant strings for an object in a section with a
> particular name.  This was changed with recent compilers.  Do this
> explicitly instead.
>=20
> Without this patch, iseries kernels may silently not boot when built with
> some compilers.

So this is probably a candidate for 2.6.32 and maybe some of the stable
releases (if anyone cares enough).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__6_Oct_2009_17_46_18_+1100_oVvuP3hSA5+hA/Tk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkrK57oACgkQjjKRsyhoI8zzjwCfUqDE1Cp7O/1yv12dqs7XGLV2
TnoAoIlYYYQodpf3/7Z1+1emF2u0oM0Y
=mSPV
-----END PGP SIGNATURE-----

--Signature=_Tue__6_Oct_2009_17_46_18_+1100_oVvuP3hSA5+hA/Tk--
