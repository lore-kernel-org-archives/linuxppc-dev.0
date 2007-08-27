Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC925DDE23
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 22:02:34 +1000 (EST)
Subject: Re: [PATCH, RFC] linkstation: implement standby
From: Johannes Berg <johannes@sipsolutions.net>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.60.0708260157330.3809@poirot.grange>
References: <Pine.LNX.4.60.0708260157330.3809@poirot.grange>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-KmUNYJrFsD9tMOtLzTLj"
Date: Mon, 27 Aug 2007 13:32:07 +0200
Message-Id: <1188214327.7837.9.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-KmUNYJrFsD9tMOtLzTLj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-08-26 at 02:03 +0200, Guennadi Liakhovetski wrote:

> +#ifdef CONFIG_PM

some of those probably want to be CONFIG_PM_SLEEP now.

johannes

--=-KmUNYJrFsD9tMOtLzTLj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBG0rY3/ETPhpq3jKURArfIAKC2MPW1GwkBK/asGcPPva3xkgskOQCeIVkv
laCrRFpYP1ptMfDcZSWYZvA=
=TDsh
-----END PGP SIGNATURE-----

--=-KmUNYJrFsD9tMOtLzTLj--
