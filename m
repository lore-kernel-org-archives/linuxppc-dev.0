Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 51712DDF31
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 13:01:34 +1000 (EST)
Subject: Re: [PATCH] powerpc: Add configurable -Werror for arch/powerpc
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20090407022743.GA12174@lixom.net>
References: <b0b55030b7ba669cbdec74a8b89875096ea07622.1239069602.git.michael@ellerman.id.au>
	<20090407022743.GA12174@lixom.net>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-ep/eygKHWn1XrDZptqCu"
Date: Tue, 07 Apr 2009 03:01:33 +0000
Message-Id: <1239073293.6565.18.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ep/eygKHWn1XrDZptqCu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-04-06 at 21:27 -0500, Olof Johansson wrote:
> On Tue, Apr 07, 2009 at 12:00:41PM +1000, Michael Ellerman wrote:
> > Add an option, on by default, to build all code under arch/powerpc with
> > -Werror, which causes gcc to treat warnings as errors.
> >=20
> > The intention is to make it harder for people to inadvertantly introduc=
e
> > errors in the arch/powerpc code. It needs to be configurable so that
> > if a warning is introduced, people can easily work around it while it's
> > being fixed.
>=20
> This looks useful at least for the automated builds to catch new warnings=
,
> but do similar options exist on other architectures, x86 in particular? I
> think a Cc to LKML of this could be useful.
>=20
> This is really only beneficial if various people build for powerpc often
> enough. If major subsystem maintainers aren't going to hit the errors
> it's more of a hinderance for PPC than a global benefit, right?

I don't think so. We're only enabling it for code under arch/powerpc -
and most modifications to that code should come through linuxppc.

It's still possible that random stuff will get merged, or that someone
will change code in a header that only causes warnings on powerpc, but
it's less likely.

And that's why it's an option, if someone breaks the build we can work
around it until they're appropriately LARTed.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ep/eygKHWn1XrDZptqCu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknawg0ACgkQdSjSd0sB4dIokwCcCmeItnZZotK2ShPJBC/qnIeZ
Y0IAoKYVyJostAlUq4BUvoz29ORctZgh
=5jp1
-----END PGP SIGNATURE-----

--=-ep/eygKHWn1XrDZptqCu--
