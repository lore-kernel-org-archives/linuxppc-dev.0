Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CF6EF47506
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jan 2009 12:53:36 +1100 (EST)
Date: Fri, 9 Jan 2009 12:53:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: linux-next: manual merge of the rr tree
Message-Id: <20090109125327.351b7f65.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__9_Jan_2009_12_53_27_+1100_z8faOm_TrLDrb4xG"
Cc: Benjamin, linux-next@vger.kernel.org, Nathan Lynch <ntl@pobox.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__9_Jan_2009_12_53_27_+1100_z8faOm_TrLDrb4xG
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rusty,

Today's linux-next merge of the rr tree got a conflict in
arch/powerpc/kernel/sysfs.c between commit
93197a36a9c16a85fb24cf5a8639f7bf9af838a3 ("powerpc: Rewrite sysfs
processor cache info code") from Linus' tree and commit
013ab448cec493262080ecc47b13e0adbcfaeccd ("cpualloc:rename-per_cpu-vars")
from the rr tree.

The former moved the code modified by the latter into another file and
rewrote it.  This is part of the code churn that should not be happening
in linux-next during the merge window.  :-(

I have dropped the rr tree for today, sorry.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__9_Jan_2009_12_53_27_+1100_z8faOm_TrLDrb4xG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklmrhcACgkQjjKRsyhoI8xd/wCfXMkEM6wUxs7TfPBKxAmJAqch
GvkAn2GIQcKJ5oPO1n3kiHOSuVAEUa/T
=AW77
-----END PGP SIGNATURE-----

--Signature=_Fri__9_Jan_2009_12_53_27_+1100_z8faOm_TrLDrb4xG--
