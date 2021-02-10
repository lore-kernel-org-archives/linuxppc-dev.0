Return-Path: <SRS0=uerg=HM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACCAC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 13:05:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A0064E87
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 13:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A0064E87
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DbKkX4TH8zDvbj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 00:05:40 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DbKY15fPxzDr2w
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2021 23:57:24 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DbKXx50djz9sW2; Wed, 10 Feb 2021 23:57:21 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: acme@kernel.org, jolsa@kernel.org,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, mpe@ellerman.id.au
In-Reply-To: <1612335337-1888-1-git-send-email-atrajeev@linux.vnet.ibm.com>
References: <1612335337-1888-1-git-send-email-atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] powerpc/perf: Add Performance Monitor Counters to
 extended regs
Message-Id: <161296172072.3178259.17210261647266833001.b4-ty@ellerman.id.au>
Date: Wed, 10 Feb 2021 23:57:21 +1100 (AEDT)
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
Cc: kjain@linux.ibm.com, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 3 Feb 2021 01:55:34 -0500, Athira Rajeev wrote:
> Patch set to add Performance Monitor Counter SPR's as
> part of extended regs in powerpc.
> 
> Patch 1/3 saves the PMC values in the perf interrupt
> handler as part of per-cpu array.
> Patch 2/3 adds PMC1 to PMC6 as part of the extended
> regs mask.
> Patch 3/3 includes perf tools side changes to add
> PMC1 to PMC6 to sample_reg_mask to use with -I? option.
> 
> [...]

Patches 1 & 2 applied to powerpc/next.

[1/3] powerpc/perf: Include PMCs as part of per-cpu cpuhw_events struct
      https://git.kernel.org/powerpc/c/91f3469a43fd1fb831649c2a2e684bf5ad4818b2
[2/3] powerpc/perf: Expose Performance Monitor Counter SPR's as part of extended regs
      https://git.kernel.org/powerpc/c/e79b76e03b712e42c58d9649c92571e346abc38b

cheers
