Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E8C94DDE2E
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2007 21:12:19 +1000 (EST)
Subject: Re: [PATCH 08/10] macintosh: Use the new of_device common uevent
	handler
From: Johannes Berg <johannes@sipsolutions.net>
To: Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <460A4A6C.1060309@246tNt.com>
References: <11713184081457-git-send-email-tnt@246tNt.com>
	<11713184091057-git-send-email-tnt@246tNt.com>
	<11713184101239-git-send-email-tnt@246tNt.com>
	<11713184112187-git-send-email-tnt@246tNt.com>
	<11713184132161-git-send-email-tnt@246tNt.com>
	<11713184141191-git-send-email-tnt@246tNt.com>
	<11713184152189-git-send-email-tnt@246tNt.com>
	<11713184171985-git-send-email-tnt@246tNt.com>
	<11713184182928-git-send-email-tnt@246tNt.com>
	<1174977009.14065.0.camel@localhost.localdomain>
	<4608C390.5080205@246tNt.com> <1175077759.5151.48.camel@johannes.berg>
	<460A4A6C.1060309@246tNt.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/vhC1U0JTlUb5R3h7hj/"
Date: Wed, 28 Mar 2007 13:10:58 +0200
Message-Id: <1175080258.5151.52.camel@johannes.berg>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
	Linux PPC Dev ML <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/vhC1U0JTlUb5R3h7hj/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-03-28 at 12:58 +0200, Sylvain Munaut wrote:

> MODULE_DEVICE_TABLE(of, i2sbus_match);

Ok. That results in the alias of:Ni2sT*C* instead of of:Ni2sTi2sC as I
had it, but I assume * has some match-semantics here.

I'll submit a patch to the alsa folks.

johannes

--=-/vhC1U0JTlUb5R3h7hj/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGCk1C/ETPhpq3jKURAolkAKChI5XNiSLvzoCgVulLRNugCY9t2wCeNpFC
YslzqmzWvbGyiwfI/0V5hpI=
=nGvo
-----END PGP SIGNATURE-----

--=-/vhC1U0JTlUb5R3h7hj/--
