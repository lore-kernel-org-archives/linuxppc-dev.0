Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 15F02DE2A4
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 19:12:38 +1000 (EST)
Date: Mon, 21 Apr 2008 19:12:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>
Subject: linux-next: x86-latest/powerpc-next merge conflict
Message-Id: <20080421191231.41a34aef.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__21_Apr_2008_19_12_31_+1000_N0IM+N6ulr0A.GfT"
Cc: Heukelum <heukelum@fastmail.fm>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Alexander
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__21_Apr_2008_19_12_31_+1000_N0IM+N6ulr0A.GfT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the x86-latest tree got a conflict in
include/asm-powerpc/bitops.h between commit
cd008c0f03f3d451e5fbd108b8e74079d402be64 ("generic: implement __fls on
all 64-bit archs") from the x86-latest tree and commit
9f264be6101c42cb9e471c58322fb83a5cde1461 ("[POWERPC] Optimize fls64() on
64-bit processors") from the powerpc-next tree.  The fixup was not quite
trivial and is worth a look to see if I got it right.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__21_Apr_2008_19_12_31_+1000_N0IM+N6ulr0A.GfT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIDFqETgG2atn1QN8RAgEhAJ9xDDjd67pGYdUj2u4y0DwwUA8sSgCfRu5J
V/Y8TUGKEU1P7yZfSaliNhE=
=tz5i
-----END PGP SIGNATURE-----

--Signature=_Mon__21_Apr_2008_19_12_31_+1000_N0IM+N6ulr0A.GfT--
