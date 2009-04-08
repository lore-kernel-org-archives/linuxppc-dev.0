Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1DCFEDDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 10:06:09 +1000 (EST)
Subject: Re: [PATCH] powerpc/oprofile: dump_pmcs() is not used
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AE9B4B27-F781-4C0B-9E17-79F3E7C78CF7@kernel.crashing.org>
References: <95c5ebd63992c64ad0b644f1204362aaf5e35eeb.1239025478.git.michael@ellerman.id.au>
	<771B1F79-194B-4C6A-A2AE-5E4BEF0A17D3@freescale.com>
	<AE9B4B27-F781-4C0B-9E17-79F3E7C78CF7@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-JstCZrtjSHsFGhcnE5ju"
Date: Wed, 08 Apr 2009 10:06:08 +1000
Message-Id: <1239149168.6848.1.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>,
	afleming@freescale.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-JstCZrtjSHsFGhcnE5ju
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-04-07 at 14:42 -0500, Kumar Gala wrote:
> On Apr 6, 2009, at 9:03 AM, Kumar Gala wrote:
>=20
> >
> > On Apr 6, 2009, at 8:45 AM, Michael Ellerman wrote:
> >
> >> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> >> ---
> >> arch/powerpc/oprofile/op_model_fsl_emb.c |    2 ++
> >> 1 files changed, 2 insertions(+), 0 deletions(-)
> >>
> >> Or should we just remove it?
> >
> > I'm for removing it if Andy doesn't have any issues.  Someone can =20
> > always add it back as debugfs code in the future if they want it.
>=20
> I chatted w/Andy and we both agreed to just remove the code rather =20
> than #if 0 it.  If you send me a patch with that I'll apply it.

Cool, done.

Delegated to you in patchwork too. I was going to mark the old one as
superseded but I won't mess with it while it's delegated to you.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-JstCZrtjSHsFGhcnE5ju
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknb6nAACgkQdSjSd0sB4dJoBwCghCMFg+fg049M7swd4bfp799C
1VEAn1xLIFuXhXX4vT0M+Igvf3kpOPIU
=cRxE
-----END PGP SIGNATURE-----

--=-JstCZrtjSHsFGhcnE5ju--
