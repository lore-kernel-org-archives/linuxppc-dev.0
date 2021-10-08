Return-Path: <SRS0=IY60=O4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA6FC433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Oct 2021 13:26:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8C460F9C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Oct 2021 13:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B8C460F9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HQpql591mz3c7p
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Oct 2021 00:26:27 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HQpnY1Mf8z2yKB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Oct 2021 00:24:33 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HQpnY0WQMz4xqP;
 Sat,  9 Oct 2021 00:24:33 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <20211004145642.1331214-1-npiggin@gmail.com>
References: <20211004145642.1331214-1-npiggin@gmail.com>
Subject: Re: [PATCH 0/5] powerpc: various interrupt handling fixes
Message-Id: <163369938156.3568929.5142383792032173677.b4-ty@ellerman.id.au>
Date: Sat, 09 Oct 2021 00:23:01 +1100
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
Cc: Ganesh Goudar <ganeshgr@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 5 Oct 2021 00:56:37 +1000, Nicholas Piggin wrote:
> This fixes a number of bugs found mostly looking at a MCE handler issue,
> which should be fixed in patch 5 of the series, previous attempt here
> which Ganesh found to be wrong.
> 
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210922020247.209409-1-npiggin@gmail.com/
> 
> I didn't increment to patch v2 because it's a different approach (so I
> gave it a different title).
> 
> [...]

Applied to powerpc/fixes.

[1/5] powerpc/64s: fix program check interrupt emergency stack path
      https://git.kernel.org/powerpc/c/3e607dc4df180b72a38e75030cb0f94d12808712
[2/5] powerpc/traps: do not enable irqs in _exception
      https://git.kernel.org/powerpc/c/d0afd44c05f8f4e4c91487c02d43c87a31552462
[3/5] powerpc/64: warn if local irqs are enabled in NMI or hardirq context
      https://git.kernel.org/powerpc/c/ff058a8ada5df0d84e5537cfaf89d06d71501580
[4/5] powerpc/64/interrupt: Reconcile soft-mask state in NMI and fix false BUG
      https://git.kernel.org/powerpc/c/768c47010392ece9766a56479b4e0cf04a536916
[5/5] powerpc/64s: Fix unrecoverable MCE calling async handler from NMI
      https://git.kernel.org/powerpc/c/f08fb25bc66986b0952724530a640d9970fa52c1

cheers
