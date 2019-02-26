Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EC5C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 07:41:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 396F4213A2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 07:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kg/VQtkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396F4213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447rMv5602zDqL4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 18:40:59 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447rL101kKzDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 18:39:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="kg/VQtkS"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 447rKz4kWGz9s2R;
 Tue, 26 Feb 2019 18:39:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1551166760;
 bh=cSbq9b0Op6hcgZNyN11DLYplgz7Emv//TwxEcCReEQA=;
 h=Date:From:To:Cc:Subject:From;
 b=kg/VQtkSRz1qyomgZNvNvosJtLeXaPOh9/6pivXnh8bGfTWLHMQLG08YZjEhsYj/N
 0enXBDOE0+Jl6aAikPkHogDVIZYSvL4PVgLeSvSb66g8rYrTqs8Q1aInxqDT0cYVBU
 jdSCQcOy5X883spZzwa3/f5OickhfDcZTqTDNd5minvTt7ChG7fXv0kqKNHg/cjIjw
 SN0amtRwQ7C0yA8NTEsd0sUxWnSO4G2iLWCJdodJkE4airC4T1xww6PXkN4y8TueR6
 s03XYCMxxXEDqAKT4MUA2DWTDdvx9llTeieGVR47JfJPPilhChIUXsomhmjnvLtip1
 yF21X5YjukoxQ==
Date: Tue, 26 Feb 2019 18:39:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman
 <mpe@ellerman.id.au>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the akpm tree
Message-ID: <20190226183915.053f5993@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KJRtsuK_EApQLvkyUl_mJq+"; protocol="application/pgp-signature"
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

--Sig_/KJRtsuK_EApQLvkyUl_mJq+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the akpm tree, today's linux-next build (powerpc
allnoconfig) failed like this:

/home/sfr/next/next/arch/powerpc/kernel/setup_32.c:176:21: error: redefinit=
ion of 'alloc_stack'
 static void *__init alloc_stack(void)
                     ^~~~~~~~~~~
/home/sfr/next/next/arch/powerpc/kernel/setup_32.c:165:21: note: previous d=
efinition of 'alloc_stack' was here
 static void *__init alloc_stack(void)
                     ^~~~~~~~~~~

Caused by patch

  "powerpc: use memblock functions returning virtual address"

from the akpm tree interacting with commit

  c8e409a33cf8 ("powerpc/irq: use memblock functions returning virtual addr=
ess")

from the powerpc tree.

Both patches added the alloc_stack() function and git resolved it by
adding both. :-(  I have added a patch to remove one of them.



--=20
Cheers,
Stephen Rothwell

--Sig_/KJRtsuK_EApQLvkyUl_mJq+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx07SMACgkQAVBC80lX
0Gy5ZQf/dE22xTpFLT11zbHqniL0YLGU3IuAEiZRvRajlFT2dQ7NXFGUawi4u7X5
VVvFGqhzt3Lwg0K4lXKar27+XTs3I0VZ4kFWUPvM3tIN8PZz+qZ2JUDR5eqilSnd
fqrKNoL+wUtqeShtSmstO/L7RVrHrLJv6xtUOqk42XlONYnjh61GpOesT8M8/5W1
Tfp/FdYwW9pn/CHi49IaoZ+sZzs3xQ/XVb6YsoN4tLAWdGU7JaFCRqH3JDxG8QZe
LOP8B52BqyJeQop4X997Cq5hJ1wKhQbH7c3WSTO7JJaH8Qvgwxk4CwJucxMQySjj
vyLHP7U0PXGZRvPhvaRUfpW5CFbKXw==
=IzLU
-----END PGP SIGNATURE-----

--Sig_/KJRtsuK_EApQLvkyUl_mJq+--
