Return-Path: <SRS0=B9f/=I5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458FDC433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 01:10:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CBD619C5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 01:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CBD619C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F97Xf4r3Rz3c8G
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 12:10:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F97XJ157nz2y69
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Mar 2021 12:10:07 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4F97XH1V8Wz9sWQ; Wed, 31 Mar 2021 12:10:07 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20210318034829.72255-1-aneesh.kumar@linux.ibm.com>
References: <20210318034829.72255-1-aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] powerpc/book3s64/kuap: Move Kconfig varriables to
 BOOK3S_64
Message-Id: <161715297925.226945.336440247830122579.b4-ty@ellerman.id.au>
Date: Wed, 31 Mar 2021 12:09:39 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 18 Mar 2021 09:18:29 +0530, Aneesh Kumar K.V wrote:
> With below two commits:
> commit c91435d95c49 ("powerpc/book3s64/hash/kuep: Enable KUEP on hash")
> commit b2ff33a10c8b ("powerpc/book3s64/hash/kuap: Enable kuap on hash")
> the kernel now supports kuap/kuep with hash translation. Hence select the
> Kconfig even when radix is disabled.

Applied to powerpc/next.

[1/1] powerpc/book3s64/kuap: Move Kconfig varriables to BOOK3S_64
      https://git.kernel.org/powerpc/c/8b8adeb3007f67076141f547f0b2f62b299a383c

cheers
