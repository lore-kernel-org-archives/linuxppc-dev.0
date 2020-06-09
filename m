Return-Path: <SRS0=Er2m=7W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AD4C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 06:18:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4CF207F9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 06:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4CF207F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49h0Kf0B0QzDqPT
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 16:17:58 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49gzFL3xL1zDqRv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2020 15:29:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49gzFL0WpHz9sV2; Tue,  9 Jun 2020 15:29:09 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, Michael Neuling <mikey@neuling.org>
In-Reply-To: <20200528230731.1235752-1-mikey@neuling.org>
References: <20200528230731.1235752-1-mikey@neuling.org>
Subject: Re: [PATCH] powerpc: Fix misleading small cores print
Message-Id: <159168034354.1381411.1178658127765747776.b4-ty@ellerman.id.au>
Date: Tue,  9 Jun 2020 15:29:09 +1000 (AEST)
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
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 29 May 2020 09:07:31 +1000, Michael Neuling wrote:
> Currently when we boot on a big core system, we get this print:
>   [    0.040500] Using small cores at SMT level
> 
> This is misleading as we've actually detected big cores.
> 
> This patch clears up the print to say we've detect big cores but are
> using small cores for scheduling.

Applied to powerpc/next.

[1/1] powerpc: Fix misleading small cores print
      https://git.kernel.org/powerpc/c/82a7cebdd95cffa55449d6c1d97cc9b743a66056

cheers
