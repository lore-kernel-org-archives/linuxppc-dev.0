Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 78758DDE04
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 18:40:30 +1100 (EST)
Date: Wed, 5 Mar 2008 18:40:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Subject: linux-next: powerpc tree merge conflict
Message-Id: <20080305184016.ee7e04fc.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__5_Mar_2008_18_40_16_+1100_GXjA=HYzSSYnmLdd"
Cc: linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__5_Mar_2008_18_40_16_+1100_GXjA=HYzSSYnmLdd
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

There was a small conflict with Linus' tree (in arch/powerpc/Kconfig) in
merging the powerpc next branch into today's linux-next tree.  Commit
d9b2b2a277219d4812311d995054ce4f95067725 ('[LIB]: Make PowerPC LMB code
generic so sparc64 can use it too') conflicted with
9edddaa200df18e08fe0cf21036e8ae467b1363c ('Kprobes: indicate kretprobe
support in Kconfig'). I fixed it up.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__5_Mar_2008_18_40_16_+1100_GXjA=HYzSSYnmLdd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHzk5sTgG2atn1QN8RAszcAJ9ta6jVu+adkK/Tdy1isn3nvf9YugCggghg
svO0K/JtZ1becqJMFBhO8H4=
=SApi
-----END PGP SIGNATURE-----

--Signature=_Wed__5_Mar_2008_18_40_16_+1100_GXjA=HYzSSYnmLdd--
