Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4D30CB711E
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 11:38:30 +1000 (EST)
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3F044DDD0B
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 11:38:30 +1000 (EST)
Date: Mon, 15 Jun 2009 11:38:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: michael@ellerman.id.au
Subject: Re: [OOPS] hugetlbfs tests with 2.6.30-rc8-git1
Message-Id: <20090615113823.d206a91d.sfr@canb.auug.org.au>
In-Reply-To: <1245027396.7705.23.camel@concordia>
References: <4A290195.3080807@in.ibm.com> <1244233062.31984.6.camel@pasglop>
	<4A34E12B.4010000@in.ibm.com> <1245027396.7705.23.camel@concordia>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__15_Jun_2009_11_38_23_+1000_XtUXnI/Vy70yjTDv"
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__15_Jun_2009_11_38_23_+1000_XtUXnI/Vy70yjTDv
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Mon, 15 Jun 2009 10:56:36 +1000 Michael Ellerman <michael@ellerman.id.au=
> wrote:
>
> Rather than "-git7" can you tell us the actual SHA, I don't know what
> git7 is.

$ cat tools/get_gitid=20
#!/bin/sh

wget -q -O - http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-$1=
.id

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__15_Jun_2009_11_38_23_+1000_XtUXnI/Vy70yjTDv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAko1pg8ACgkQjjKRsyhoI8woCgCgnGIDRKA0IBOuLsBNTFKA44Bt
oAcAn3r5bsSreKso3+NPIUzecHXaWHd5
=dfPp
-----END PGP SIGNATURE-----

--Signature=_Mon__15_Jun_2009_11_38_23_+1000_XtUXnI/Vy70yjTDv--
