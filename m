Return-Path: <SRS0=n4ep=DX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91C2C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2020 11:38:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2702084C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2020 11:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2702084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCPKg2spqzDqcq
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2020 22:38:15 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCPC84kT4zDqcl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2020 22:32:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CCPC805pJz9sTv; Fri, 16 Oct 2020 22:32:35 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20201009064005.19777-1-ganeshgr@linux.ibm.com>
References: <20201009064005.19777-1-ganeshgr@linux.ibm.com>
Subject: Re: [PATCH v4 0/2] powerpc/mce: Fix mce handler and add selftest
Message-Id: <160284791867.1794337.3709853894956238598.b4-ty@ellerman.id.au>
Date: Fri, 16 Oct 2020 22:32:35 +1100 (AEDT)
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
Cc: msuchanek@suse.de, mahesh@linux.ibm.com, npiggin@gmail.com,
 keescook@chromium.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 9 Oct 2020 12:10:03 +0530, Ganesh Goudar wrote:
> This patch series fixes mce handling for pseries, Adds LKDTM test
> for SLB multihit recovery and enables selftest for the same,
> basically to test MCE handling on pseries/powernv machines running
> in hash mmu mode.
> 
> v4:
> * Use radix_enabled() to check if its in Hash or Radix mode.
> * Use FW_FEATURE_LPAR instead of machine_is_pseries().
> 
> [...]

Patch 1 applied to powerpc/fixes.

[1/2] powerpc/mce: Avoid nmi_enter/exit in real mode on pseries hash
      https://git.kernel.org/powerpc/c/8d0e2101274358d9b6b1f27232b40253ca48bab5

cheers
