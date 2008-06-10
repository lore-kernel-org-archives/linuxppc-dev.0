Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7A21CDDEFE
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 16:54:49 +1000 (EST)
Date: Tue, 10 Jun 2008 16:54:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Subject: linux-next: powerpc build failure
Message-Id: <20080610165441.a7c5ddd0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__10_Jun_2008_16_54_41_+1000_V5Z82GWEpdfu9ov4"
Cc: linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__10_Jun_2008_16_54_41_+1000_V5Z82GWEpdfu9ov4
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Today's linux-next tree build (powerpc ppc64_defconfig) failed like this:

  UPD     include/linux/compile.h
arch/powerpc/mm/built-in.o: In function `ht64_insert_pte':
hash_native_64.c:(.text+0x4756): undefined reference to `_PAGE_HPTE_SUB0'

I have reverted commit 2d9a973b0fee245af43b73412a08e88bc955644d
("powerpc: Free a PTE bit on ppc64 with 64K pages") for now.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__10_Jun_2008_16_54_41_+1000_V5Z82GWEpdfu9ov4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhOJTEACgkQTgG2atn1QN8NQwCfe78D56mVqdVkMA+fxjJURt8/
e+oAoIh2RH4NNJHcbCbkpE+zN+lBVB3k
=8f7I
-----END PGP SIGNATURE-----

--Signature=_Tue__10_Jun_2008_16_54_41_+1000_V5Z82GWEpdfu9ov4--
