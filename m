Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF944C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 06:17:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 189BA2084D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 06:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MPUstfR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189BA2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447BZK283QzDqS3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 17:17:45 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447BXW3hk0zDqJq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 17:16:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="MPUstfR6"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 447BXW1rPNz9s9T;
 Mon, 25 Feb 2019 17:16:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1551075371;
 bh=d6YvrRxGMNl+B5EI30+P0g95/Xh9slISkkSASNo7jLc=;
 h=Date:From:To:Cc:Subject:From;
 b=MPUstfR68KS2LKILiGuXMJvSo5YxszH8I1GDmodtA6Z/uhZnQBAGNEee4LuoGAwBi
 PKzVnGcLTY2ApTvCElUQELRJbY9iBZmxQaYs4aC5JmZ2oPpqlxPLwb7o9OkW2vgcaf
 rbKnmS6YuqgTIeGBYaf7OIepkZQMZr+qFT8Ibdhh2H8bqWp+RegKVa7OYeJdPyVwfI
 rLXN9Gkkbw9nStFUCW1HDPI1Ew3nA8PDz7uyf5wEy7pKR3F+eMAJS0Mt9cF4k2TIaW
 S5LI/2wsd10V+vfBS0++RLovb1f77qpgT2Q+Vow4E2T+z9TEruaSj8SGzQeMKS72/s
 thF7o4PXxe+YQ==
Date: Mon, 25 Feb 2019 17:16:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman
 <mpe@ellerman.id.au>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: manual merge of the akpm-current tree with the powerpc
 tree
Message-ID: <20190225171609.07e1fc5c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wB4RF05PjbNRP=+Lz_T8n29"; protocol="application/pgp-signature"
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
 Mike Rapoport <rppt@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/wB4RF05PjbNRP=+Lz_T8n29
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/powerpc/kernel/setup_64.c

between commits:

  c8e409a33cf8 ("powerpc/irq: use memblock functions returning virtual addr=
ess")
  d608898abc74 ("powerpc: clean stack pointers naming")

from the powerpc tree and commit:

  82af77ee7503 ("powerpc: prefer memblock APIs returning virtual address")

from the akpm-current tree.

Commits 82af77ee7503 and c8e409a33cf8 overlap.

I fixed it up (I just used the powerpc tree version of this file) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/wB4RF05PjbNRP=+Lz_T8n29
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxziCkACgkQAVBC80lX
0GyuBgf9FaNXvPy+jebJC00E3VW/fZhuXIA/tmJo/VHT5juh3uXkJI9uOO2/m435
vHSCtdrKouDdZilm0nv2flDVU/h+Cat4Rh5icLYuB5+b1q1LPgIgNUhaMayKQDNs
XK6knx7bw+ZFhxzEUS6C24G0W80ywnXwNcAysrL/nE8ter4QfjSq5ejjfsS9rdw8
4M+9rv2KmRu7uvF4BkzGoj4nnwq6C6v1TqCHcudCdqMV4aYIkWPqOvaE8vHqUXis
ak0wiRwiBYAXO/mMV4TjRi0PA8RXjbq6ZJ6pIu90yzsyu/3xnmE1CYnnWaUF24tn
ZsW6cU2KMMVGgcQBlnhk2H0OxzkDtw==
=VCbT
-----END PGP SIGNATURE-----

--Sig_/wB4RF05PjbNRP=+Lz_T8n29--
