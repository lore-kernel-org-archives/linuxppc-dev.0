Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 494C8DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 12:10:33 +1100 (EST)
Date: Tue, 6 Nov 2007 12:10:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH] 4xx; Replace #includes of asm/of_platform.h with
	linux/of_platform.h.
Message-Id: <20071106121027.d7d34f0b.sfr@canb.auug.org.au>
In-Reply-To: <20071105175341.6ee15106@vader.jdub.homelinux.org>
References: <1194299023.7158.59.camel@ld0161-tx32>
	<20071106094014.cd429711.sfr@canb.auug.org.au>
	<20071105175341.6ee15106@vader.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__6_Nov_2007_12_10_27_+1100_rhX2v82BOrucnCZ5"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__6_Nov_2007_12_10_27_+1100_rhX2v82BOrucnCZ5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Nov 2007 17:53:41 -0600 Josh Boyer <jwboyer@gmail.com> wrote:
>
> Yeah, this is fine with me too.  But why haven't we put a #warning in
> asm/of_platform.h and asm/prom.h?

Because thee are way to many places to be fixed yet.  And asm/prom.h needs =
to be explicitly included if you want to use the flattened device tree acce=
ssors.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__6_Nov_2007_12_10_27_+1100_rhX2v82BOrucnCZ5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHL78JTgG2atn1QN8RAvb5AJ9CYERrG65H1dQveYWNq2yyMAIi9gCgkkys
5hxZi2pNxJcS0AorisKbInE=
=B4QJ
-----END PGP SIGNATURE-----

--Signature=_Tue__6_Nov_2007_12_10_27_+1100_rhX2v82BOrucnCZ5--
