Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0E008DDF32
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 17:54:47 +1100 (EST)
Date: Tue, 1 Apr 2008 17:54:42 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Make #include <sysdev/foo.h> work for 64-bit powerpc
Message-Id: <20080401175442.bf0d0c34.sfr@canb.auug.org.au>
In-Reply-To: <be85035fa2cb015a8020e63b40c6d5375aaff866.1207031915.git.michael@ellerman.id.au>
References: <be85035fa2cb015a8020e63b40c6d5375aaff866.1207031915.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__1_Apr_2008_17_54_42_+1100_.LGvYN91SQ_Nr9Og"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__1_Apr_2008_17_54_42_+1100_.LGvYN91SQ_Nr9Og
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Tue,  1 Apr 2008 17:39:11 +1100 (EST) Michael Ellerman <michael@ellerman=
.id.au> wrote:
>
> We currently have inconsistent settings between 32 & 64-bit which means
> 32-bit code can #include <sysdev/foo.h> but 64-bit code can't.

Kumar sent a very similar (if not identical) patch earlier today.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__1_Apr_2008_17_54_42_+1100_.LGvYN91SQ_Nr9Og
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH8dw2TgG2atn1QN8RAraoAJ93846m+/AN4J3/SpZJY+UNTox5ugCeOHhR
phuIVf2OG4MGoEoUouYLysM=
=CjwH
-----END PGP SIGNATURE-----

--Signature=_Tue__1_Apr_2008_17_54_42_+1100_.LGvYN91SQ_Nr9Og--
