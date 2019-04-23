Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D3CC10F14
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 09:15:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00B0206A3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 09:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Cpq9vQUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00B0206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pHqP4c3yzDqN1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 19:15:45 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pHnG3BczzDqDq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 19:13:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="Cpq9vQUJ"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44pHnD6W6bz9s55;
 Tue, 23 Apr 2019 19:13:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1556010834;
 bh=9mktwgfUyKob7wDM6/BjkbWuw5ndBw6/47jjIsxHd/o=;
 h=Date:From:To:Cc:Subject:From;
 b=Cpq9vQUJ9Gq6QbA5UX3fL5ooPnW25uPGdTmJU4KiYXHEAy4rsAqkv0GkrFhq+jXdo
 8SgRc2ldPR3T2k7qPeQJRpdicHSC5U2XSLFChPTNVDVvSmGmhuO3gAYYQ9a64kiegB
 gjr2N5XpHAeWKRH0ZuxDgYHwrxpUsJeGrV1jSckxgKQuASLxx9sA1/a4HAlRRye+Ky
 zhht5ClltrXoicdVWpi0YgiB1GmXpoG2C8LqQYBgwgBUCLHqizVOLW83nmix69U0kx
 aUhvUje9qn7L3DFTRM3JYUEi0/YItmSGUcxdBvNzD7N4+n/uHDHl+C+dCPNZJlRKN/
 x2gQiSE5GXJCw==
Date: Tue, 23 Apr 2019 19:13:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman
 <mpe@ellerman.id.au>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: manual merge of the akpm-current tree with the
 powerpc-fixes and powerpc trees
Message-ID: <20190423191351.5824b525@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/R84=d46Rj=zQUc3yYyHaa/U"; protocol="application/pgp-signature"
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Alexandre Ghiti <alex@ghiti.fr>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/R84=d46Rj=zQUc3yYyHaa/U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/powerpc/platforms/Kconfig.cputype

between commit:

  8adddf349fda ("powerpc/mm/radix: Make Radix require HUGETLB_PAGE")

from the powerpc-fixes tree and commits:

  1bb2bae2e6c7 ("powerpc/mm/radix: Use KUEP API for Radix MMU")
  890274c2dc4c ("powerpc/64s: Implement KUAP for Radix MMU")

from the powerpc tree and commits:

  80d5ae3cf456 ("mm: simplify MEMORY_ISOLATION && COMPACTION || CMA into CO=
NTIG_ALLOC")
  3653abf7cded ("hugetlb: allow to free gigantic pages regardless of the co=
nfiguration")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/platforms/Kconfig.cputype
index 00b2bb536c74,03ca91439473..000000000000
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@@ -328,10 -324,8 +328,10 @@@ config ARCH_ENABLE_SPLIT_PMD_PTLOC
 =20
  config PPC_RADIX_MMU
  	bool "Radix MMU Support"
 -	depends on PPC_BOOK3S_64
 +	depends on PPC_BOOK3S_64 && HUGETLB_PAGE
- 	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
+ 	select ARCH_HAS_GIGANTIC_PAGE
 +	select PPC_HAVE_KUEP
 +	select PPC_HAVE_KUAP
  	default y
  	help
  	  Enable support for the Power ISA 3.0 Radix style MMU. Currently this

--Sig_/R84=d46Rj=zQUc3yYyHaa/U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly+108ACgkQAVBC80lX
0GywTAf/W97IPQ/tIK8fZmjGIZ/gLRhR2yCYS21XLN6mGVVZ5zCRWP9h7HzSsD0n
jyR5gumaGvY/wx/LjlLE0r2+Z5hdgL5Z26Rh7UOd7HiejTS+E8brZajbytKuJPVV
VD7nsgA8IEMWL3OhSHDakJS50p262vWrQiApyqMQfxe5ev6zRe6+gmwx8FB/HBhd
LwzvBew1rIYai+jV/L/bLABs4d9J4/+oMsxnBhk7e/h+Na8jIzi0hln8JjzPvxxV
IHbJgOmQWgQK9BQUkvwEgTYLMGmHt27xiXg+Jx3cTl7mf6p4jP/TCqWMitr0whT+
MkgbzmSMjhh6RG1dlzXqnoetBvo6AA==
=uWCC
-----END PGP SIGNATURE-----

--Sig_/R84=d46Rj=zQUc3yYyHaa/U--
