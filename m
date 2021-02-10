Return-Path: <SRS0=uerg=HM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F2EC433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 14:42:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03BA364E26
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 14:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BA364E26
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DbMtW4mqpzDsgc
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 01:42:43 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DbKYX2bF0zDslj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2021 23:57:52 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DbKYR2vL9z9sWl; Wed, 10 Feb 2021 23:57:46 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, Sandipan Das <sandipan@linux.ibm.com>
In-Reply-To: <20210202150050.75335-1-sandipan@linux.ibm.com>
References: <20210202150050.75335-1-sandipan@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pkeys: Remove unused code
Message-Id: <161296172018.3178259.2790527364997214851.b4-ty@ellerman.id.au>
Date: Wed, 10 Feb 2021 23:57:46 +1100 (AEDT)
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
Cc: linuxram@us.ibm.com, linuxppc-dev@lists.ozlabs.org,
 aneesh.kumar@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2 Feb 2021 20:30:50 +0530, Sandipan Das wrote:
> This removes arch_supports_pkeys(), arch_usable_pkeys() and
> thread_pkey_regs_*() which are remnants from the following:
> 
> commit 06bb53b33804 ("powerpc: store and restore the pkey state across context switches")
> commit 2cd4bd192ee9 ("powerpc/pkeys: Fix handling of pkey state across fork()")
> commit cf43d3b26452 ("powerpc: Enable pkey subsystem")
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pkeys: Remove unused code
      https://git.kernel.org/powerpc/c/266d8f7586533a4c473ccb392204e32df99b72b5

cheers
