Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 55690DDE2B
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 19:02:58 +1000 (EST)
Subject: Re: [PATCH 7/7] MPIC U3/U4 MSI backend
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <1178614502.18162.34.camel@johannes.berg>
References: <20070508025843.0D93ADDEFD@ozlabs.org>
	<1178614502.18162.34.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-7AvOcLRx3l8hCGmeQxNm"
Date: Tue, 08 May 2007 11:04:51 +0200
Message-Id: <1178615091.18162.36.camel@johannes.berg>
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


--=-7AvOcLRx3l8hCGmeQxNm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-05-08 at 10:55 +0200, Johannes Berg wrote:

> How badly will this clash with my patch that implements suspend/resume
> for mpic, and will I need to do more suspend/resume for this?

Oh. I see that my patch is in there already. Will we have to implement
suspend/resume for the MSI case?

johannes

--=-7AvOcLRx3l8hCGmeQxNm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGQD0y/ETPhpq3jKURAqbyAJ9p5yRhUmR0VJiAWkzzI97zd0taWQCcCmmJ
7IIZVbSQ148zrRg1WXsPmdo=
=+Dey
-----END PGP SIGNATURE-----

--=-7AvOcLRx3l8hCGmeQxNm--
