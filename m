Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E70EC10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:34:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4206B20859
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4206B20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nBzf2zk8zDqNQ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 00:34:06 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBdw5mnNzDqMH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:18:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBdw2Yk0z9sB8; Mon, 22 Apr 2019 00:18:44 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e291b6d575bc6e4d1d36961b081be521a6c800d6
X-Patchwork-Hint: ignore
In-Reply-To: <17f151878f35fd449b9375308dd096f0d922746b.1552292207.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, ruscur@russell.cc
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2,
 03/10] powerpc/32: Remove MSR_PR test when returning from syscall
Message-Id: <44nBdw2Yk0z9sB8@ozlabs.org>
Date: Mon, 22 Apr 2019 00:18:44 +1000 (AEST)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-03-11 at 08:30:30 UTC, Christophe Leroy wrote:
> syscalls are from user only, so we can account time without checking
> whether returning to kernel or user as it will only be user.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Patches 3-10 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e291b6d575bc6e4d1d36961b081be521

cheers
