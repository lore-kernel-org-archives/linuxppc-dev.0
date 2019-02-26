Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761C4C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 03:34:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F58206B8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 03:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F58206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447kvQ6NgTzDqQG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 14:34:26 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447klq41pWzDqM5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 14:27:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 447klq0ZV7z9s9L; Tue, 26 Feb 2019 14:27:50 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 84022ac17327c5383917f46c162fd943cf79583f
X-Patchwork-Hint: ignore
In-Reply-To: <df7e1d69a6ac2ec3db8bb5481431d8ad8a28157a.1550645549.git.sandipan@linux.ibm.com>
To: Sandipan Das <sandipan@linux.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/3] powerpc: sstep: Add tests for compute type instructions
Message-Id: <447klq0ZV7z9s9L@ozlabs.org>
Date: Tue, 26 Feb 2019 14:27:50 +1100 (AEDT)
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
Cc: naveen.n.rao@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, dja@axtens.net,
 paulus@samba.org, ravi.bangoria@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-02-20 at 06:56:58 UTC, Sandipan Das wrote:
> This enhances the current selftest framework for validating
> the in-kernel instruction emulation infrastructure by adding
> support for compute type instructions i.e. integer ALU-based
> instructions. Originally, this framework was limited to only
> testing load and store instructions.
> 
> While most of the GPRs can be validated, support for SPRs is
> limited to LR, CR and XER for now.
> 
> When writing the test cases, one must ensure that the Stack
> Pointer (GPR1) or the Thread Pointer (GPR13) are not touched
> by any means as these are vital non-volatile registers.
> 
> Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/84022ac17327c5383917f46c162fd943

cheers
