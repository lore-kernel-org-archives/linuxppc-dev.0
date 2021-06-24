Return-Path: <SRS0=UTIz=LS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8024FC49EA5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 14:05:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129E2613F6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 14:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129E2613F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G9hj95Cwtz3ckd
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 00:05:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G9hh96YQsz306f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jun 2021 00:04:09 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4G9hh84xndz9sX1; Fri, 25 Jun 2021 00:04:08 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <20210503130243.891868-1-npiggin@gmail.com>
References: <20210503130243.891868-1-npiggin@gmail.com>
Subject: Re: [PATCH 0/4] powerpc/security mitigation updates
Message-Id: <162454339637.2931445.10731746908478555595.b4-ty@ellerman.id.au>
Date: Fri, 25 Jun 2021 00:03:16 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 3 May 2021 23:02:39 +1000, Nicholas Piggin wrote:
> This series adds a few missing bits added to recent pseries
> H_GET_CPU_CHARACTERISTICS and implements them, also removes
> a restriction from powernv for some of the flushes.
> 
> This is tested mianly in qemu where I just submitted a patch
> that adds support for these bits (not upstream yet).
> 
> [...]

Patches 1-3 applied to powerpc/next.

[1/4] powerpc/pseries: Get entry and uaccess flush required bits from H_GET_CPU_CHARACTERISTICS
      https://git.kernel.org/powerpc/c/65c7d070850e109a8a75a431f5a7f6eb4c007b77
[2/4] powerpc/security: Add a security feature for STF barrier
      https://git.kernel.org/powerpc/c/84ed26fd00c514da57cd46aa3728a48f1f9b35cd
[3/4] powerpc/pesries: Get STF barrier requirement from H_GET_CPU_CHARACTERISTICS
      https://git.kernel.org/powerpc/c/393eff5a7b357a23db3e786e24b5ba8762cc6820

cheers
