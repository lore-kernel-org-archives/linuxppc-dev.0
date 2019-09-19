Return-Path: <SRS0=y999=XO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F17EC3A5A6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Sep 2019 10:28:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E4B21907
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Sep 2019 10:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E4B21907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46YtP01W2rzF3Mm
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Sep 2019 20:28:52 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46YtKH33vJzF4XJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2019 20:25:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 46YtKG6Krmz9sP3; Thu, 19 Sep 2019 20:25:38 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: ec5b705c48365549c483fab17d68d15d83bef265
In-Reply-To: <1566570120-16529-1-git-send-email-cai@lca.pw>
To: Qian Cai <cai@lca.pw>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm/radix: remove useless kernel messages
Message-Id: <46YtKG6Krmz9sP3@ozlabs.org>
Date: Thu, 19 Sep 2019 20:25:38 +1000 (AEST)
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
Cc: aneesh.kumar@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Qian Cai <cai@lca.pw>, linux-kernel@vger.kernel.org, paulus@samba.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2019-08-23 at 14:22:00 UTC, Qian Cai wrote:
> Booting a POWER9 PowerNV system generates a few messages below with
> "____ptrval____" due to the pointers printed without a specifier
> extension (i.e unadorned %p) are hashed to prevent leaking information
> about the kernel memory layout.
> 
> radix-mmu: Initializing Radix MMU
> radix-mmu: Partition table (____ptrval____)
> radix-mmu: Mapped 0x0000000000000000-0x0000000040000000 with 1.00 GiB
> pages (exec)
> radix-mmu: Mapped 0x0000000040000000-0x0000002000000000 with 1.00 GiB
> pages
> radix-mmu: Mapped 0x0000200000000000-0x0000202000000000 with 1.00 GiB
> pages
> radix-mmu: Process table (____ptrval____) and radix root for kernel:
> (____ptrval____)
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ec5b705c48365549c483fab17d68d15d83bef265

cheers
