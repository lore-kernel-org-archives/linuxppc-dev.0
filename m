Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B0EC3DDE41
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 00:59:55 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc/ftrace: Fix #if that should be #ifdef
From: Michael Ellerman <michael@ellerman.id.au>
To: Steven Rostedt <srostedt@redhat.com>
In-Reply-To: <1239029152.4753.2.camel@localhost.localdomain>
References: <db258c8de9d950c23d61abdcd121361a7bb40f75.1239028836.git.michael@ellerman.id.au>
	<1239029152.4753.2.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-9nekdx83qPl6wOo24qLM"
Date: Tue, 07 Apr 2009 00:59:47 +1000
Message-Id: <1239029987.30721.0.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <rostedt@goodmis.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-9nekdx83qPl6wOo24qLM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-04-06 at 10:45 -0400, Steven Rostedt wrote:
> On Tue, 2009-04-07 at 00:40 +1000, Michael Ellerman wrote:
> > Commit bb7253403f7a4670a128e4c080fd8ea1bd4d5029 (powerpc64,
> > ftrace: save toc only on modules for function graph), added a
> >=20
> > Fixes the following warning on 32-bit builds:
> >  arch/powerpc/kernel/ftrace.c:562:5: error: "CONFIG_PPC64" is not defin=
ed
> >=20
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>=20
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
>=20
> Hmm, maybe I'll keep the "Git Author" as srostedt@redhat.com, and change
> the signature to my goodmis account. Maybe that would be less confusing.

Thanks for the acks.

Yeah I copied the address from your S-O-B, so I'd say that address
should be the one you want mail to go to.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-9nekdx83qPl6wOo24qLM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknaGOMACgkQdSjSd0sB4dIhoACfWVUY5jlWIEP+mjUh8SN+9rHl
KlkAoJbVBCddPcyogJhWNpTZS3FgbyVK
=Xldd
-----END PGP SIGNATURE-----

--=-9nekdx83qPl6wOo24qLM--
