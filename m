Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1BAC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:24:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15442184A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15442184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4496ZP5nw0zDqJN
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 20:24:29 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4496VY1dDpzDqH1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 20:21:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4496VX62rvz9s5c; Thu, 28 Feb 2019 20:21:08 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 930d6288a26787d2e7f633705434171a506db9c5
X-Patchwork-Hint: ignore
In-Reply-To: <d2a6e5ff179fcb351f79f87e156168d50a3e091c.1550817742.git.sandipan@linux.ibm.com>
To: Sandipan Das <sandipan@linux.ibm.com>, sandipan@linux.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2, 1/6] powerpc: sstep: Add support for maddhd, maddhdu,
 maddld instructions
Message-Id: <4496VX62rvz9s5c@ozlabs.org>
Date: Thu, 28 Feb 2019 20:21:08 +1100 (AEDT)
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
Cc: naveen.n.rao@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 ravi.bangoria@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2019-02-22 at 06:53:27 UTC, Sandipan Das wrote:
> This adds emulation support for the following integer instructions:
>   * Multiply-Add High Doubleword (maddhd)
>   * Multiply-Add High Doubleword Unsigned (maddhdu)
>   * Multiply-Add Low Doubleword (maddld)
> 
> As suggested by Michael, this uses a raw .long for specifying the
> instruction word when using inline assembly to retain compatibility
> with older binutils.
> 
> Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/930d6288a26787d2e7f633705434171a

cheers
