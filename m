Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B0CC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 10:25:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0751B219FD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 10:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0751B219FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MM8H5DDHzDqwn
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 21:25:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MLSh5PTtzDqX9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 20:54:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43MLSh41XRz9sPF; Sat, 22 Dec 2018 20:54:44 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 76a5eaa38b15dda92cd6964248c39b5a6f3a4e9d
X-Patchwork-Hint: ignore
In-Reply-To: <1544623390-18710-2-git-send-email-diana.craciun@nxp.com>
To: Diana Craciun <diana.craciun@nxp.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [01/11] powerpc/fsl: Add infrastructure to fixup branch predictor
 flush
Message-Id: <43MLSh41XRz9sPF@ozlabs.org>
Date: Sat, 22 Dec 2018 20:54:44 +1100 (AEDT)
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
Cc: Diana Craciun <diana.craciun@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-12-12 at 14:03:00 UTC, Diana Craciun wrote:
> In order to protect against speculation attacks (Spectre
> variant 2) on NXP PowerPC platforms, the branch predictor
> should be flushed when the privillege level is changed.
> This patch is adding the infrastructure to fixup at runtime
> the code sections that are performing the branch predictor flush
> depending on a boot arg parameter which is added later in a
> separate patch.
> 
> Signed-off-by: Diana Craciun <diana.craciun@nxp.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/76a5eaa38b15dda92cd6964248c39b

cheers
