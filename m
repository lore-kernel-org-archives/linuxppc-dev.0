Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136BEC3065C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jul 2024 23:49:48 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.a=rsa-sha256 header.s=201702 header.b=rvv9Bb6N;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WDKQL2Ln2z3c05
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jul 2024 09:49:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.a=rsa-sha256 header.s=201702 header.b=rvv9Bb6N;
	dkim-atps=neutral
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WDKPR3TWqz2ysd
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2024 09:48:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1719964139;
	bh=BlKZZNRlG1lecOtIMyzas1Jhys8I6pZW+xDbV4ff3ls=;
	h=Date:From:To:Cc:Subject:From;
	b=rvv9Bb6NOLbTUAW9xNx7qWEJiFt5iVcg+6gk1Cgq8jpGE/OaD/wExANVbrFdU2McA
	 1NYC+S3RHGvSfEvK98JQ5cQDKEnYeSRibqzRqB++52Aw2FFT5DD5QMg6CRVB+tqI7I
	 acgvhOIx4GGQk2UlwBVxBFCjBLeouXUBXoP3fH7mTYxuAm+TUH5jUPLxubT8vMWeSM
	 om4cG6ewQZstz/AeFuIW1ehZxqMx0mKjcR7lgYWO4G/6W9DJLsj0Tb26JjximXu1TU
	 nmSvSInsvMJnJ8DO3JbGeccB/9SOQM52Rg4KMXj8h+n3I4H3f4dTJMQIEJgxq0ZjRc
	 9sLPIZrP7oPHA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WDKPQ17y1z4wc1;
	Wed,  3 Jul 2024 09:48:58 +1000 (AEST)
Date: Wed, 3 Jul 2024 09:48:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: linux-next: manual merge of the powerpc tree with the mm tree
Message-ID: <20240703094857.3f489d4f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Yb+1W8wPbSKE3q_hXMTkwWK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/Yb+1W8wPbSKE3q_hXMTkwWK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  arch/powerpc/mm/nohash/Makefile

between commit:

  9e49846e4d65 ("powerpc/64e: split out nohash Book3E 64-bit code")

from the mm-unstable branch of the mm tree and commit:

  732b32daef80 ("powerpc: Remove core support for 40x")

from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/mm/nohash/Makefile
index 90e846f0c46c,86d0fe434824..000000000000
--- a/arch/powerpc/mm/nohash/Makefile
+++ b/arch/powerpc/mm/nohash/Makefile
@@@ -1,8 -1,7 +1,7 @@@
  # SPDX-License-Identifier: GPL-2.0
 =20
  obj-y				+=3D mmu_context.o tlb.o tlb_low.o kup.o
 -obj-$(CONFIG_PPC_BOOK3E_64)  	+=3D tlb_low_64e.o book3e_pgtable.o
 +obj-$(CONFIG_PPC_BOOK3E_64)  	+=3D tlb_64e.o tlb_low_64e.o book3e_pgtable=
.o
- obj-$(CONFIG_40x)		+=3D 40x.o
  obj-$(CONFIG_44x)		+=3D 44x.o
  obj-$(CONFIG_PPC_8xx)		+=3D 8xx.o
  obj-$(CONFIG_PPC_E500)		+=3D e500.o

--Sig_/Yb+1W8wPbSKE3q_hXMTkwWK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaEkekACgkQAVBC80lX
0Gzo1AgAkHx90xFZGC5boB/VkLI3RDmEjh54mHf0fdAF7BT96duaaPmrd/k2Yg+I
w4U5LiA9CIonPaYfGawwBgBjw+hM4vJ9qK4+iYpOiKutjowsPYODr1wYpOl/P7Xr
Suw4Ul6s8qY8/UsKLNpm0AYS0BLJRUidMRIATg07G0f73DUwMpmKIhxfK4OJwod0
8SfWzDQeb23yESIAH2OQ0BXC5vKU6UMNPcS3YNOCw6Ni9zhScsbao6vl+FNjl2X9
6pNVaSwKmxuzM/4WB2W1/l4D6J/JH/+9417huAyOi1Hk3Gxw/QA6qjMI0/TDKJgz
IjbNVDw5gyx2ADO4PCf3tYheaXHYYw==
=a+Ix
-----END PGP SIGNATURE-----

--Sig_/Yb+1W8wPbSKE3q_hXMTkwWK--
