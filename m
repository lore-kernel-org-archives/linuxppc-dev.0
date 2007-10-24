Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0BE4CDDF50
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 19:23:32 +1000 (EST)
Subject: Re: [PATCH] fix powerpc breakage in sg chaining code (again)
From: Johannes Berg <johannes@sipsolutions.net>
To: Jens Axboe <jens.axboe@oracle.com>
In-Reply-To: <1193217816.5715.8.camel@johannes.berg>
References: <1193173222.7733.42.camel@johannes.berg>
	<1193176034.4097.3.camel@johannes.berg>
	<20071024091446.GL14671@kernel.dk>
	<1193217742.5715.6.camel@johannes.berg>
	<1193217816.5715.8.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-msR8zjzPxlg/u43XWxnN"
Date: Wed, 24 Oct 2007 11:24:50 +0200
Message-Id: <1193217890.5715.10.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-msR8zjzPxlg/u43XWxnN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-10-24 at 11:23 +0200, Johannes Berg wrote:
> On Wed, 2007-10-24 at 11:22 +0200, Johannes Berg wrote:
>=20
> > No, it came out after I pulled, I was on v2.6.23-6815-g0895e91. I'll
> > give it a try, but I don't think I can confirm it works before tomorrow=
.
> > I see the build failure got fixed with commit
> > 5edadbd0ae35d2daabaf6b44f2c58d67d4021ed2 too.
>=20
> Wait, now I lost track. This patch is identical to that commit 5edad...,
> what I was thinking of was the oops I got.

Nah, never mind. Apologies to everybody. I'm confused, Jens says the
oops was fixed. I'll verify that.

johannes

--=-msR8zjzPxlg/u43XWxnN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARx8PYaVg1VMiehFYAQLLRhAAxEjf9rZfropSb/lUcnVBvoGZat01sMdE
Mrf6IkZsROuqom534camdYEWiwnFL+4mQwRs9cq4NVMlmR+UnBTs3OiRxUNpQiTl
IfC2umt5WyjCxMEi/zzR5UJxCi0nVDU75vfPW3jApFl2v7a08AECss0GiEM7hLw+
/zZqnvzRlCfI8pnsS/GmVOC2jWMN+0iep10eViBoz/BwFhYpx1L/13YUXMWQ+kSb
KNuwnpUwbpH9oioccPoL/gQa+HvcYZ+aaMqHzLh6pe9il+OLcKueCvG/LEUK8Cz4
baT7b071RtcMyp8fhFfPNE2gM4/YarJZzGM28AGArMhOMzZw+1wMHQdYMYJK/Hy/
O0KH1rzyN6e9kyJZB+goSFsYt46J+yhYgR3XQd70W0RUFr/KT/7+0QMK1KJE83NE
Pv2shVGAGCDwCpPDae1+zdQtql8US13/DHqpTdxijBdJPLp5yn2pplZdyaFPCnB3
4R7/zJj/YtqK+WUEWrWA4CSIBEbjAjhPIq3VwWxC9uw2IRSDdaA5hj6zGbBTPiZw
f1QeFqZG5wyBJVMLjZHTcK9QMaa8kKUngg0N52L7vJdR+FZv6QY8Oy5cgAeJyjz/
oPeUoKIdNL/cygYQd0JZGSeA5RRX6LwCF6khuH8mLqHGvhQK+XO0yNrAeMtL7PpC
75XtXF8sVYI=
=s+R3
-----END PGP SIGNATURE-----

--=-msR8zjzPxlg/u43XWxnN--
