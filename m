Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0F210DDE0F
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 22:51:41 +1000 (EST)
Subject: Re: [PATCH] powermac: proper sleep management
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1177749491.14873.348.camel@localhost.localdomain>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1177746562.3448.10.camel@johannes.berg>
	<1177749491.14873.348.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-u5n/8Blf9M73hCCIH7Tq"
Date: Sat, 28 Apr 2007 14:51:36 +0200
Message-Id: <1177764696.5102.0.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-u5n/8Blf9M73hCCIH7Tq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-04-28 at 18:38 +1000, Benjamin Herrenschmidt wrote:

> What happened to moving that code out of the PMU driver ?

It was a separate patch and also buggy and had feature regressions. So I
left it for now.

johannes

--=-u5n/8Blf9M73hCCIH7Tq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGM0NY/ETPhpq3jKURAvVJAJwN3SuLhhdL3+d+zK5V8P75J03HJgCfb3XX
svulWr2ChFoZoqMeBi4mc/c=
=U3Rr
-----END PGP SIGNATURE-----

--=-u5n/8Blf9M73hCCIH7Tq--
