Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C39F767B53
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 15:32:20 +1000 (EST)
Date: Wed, 16 Aug 2006 15:32:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: michael@ellerman.id.au
Subject: Re: [POWERPC] iseries: remove some gcc 4.1 warnings
Message-Id: <20060816153206.5bd2d64e.sfr@canb.auug.org.au>
In-Reply-To: <1155705964.12715.8.camel@localhost.localdomain>
References: <20060816152032.2407a832.sfr@canb.auug.org.au>
	<1155705964.12715.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__16_Aug_2006_15_32_06_+1000_GRCHP8mYIkAW6axT"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__16_Aug_2006_15_32_06_+1000_GRCHP8mYIkAW6axT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Aug 2006 15:26:04 +1000 Michael Ellerman <michael@ellerman.id.au=
> wrote:
>
> On Wed, 2006-08-16 at 15:20 +1000, Stephen Rothwell wrote:
> > gcc 4.1 produces some warnings that it is ignoring the packed attribute
> > on some structure elements, so just remove them.
>=20
> Why is it ignoring them? Because there's no packing to be done?

A patch went into gcc to warn if the thing you are packing is already
minimally aligned.  I have not idea why it warns ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__16_Aug_2006_15_32_06_+1000_GRCHP8mYIkAW6axT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE4q3bFdBgD/zoJvwRAookAKCCj2S4ReDKPu6IETBJlE6v95kKnQCfT4vD
R5czs481lM2nfbxVhZ5LbLI=
=kbyC
-----END PGP SIGNATURE-----

--Signature=_Wed__16_Aug_2006_15_32_06_+1000_GRCHP8mYIkAW6axT--
