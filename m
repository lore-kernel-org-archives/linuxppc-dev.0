Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566F5C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 00:38:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36FF2077B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 00:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ThtgZoA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36FF2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445C9v4ZB5zDqTK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:38:11 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445C7s167GzDqSZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 11:36:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="ThtgZoA2"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 445C7r5dyCz9s71;
 Fri, 22 Feb 2019 11:36:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1550795784;
 bh=UXhuZxbMX5T2V0cRUs4QcqkxIgxqzrt81mAsw9J91H8=;
 h=Date:From:To:Cc:Subject:From;
 b=ThtgZoA2fBSeuio50+fgBs3v1LkYmrAikEt3fo11Ay2H4oeH2HJm8cCdVImZfI0PU
 IX/WkozY4zIrLMAl0IluP83KzkNi9Yqv0m2wRnVvv5YR78biOs/CRLgXse5wRf9qou
 u93DiNDcRfTttkPrcq92umQejpjr2+6BWij9SkMSGUIesLy36MC56e/3H7iq6dxrK3
 mQo8HQkakudm2a/jZU7PAQMs9cvSxUE6P6cnI1EeiN/0tt+ggBiaEK3cIvZdELOHJN
 1XHtMgN8YotL+Hp2YouNgkC1SvYvUT+mBUHwE7obla2NvQWOS2gNFh1fHmgCe1XnyZ
 Nl1iFkPuvRSYA==
Date: Fri, 22 Feb 2019 11:36:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: manual merge of the swiotlb tree with the powerpc tree
Message-ID: <20190222113624.2499244a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/D.FtqSliWbppHni_zlh.hJy"; protocol="application/pgp-signature"
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
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/D.FtqSliWbppHni_zlh.hJy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the swiotlb tree got a conflict in:

  kernel/dma/swiotlb.c

between commit:

  feee96440c9c ("swiotlb: remove swiotlb_dma_supported")

from the powerpc tree and commit:

  71602fe6d4e9 ("swiotlb: add debugfs to track swiotlb buffer usage")

from the swiotlb tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/dma/swiotlb.c
index 6d0236bd3929,2b0c8fd9658e..000000000000
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@@ -650,3 -665,48 +665,36 @@@ bool swiotlb_map(struct device *dev, ph
 =20
  	return true;
  }
+=20
 -/*
 - * Return whether the given device DMA address mask can be supported
 - * properly.  For example, if your device can only drive the low 24-bits
 - * during bus mastering, then you would pass 0x00ffffff as the mask to
 - * this function.
 - */
 -int
 -swiotlb_dma_supported(struct device *hwdev, u64 mask)
 -{
 -	return __phys_to_dma(hwdev, io_tlb_end - 1) <=3D mask;
 -}
 -
+ #ifdef CONFIG_DEBUG_FS
+=20
+ static int __init swiotlb_create_debugfs(void)
+ {
+ 	struct dentry *d_swiotlb_usage;
+ 	struct dentry *ent;
+=20
+ 	d_swiotlb_usage =3D debugfs_create_dir("swiotlb", NULL);
+=20
+ 	if (!d_swiotlb_usage)
+ 		return -ENOMEM;
+=20
+ 	ent =3D debugfs_create_ulong("io_tlb_nslabs", 0400,
+ 				   d_swiotlb_usage, &io_tlb_nslabs);
+ 	if (!ent)
+ 		goto fail;
+=20
+ 	ent =3D debugfs_create_ulong("io_tlb_used", 0400,
+ 				   d_swiotlb_usage, &io_tlb_used);
+ 	if (!ent)
+ 		goto fail;
+=20
+ 	return 0;
+=20
+ fail:
+ 	debugfs_remove_recursive(d_swiotlb_usage);
+ 	return -ENOMEM;
+ }
+=20
+ late_initcall(swiotlb_create_debugfs);
+=20
+ #endif

--Sig_/D.FtqSliWbppHni_zlh.hJy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxvRAgACgkQAVBC80lX
0GzffggApJO0coXDf/duNk+3uQ07oCeG2X713C7Y+UjuoHMY+lbNAjKG0A7O6jF/
r1PuAyn5j1gN5eoh7t44iJQuUsG9MbKdhKbpPW5dJXCoELXcReBVOuZMOzcuHXSy
tm3ExhUBNLxZNh1bshE3aPJdkSQc68OLMn8TWVCyT060farTQZt5TVqz57sa9KSf
I8gXKNHmdUIRvlaSPUNURbCNdyUa0nUJykCSYAOb2DnYVn7V4FEFawNNc+SMzESI
ixb/42IOBbVXw+ELEIY+x8Zx7GrRbCJcb50WSS5Jwa0qRJOScMVNGMRBb+8DgVHo
DDDLxQJfxXoDo8i+CF9I1HZKH5wqrA==
=KU1q
-----END PGP SIGNATURE-----

--Sig_/D.FtqSliWbppHni_zlh.hJy--
