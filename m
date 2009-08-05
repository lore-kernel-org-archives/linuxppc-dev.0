Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D7606B6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 22:52:23 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C5DD5DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 22:52:23 +1000 (EST)
Subject: Re: [PATCH] powerpc/mm: Fix switch_mmu_context to iterate of the
	proper list of cpus
From: Michael Ellerman <michael@ellerman.id.au>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090805113230.GB8985@zod.rchland.ibm.com>
References: <1249443212-25588-1-git-send-email-galak@kernel.crashing.org>
	<20090805113230.GB8985@zod.rchland.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-jotcjenMHQOXMH/QC1h/"
Date: Wed, 05 Aug 2009 22:52:22 +1000
Message-Id: <1249476742.5607.2.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-jotcjenMHQOXMH/QC1h/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-08-05 at 07:32 -0400, Josh Boyer wrote:
> On Tue, Aug 04, 2009 at 10:33:32PM -0500, Kumar Gala wrote:
> >Introduced a temporary variable into our iterating over the list cpus
> >that are threads on the same core.  For some reason Ben forgot how for
> >loops work.
>=20
> Have the powerpoint demons corrupted him already??

No I think one of his kids gave him swine flu.

cheers

--=-jotcjenMHQOXMH/QC1h/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkp5gIYACgkQdSjSd0sB4dKHzgCfXjHwHXaQ0gTgBI8DzNPdhTOI
NmkAn0N19ZAIJRNZiZ2Dy4OJuK78vsdd
=rnQ/
-----END PGP SIGNATURE-----

--=-jotcjenMHQOXMH/QC1h/--
