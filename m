Return-Path: <SRS0=Z3yz=JH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAD7C433B4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Apr 2021 14:31:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065FA6115B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Apr 2021 14:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065FA6115B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FHcrf5DXHz3cZ5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Apr 2021 00:31:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FHcp72P19z3030
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Apr 2021 00:29:35 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FHcp61mRcz9sXL; Sun, 11 Apr 2021 00:29:33 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Jordan Niethe <jniethe5@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210225032108.1458352-1-jniethe5@gmail.com>
References: <20210225032108.1458352-1-jniethe5@gmail.com>
Subject: Re: [PATCH 1/3] powernv/memtrace: Allow mmaping trace buffers
Message-Id: <161806493716.1467223.17646127537782843067.b4-ty@ellerman.id.au>
Date: Sun, 11 Apr 2021 00:28:57 +1000
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

On Thu, 25 Feb 2021 14:21:06 +1100, Jordan Niethe wrote:
> Let the memory removed from the linear mapping to be used for the trace
> buffers be mmaped. This is a useful way of providing cache-inhibited
> memory for the alignment_handler selftest.

Patches 1 & 2 applied to powerpc/next.

[1/3] powernv/memtrace: Allow mmaping trace buffers
      https://git.kernel.org/powerpc/c/08a022ad3dfafc7e33d4529015e14bb75179cacc
[2/3] selftests/powerpc: Suggest memtrace instead of /dev/mem for ci memory
      https://git.kernel.org/powerpc/c/812aa68ef7d4d71bed996468ead665092a3f8de9

cheers
