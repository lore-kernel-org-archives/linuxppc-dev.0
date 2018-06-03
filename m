Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zRNc6cNTzF1LJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 04:26:40 +1000 (AEST)
Date: Mon, 4 Jun 2018 04:26:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Michal Suchanek
 <msuchanek@suse.de>
Subject: linux-next: Signed-off-by missing for commit in the powerpc tree
Message-ID: <20180604042626.286a9469@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yrmiNp2hjm5+dqn=Kkh9I8M"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/yrmiNp2hjm5+dqn=Kkh9I8M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  cb3d6759a93c ("powerpc/64s: Enable barrier_nospec based on firmware setti=
ngs")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/yrmiNp2hjm5+dqn=Kkh9I8M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsUMtIACgkQAVBC80lX
0GyzXwf+Jvvf6GnqeerEBBIhSq1FMEoGmKS8zXjcNmQSKJHvdnzvJfWMRI/UDibq
Jo3OAt2ZbglG/iVjPUe/SyAtqLt7lIRFXSwO+5FcMCu99cwc1okCfFKA/RcSP3Jt
cj+nJpapb1hL3d6M/NWnPJ8QS+flf+jwgfZ9aoy2nNnWqH4GOP+AwCw/nNLVwS0o
YlG46rW54ulE5pft6x9nqqrE0WvyYxlZoU5hMjgEHgPaPQkMlKGrEI804Y91lvDV
FRbxUtwG62go26PIc0akzEXgGmVeOk6Q8n+PKUSI9uCPfB4zksC4d49U8x8SStHh
okjBK0+Ly2wuTG+L6O9RWU93jzIKHg==
=D5n3
-----END PGP SIGNATURE-----

--Sig_/yrmiNp2hjm5+dqn=Kkh9I8M--
