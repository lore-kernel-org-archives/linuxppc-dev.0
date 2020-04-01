Return-Path: <SRS0=4P7+=5R=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A54C43331
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2020 13:34:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF66820787
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2020 13:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF66820787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48snHL6kbTzDr8r
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 00:34:38 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48smMr2468zDr22
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2020 23:53:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 48smMq4kxlz9sTB; Wed,  1 Apr 2020 23:53:27 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48smMq1Xsmz9sT9; Wed,  1 Apr 2020 23:53:24 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 4b4d181d63518334070a877ba789211bde77da9e
In-Reply-To: <20200313112020.28235-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc/smp: Drop superfluous NULL check
Message-Id: <48smMq1Xsmz9sT9@ozlabs.org>
Date: Wed,  1 Apr 2020 23:53:24 +1100 (AEDT)
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
Cc: srikar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2020-03-13 at 11:20:19 UTC, Michael Ellerman wrote:
> We don't need the NULL check of np, the result is the same because the
> OF helpers cope with NULL, of_node_to_nid(NULL) == NUMA_NO_NODE (-1).
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/4b4d181d63518334070a877ba789211bde77da9e

cheers
