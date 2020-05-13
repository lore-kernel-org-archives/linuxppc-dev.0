Return-Path: <SRS0=uIst=63=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B075CA90AF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2020 13:00:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E800D205ED
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2020 13:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E800D205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49MZY43nqVzDqGY
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2020 23:00:56 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49MZ9D5fBwzDqgF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2020 22:43:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49MZ9D4QCHz9sSk; Wed, 13 May 2020 22:43:44 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-integrity@vger.kernel.org
In-Reply-To: <1588342612-14532-1-git-send-email-nayna@linux.ibm.com>
References: <1588342612-14532-1-git-send-email-nayna@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/ima: fix secure boot rules in ima arch policy
Message-Id: <158937375594.3526905.9967004768395504429.b4-ty@ellerman.id.au>
Date: Wed, 13 May 2020 22:43:44 +1000 (AEST)
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
Cc: linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 1 May 2020 10:16:52 -0400, Nayna Jain wrote:
> To prevent verifying the kernel module appended signature twice
> (finit_module), once by the module_sig_check() and again by IMA, powerpc
> secure boot rules define an IMA architecture specific policy rule
> only if CONFIG_MODULE_SIG_FORCE is not enabled. This, unfortunately, does
> not take into account the ability of enabling "sig_enforce" on the boot
> command line (module.sig_enforce=1).
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/ima: Fix secure boot rules in ima arch policy
      https://git.kernel.org/powerpc/c/fa4f3f56ccd28ac031ab275e673ed4098855fed4

cheers
