Return-Path: <SRS0=zlPO=CS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF473C43461
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 13:33:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595B72087C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 13:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595B72087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BmjdH5qKJzDqWF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 23:33:07 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BmjVp1DyXzDqVl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2020 23:27:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4BmjVn57H5z9sTN; Wed,  9 Sep 2020 23:27:29 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BmjVn3DZvz9sTS; Wed,  9 Sep 2020 23:27:29 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Scott Cheloha <cheloha@linux.ibm.com>, linuxppc-dev@ozlabs.org
In-Reply-To: <20200727184605.2945095-1-cheloha@linux.ibm.com>
References: <20200727184605.2945095-1-cheloha@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] powerpc/perf: consolidate GPCI hcall structs into
 asm/hvcall.h
Message-Id: <159965716665.808686.4907664390218681095.b4-ty@ellerman.id.au>
Date: Wed,  9 Sep 2020 23:27:29 +1000 (AEST)
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
 Tyrel Datwylder <tyreld@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 27 Jul 2020 13:46:04 -0500, Scott Cheloha wrote:
> The H_GetPerformanceCounterInfo (GPCI) hypercall input/output structs are
> useful to modules outside of perf/, so move them into asm/hvcall.h to live
> alongside the other powerpc hypercall structs.
> 
> Leave the perf-specific GPCI stuff in perf/hv-gpci.h.

Applied to powerpc/next.

[1/2] powerpc/perf: consolidate GPCI hcall structs into asm/hvcall.h
      https://git.kernel.org/powerpc/c/59562b5c33d6ff3685509ed58b2ed3c5b5712704
[2/2] powerpc/pseries: new lparcfg key/value pair: partition_affinity_score
      https://git.kernel.org/powerpc/c/5d1bc776428f34941a6237afb9454061b5b5e1e1

cheers
