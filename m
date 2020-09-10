Return-Path: <SRS0=I40Z=CT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7199FC433E2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 13:04:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D23207FB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 13:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D23207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BnJxd1zn8zDqmb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 23:04:21 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BnJlV6j0fzDqdG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2020 22:55:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BnJlV2s56z9sTt; Thu, 10 Sep 2020 22:55:34 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linux-nvdimm@lists.01.org, linuxppc-dev@lists.ozlabs.org,
 Vaibhav Jain <vaibhav@linux.ibm.com>
In-Reply-To: <20200907110540.21349-1-vaibhav@linux.ibm.com>
References: <20200907110540.21349-1-vaibhav@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/papr_scm: Limit the readability of
 'perf_stats' sysfs attribute
Message-Id: <159974250773.1017939.2467058218314439278.b4-ty@ellerman.id.au>
Date: Thu, 10 Sep 2020 22:55:34 +1000 (AEST)
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 7 Sep 2020 16:35:40 +0530, Vaibhav Jain wrote:
> The newly introduced 'perf_stats' attribute uses the default access
> mode of 0444 letting non-root users access performance stats of an
> nvdimm and potentially force the kernel into issuing large number of
> expensive HCALLs. Since the information exposed by this attribute
> cannot be cached hence its better to ward of access to this attribute
> from users who don't need to access these performance statistics.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/papr_scm: Limit the readability of 'perf_stats' sysfs attribute
      https://git.kernel.org/powerpc/c/0460534b532e5518c657c7d6492b9337d975eaa3

cheers
