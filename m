Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 77C37DE11D
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 17:34:51 +1000 (EST)
Date: Mon, 21 Apr 2008 17:34:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Avi Kivity <avi@qumranet.com>, Paul Mackerras <paulus@samba.org>
Subject: linux-next: kvm/powerpc merge conflict
Message-Id: <20080421173441.f3a9bb8e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__21_Apr_2008_17_34_41_+1000_t=T39cNSw0mPe780"
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__21_Apr_2008_17_34_41_+1000_t=T39cNSw0mPe780
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc got a conflict in
include/asm-powerpc/mmu-44x.h between commit
dbc0b98a9feb95a65275d9937d815a3bd4300103 ("ppc: Export tlb_44x_hwater for
KVM") in the kvm tree and commit d04ceb3fc294ea2c4f538a04343f3a473953a3b0
("[POWERPC] Move phys_addr_t definition into asm/types.h") in the powerpc
tree.  The fixup was trivial.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__21_Apr_2008_17_34_41_+1000_t=T39cNSw0mPe780
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIDEOWTgG2atn1QN8RAphRAKCTMU8GmhjhWxfU+ZL5vlVudztypQCfa+od
ZKsPEjTXxWlLXc8OU8umytk=
=tlzD
-----END PGP SIGNATURE-----

--Signature=_Mon__21_Apr_2008_17_34_41_+1000_t=T39cNSw0mPe780--
