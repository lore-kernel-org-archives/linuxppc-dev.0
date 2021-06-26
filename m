Return-Path: <SRS0=IFvE=LU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FBFC49EA5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jun 2021 10:41:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C6D36162A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jun 2021 10:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6D36162A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GBr5T3ncyz3djq
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jun 2021 20:41:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GBr2S3P3qz3c0t
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jun 2021 20:38:56 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4GBr2R2R21z9t10; Sat, 26 Jun 2021 20:38:55 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, npiggin@gmail.com,
 rzinsly@linux.ibm.com, Haren Myneni <haren@linux.ibm.com>
In-Reply-To: <ed908341b1eb7ca0183c028a4ed4a0cf48bfe0f6.camel@linux.ibm.com>
References: <ed908341b1eb7ca0183c028a4ed4a0cf48bfe0f6.camel@linux.ibm.com>
Subject: Re: [PATCH] selftests/powerpc: Use req_max_processed_len from sysfs
 NX capabilities
Message-Id: <162470384443.3589875.7632472976704596416.b4-ty@ellerman.id.au>
Date: Sat, 26 Jun 2021 20:37:24 +1000
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

On Tue, 22 Jun 2021 22:17:46 -0700, Haren Myneni wrote:
> On PowerVM, the hypervisor defines the maximum buffer length for
> each NX request and the kernel exported this value via sysfs.
> 
> This patch reads this value if the sysfs entry is available and
> is used to limit the request length.

Applied to powerpc/next.

[1/1] selftests/powerpc: Use req_max_processed_len from sysfs NX capabilities
      https://git.kernel.org/powerpc/c/c6c27e3d84648e6188fba314ae21a005e60bdcd4

cheers
