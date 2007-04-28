Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE105DDE0F
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 22:52:07 +1000 (EST)
Subject: Re: [PATCH] powermac: proper sleep management
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17971.256.739516.106925@cargo.ozlabs.ibm.com>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1177746562.3448.10.camel@johannes.berg>
	<17971.256.739516.106925@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-SVK3WxjO4ifDQMG3QaFi"
Date: Sat, 28 Apr 2007 14:52:14 +0200
Message-Id: <1177764734.5102.2.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-SVK3WxjO4ifDQMG3QaFi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-04-28 at 18:08 +1000, Paul Mackerras wrote:
> Johannes Berg writes:
>=20
> > +What:	/dev/pmu suspend/can-suspend ioctls
> > +When:	2.6.24
>=20
> No way.  You're proposing to remove a kernel/user ABI which is
> actively being used by many users.  It needs to stick around for at
> least 2 years before we make it non-functional.

Heh, ok, let's push the timeline out then. Don't really care anyway
since the feature now has about 10 lines of code.

johannes

--=-SVK3WxjO4ifDQMG3QaFi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGM0N+/ETPhpq3jKURAozfAJ9/RFeJPJvtSx4KgAU6MmEz50QgrgCeMDd8
VvHnsdy9hYCjb5+Zw2yAVo4=
=pQh6
-----END PGP SIGNATURE-----

--=-SVK3WxjO4ifDQMG3QaFi--
