Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B98FFDDF77
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 13:27:09 +1100 (EST)
Date: Tue, 14 Oct 2008 12:02:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: linux-next: manual merge of the powerpc tree
Message-Id: <20081014120259.e902e407.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__14_Oct_2008_12_02_59_+1100_L4Silmvga6v/2dGd"
Cc: Victor Gallardo <vgallardo@amcc.com>, linux-next@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__14_Oct_2008_12_02_59_+1100_L4Silmvga6v/2dGd
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul, Ben,

Today's linux-next merge of the powerpc tree got a conflict in
arch/powerpc/include/asm/dcr-regs.h between commit
6fbc779c03591ee536fef9efb7d7e20f281d0b5c ("ibm_newemac: Fix EMAC soft
reset on 460EX/GT") from Linus' tree and commit
fbcc4bacee30cad4e4a13d05492a9ed0c9c3e8c7 ("ibm_newemac: MAL support for
PowerPC 405EZ") from the powerpc tree.

Just overlapping additions.  I fixed it up by taking both additions.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/


--Signature=_Tue__14_Oct_2008_12_02_59_+1100_L4Silmvga6v/2dGd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjz78MACgkQjjKRsyhoI8xJGwCeOYreBrHis+n0v4PrEGLFKU+B
0FgAoL6zAVkhvU37q5n7KYIDVcLgR1lN
=fnm2
-----END PGP SIGNATURE-----

--Signature=_Tue__14_Oct_2008_12_02_59_+1100_L4Silmvga6v/2dGd--
