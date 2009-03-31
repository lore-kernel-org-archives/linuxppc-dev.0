Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EF209DDDA5
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 10:44:00 +1100 (EST)
Subject: Re: [PATCH] Add hvc_console to MAINTAINERS
From: Michael Ellerman <michael@ellerman.id.au>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090331132944.GB2332@yoda.jdub.homelinux.org>
References: <49BF956B.9030109@gmail.com>
	<20090330133531.f5d99c09.akpm@linux-foundation.org>
	<20090330205553.GA19278@yoda.jdub.homelinux.org>
	<20090330141852.59baaeda.akpm@linux-foundation.org>
	<20090331132944.GB2332@yoda.jdub.homelinux.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-SGW8tY8ZyBVnGt98JSSL"
Date: Wed, 01 Apr 2009 10:44:00 +1100
Message-Id: <1238543040.6522.10.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	roel.kluin@gmail.com, linux-kernel@vger.kernel.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-SGW8tY8ZyBVnGt98JSSL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-03-31 at 09:29 -0400, Josh Boyer wrote:
> Add a MAINTAINERS entry for the hypervisor virtual console support
> used on IBM POWER servers.
>=20
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> ---
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c5f4e9d..387ad45 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2176,6 +2176,11 @@ W:       http://www.ia64-linux.org/
>  T:     git kernel.org:/pub/scm/linux/kernel/git/aegl/linux-2.6.git
>  S:     Maintained
> =20
> +IBM HYPERVISOR VIRTUAL CONSOLE
> +P:     Several
> +L:     linuxppc-dev@ozlabs.org
> +S:     Maintained

I don't think it's the "IBM" Hypervisor virtual console driver anymore.
There are backends for Xen, Beat (Toshiba) and virtio.=20

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-SGW8tY8ZyBVnGt98JSSL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknSqsAACgkQdSjSd0sB4dIUfQCeILBfRD7KXJXjdtQzw3AaXuVW
ERQAoKYjXtrTZxl9dCMgNU5BXNlEWfRa
=xOsv
-----END PGP SIGNATURE-----

--=-SGW8tY8ZyBVnGt98JSSL--
