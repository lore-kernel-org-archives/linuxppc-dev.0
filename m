Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 00150B71A1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 11:07:23 +1000 (EST)
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E21F2DDD1C
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 11:07:23 +1000 (EST)
Date: Wed, 17 Jun 2009 11:07:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] RFC: powerpc: expose the multi-bit ops that underlie
	single-bit ops.
Message-Id: <20090617110721.af627948.sfr@canb.auug.org.au>
In-Reply-To: <1245188026.14036.17.camel@pasglop>
References: <1243361946-6771-1-git-send-email-Geoff.Thorpe@freescale.com>
	<1245124418.12400.67.camel@pasglop>
	<4A37AC09.1020200@freescale.com>
	<1245188026.14036.17.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__17_Jun_2009_11_07_21_+1000_JGVLR8e3R_K3XVs8"
Cc: linuxppc-dev@ozlabs.org, Geoff Thorpe <Geoff.Thorpe@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__17_Jun_2009_11_07_21_+1000_JGVLR8e3R_K3XVs8
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jun 2009 07:33:46 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> You can also go totally mad and generate the whole function (both -s and
> non -s variants) from one macro but I wouldn't go that far :-)

Please don't (unless you keep the function names intact), it makes
finding the function with grep almost impossible ...

> > Also - any opinion on whether the same re-factoring of the asm-generic
> > versions should be undertaken? I'm not looking to bite off more than I
> > can chew, but I don't know if it's frowned upon to make powerpc-only
> > extensions to the API. And if you think an asm-generic patch makes
> > sense, could that be taken via linuxppc-dev too or does it need to go
> > elsewhere?
>=20
> I'm not people care -that- much :-) You can always try and post it to
> lkml (maybe linux-arch too) and see what comes back... but let's finish
> the powerpc variant first :-)

Also, we have an asm-generic maintainer now ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__17_Jun_2009_11_07_21_+1000_JGVLR8e3R_K3XVs8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAko4QckACgkQjjKRsyhoI8y78gCgiLzLgGqx44WcwY0LSgCQLnIH
zFIAniBkDc6Rz61AadHxM/j8rDUZ+gfW
=8sqm
-----END PGP SIGNATURE-----

--Signature=_Wed__17_Jun_2009_11_07_21_+1000_JGVLR8e3R_K3XVs8--
