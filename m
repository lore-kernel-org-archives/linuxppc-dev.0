Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8673DC10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:39:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3921E20859
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3921E20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nC6C7045zDqHr
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 00:39:47 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBf23sVVzDqNH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:18:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44nBf15BWbz9s5c; Mon, 22 Apr 2019 00:18:49 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBf11SrFz9sBZ; Mon, 22 Apr 2019 00:18:48 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: eea86aa4171d4960f0fcdc99dab358c224d53ffe
X-Patchwork-Hint: ignore
In-Reply-To: <20190314125453.4956-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/mm/64: Document the sizes of/sizes mapped by
 Pxx_INDEX_SIZE
Message-Id: <44nBf11SrFz9sBZ@ozlabs.org>
Date: Mon, 22 Apr 2019 00:18:48 +1000 (AEST)
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
Cc: aneesh.kumar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-03-14 at 12:54:53 UTC, Michael Ellerman wrote:
> Add comments describing the size in bytes of the various levels of the
> page table tree, and the size of the virtual address space mapped by
> each level, to make it clear what the sizes are without having to also
> look up other definitions.
> 
> The code that calculates the sizes actually uses sizeof(pgd_t) etc.,
> so in theory these comments could skew vs the code, but the size of
> pgd_t etc. is unlikely to change very often.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/eea86aa4171d4960f0fcdc99dab358c2

cheers
