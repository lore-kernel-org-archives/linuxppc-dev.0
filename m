Return-Path: <SRS0=o3hI=CF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CE1C433E3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2020 08:05:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E6122CB1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2020 08:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E6122CB1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BcZyt1YDKzDqgC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2020 18:05:10 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BcZYs0W6TzDqd3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2020 17:46:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BcZYq2qrBz9sTS; Thu, 27 Aug 2020 17:46:55 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: pratik.r.sampat@gmail.com, linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
 mikey@neuling.org, svaidy@linux.ibm.com, ego@linux.vnet.ibm.com,
 npiggin@gmail.com, Pratik Rajesh Sampat <psampat@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200826082918.89306-1-psampat@linux.ibm.com>
References: <20200826082918.89306-1-psampat@linux.ibm.com>
Subject: Re: [PATCH] Revert "powerpc/powernv/idle: Replace CPU feature check
 with PVR check"
Message-Id: <159851436179.52163.400542101081853718.b4-ty@ellerman.id.au>
Date: Thu, 27 Aug 2020 17:46:54 +1000 (AEST)
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

On Wed, 26 Aug 2020 13:59:18 +0530, Pratik Rajesh Sampat wrote:
> Cpuidle stop state implementation has minor optimizations for P10
> where hardware preserves more SPR registers compared to P9.
> The current P9 driver works for P10, although does few extra
> save-restores. P9 driver can provide the required power management
> features like SMT thread folding and core level power savings
> on a P10 platform.
> 
> [...]

Applied to powerpc/fixes.

[1/1] Revert "powerpc/powernv/idle: Replace CPU feature check with PVR check"
      https://git.kernel.org/powerpc/c/16d83a540ca4e7f1ebb2b3756869b77451d31414

cheers
