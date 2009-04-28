Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E7C85DDD1B
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 10:49:07 +1000 (EST)
Subject: Re: [PATCH 1/6] powerpc: Move #ifdef'ed body of do_IRQ() into a
	separate function
From: Michael Ellerman <michael@ellerman.id.au>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20090425181823.GA10481@lst.de>
References: <c3e0e417a708c5d76d9f4130e5f2b0398a1e0c3e.1240450296.git.michael@ellerman.id.au>
	<20090425181823.GA10481@lst.de>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-HHP3tLvp+1BUgME/DMCY"
Date: Tue, 28 Apr 2009 10:49:07 +1000
Message-Id: <1240879747.11027.2.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-HHP3tLvp+1BUgME/DMCY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2009-04-25 at 20:18 +0200, Christoph Hellwig wrote:
> On Thu, Apr 23, 2009 at 11:31:37AM +1000, Michael Ellerman wrote:
> > +#ifdef CONFIG_IRQSTACKS
>=20
> Wasn't there a plan to make CONFIG_IRQSTACKS the unconditional default?

Not sure. Looks like the 64-bit configs all turn it on, and all but one
or two of the 32-bit configs don't.

cheers

--=-HHP3tLvp+1BUgME/DMCY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkn2UoIACgkQdSjSd0sB4dKUSQCfSGVGK/PI2mzfIkdTyjCYtfVQ
y/wAoK/V1JssX5aW11tQzgAlJUP81w7K
=empB
-----END PGP SIGNATURE-----

--=-HHP3tLvp+1BUgME/DMCY--
