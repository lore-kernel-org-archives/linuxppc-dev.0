Return-Path: <SRS0=mlYb=D3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0829AC433E7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2020 12:42:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 222DC21548
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2020 12:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222DC21548
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CFtZ76WtpzDqLj
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2020 23:42:39 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CFt8Z0Dq0zDqRG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2020 23:23:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CFt8W3RDHz9sRR; Tue, 20 Oct 2020 23:23:54 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
In-Reply-To: <20201019042716.106234-1-srikar@linux.vnet.ibm.com>
References: <20201019042716.106234-1-srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/2] Fixes for coregroup
Message-Id: <160319650960.2348169.11451661238920733591.b4-ty@ellerman.id.au>
Date: Tue, 20 Oct 2020 23:23:54 +1100 (AEDT)
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
 Gautham R Shenoy <ego@linux.vnet.ibm.com>, Qian Cai <cai@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Valentin Schneider <valentin.schneider@arm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 19 Oct 2020 09:57:14 +0530, Srikar Dronamraju wrote:
> These patches fixes problems introduced by the coregroup patches.
> The first patch we remove a redundant variable.
> Second patch allows to boot with CONFIG_CPUMASK_OFFSTACK enabled.
> 
> Changelog v1->v2:
> https://lore.kernel.org/linuxppc-dev/20201008034240.34059-1-srikar@linux.vnet.ibm.com/t/#u
> 1. 1st patch was not part of previous posting.
> 2. Updated 2nd patch based on comments from Michael Ellerman
> 
> [...]

Applied to powerpc/fixes.

[1/2] powerpc/smp: Remove unnecessary variable
      https://git.kernel.org/powerpc/c/966730a6e8524c1b5fe64358e5884605cab6ccb3
[2/2] powerpc/smp: Use GFP_ATOMIC while allocating tmp mask
      https://git.kernel.org/powerpc/c/84dbf66c63472069e5eb40b810731367618cd8b5

cheers
