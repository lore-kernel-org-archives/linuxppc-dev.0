Return-Path: <SRS0=OxMP=4X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FCFC3F2D7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2020 05:31:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4F42072D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2020 05:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MB7Nafcy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4F42072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Ybnv3pj4zDr0d
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2020 16:31:31 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Yblm0SydzDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2020 16:29:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.a=rsa-sha256 header.s=201702 header.b=MB7Nafcy; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48Ybll3vDpz9sPg;
 Fri,  6 Mar 2020 16:29:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1583472579;
 bh=t7kO+23O4AQyWMQiGP82lyAOnnJwgWc5WAO5yzIARVM=;
 h=Date:From:To:Cc:Subject:From;
 b=MB7NafcyEAvifyEqL4xotZBIPNbRnJQmwFUwYa7iYH8hdKnUCjdW9duKcu+KiDAJO
 c/5FDp7bZHGTuNwv/1AN0KyWusqj/rnzl3GlcsJ3cGZf+ZKRHSAjxIYXxy7rJn3xhs
 xuZbXEksJaRLU/cZzt213IMcRsP2gS7RNgZ91Pgz4EmSlDy5nCI8/2nqYZAlGJmtli
 QKkdi9BgYQ5qmHUMrIX0bCrNp6ZtLJlqWPIbcqJK0R5fa20q8MqE+kkW5p//CXK83b
 HMmEvbflS8HPi1M8ZCRAbFhTnDlcaHE+sLDZu5lhGkL5ZoD71uiNI4QdXXTC0IjwV8
 5ljuOD1ENnbBQ==
Date: Fri, 6 Mar 2020 16:29:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman
 <mpe@ellerman.id.au>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: manual merge of the akpm tree with the powerpc tree
Message-ID: <20200306162937.082cd994@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AxSgnHjYYrwYT+IA1LV6HOX";
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/AxSgnHjYYrwYT+IA1LV6HOX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm tree got a conflict in:

  arch/powerpc/mm/pgtable_32.c

between commit:

  2efc7c085f05 ("powerpc/32: drop get_pteptr()")

from the powerpc tree and patch:

  "powerpc/32: drop get_pteptr()"

from the akpm tree.

I fixed it up (I just dropped the latter version) and can carry the fix
as necessary. This is now fixed as far as linux-next is concerned, but
any non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/AxSgnHjYYrwYT+IA1LV6HOX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5h38EACgkQAVBC80lX
0GwWVgf/b9cMicIX4DCt/qrkOHGgvNBu+8TbB7gAfYs65qisVKTSU7grIUTkqxKS
xpUBgKhBUiAtC/JkLkzm2VAaX/WyjEJ04u/9ebeqWZFZVAuvfbqu1sG+CYm22lKo
g2D1xC+8oWMZ16Xap91ByEUiXQ+pG1zVgTFG9O+WDv9mFrFnl2ONsLGxrleqHD5o
lIPTwAn5r7PYCmXy/9jSKZE5Ry5FhB+t7mHt6xzd3mJKno2TiqmDIKIBj6EVeS+I
vjLdv+EVLFTOD4vMz1eXz2qg2+JiGnTMBzW5GjdXHZMIOVSBrykPK6zdagjP0mjf
yrciqH/VnA9EPN7RiUQ42pGU38yQOw==
=gutR
-----END PGP SIGNATURE-----

--Sig_/AxSgnHjYYrwYT+IA1LV6HOX--
