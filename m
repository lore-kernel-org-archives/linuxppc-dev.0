Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 38A5FDDF34
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 13:21:38 +1100 (EST)
Subject: Re: [PATCH 4/5 v2] powermac: proper sleep management
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1174351738.3645.10.camel@johannes.berg>
References: <20070319105352.771599000@sipsolutions.net>
	<20070319105359.744830000@sipsolutions.net>
	<1174347848.5707.0.camel@johannes.berg>
	<1174349462.3660.1.camel@johannes.berg>
	<1174351738.3645.10.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-hdE0zxfi6xBPMB8lkors"
Date: Tue, 20 Mar 2007 03:19:40 +0100
Message-Id: <1174357180.3813.4.camel@johannes.berg>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-hdE0zxfi6xBPMB8lkors
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-03-20 at 01:48 +0100, Johannes Berg wrote:
> Grmbl. Breakage in the pm_ops interface means I can't do it this way
> either. Hold off on this until I get an answer from Rafael...

Nah, this patch is correct, the generic code is just totally borked.

johannes

--=-hdE0zxfi6xBPMB8lkors
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF/0S8/ETPhpq3jKURAmTiAKCLgRFzhAR8ug3rP3dJMiQPv/oSegCghKRJ
6KoEhSLQHKKcj3ZIu2aHuC0=
=1Bz0
-----END PGP SIGNATURE-----

--=-hdE0zxfi6xBPMB8lkors--
