Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD5FC10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:13:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D517720859
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D517720859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nCfW6CVWzDqRH
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 01:04:19 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBfV0yg5zDqMn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:19:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBfT40wYz9sMx; Mon, 22 Apr 2019 00:19:12 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 4f40b15f339d896f5726714842947c9339742494
X-Patchwork-Hint: ignore
In-Reply-To: <20190417130351.3805-3-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 paulus@samba.org, Christophe Leroy <christophe.leroy@c-s.fr>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v3,2/6] powerpc/mm: Remove PPC_MM_SLICES #ifdef for book3s64
Message-Id: <44nBfT40wYz9sMx@ozlabs.org>
Date: Mon, 22 Apr 2019 00:19:12 +1000 (AEST)
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-04-17 at 13:03:47 UTC, "Aneesh Kumar K.V" wrote:
> Book3s64 always have PPC_MM_SLICES enabled. So remove the unncessary #ifdef
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Patches 2-6 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4f40b15f339d896f5726714842947c93

cheers
