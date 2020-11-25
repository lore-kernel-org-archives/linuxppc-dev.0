Return-Path: <SRS0=IR6y=E7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628CBC5519F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 13:00:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9F3206F7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 13:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9F3206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ch1GP1VzczDqGS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 00:00:45 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CgztL6FjvzDqPf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2020 22:58:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Cgzsy71f5z9sW0; Wed, 25 Nov 2020 22:57:58 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: paulus@samba.org, "xiakaixu1987@gmail.com" <xiakaixu1987@gmail.com>,
 mpe@ellerman.id.au, benh@kernel.crashing.org
In-Reply-To: <1604976961-20441-1-git-send-email-kaixuxia@tencent.com>
References: <1604976961-20441-1-git-send-email-kaixuxia@tencent.com>
Subject: Re: [PATCH] powerpc/mm: Fix comparing pointer to 0 warning
Message-Id: <160630540419.2174375.11309649223886745354.b4-ty@ellerman.id.au>
Date: Wed, 25 Nov 2020 22:57:58 +1100 (AEDT)
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
Cc: linuxppc-dev@lists.ozlabs.org, Kaixu Xia <kaixuxia@tencent.com>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 10 Nov 2020 10:56:01 +0800, xiakaixu1987@gmail.com wrote:
> Fixes coccicheck warning:
> 
> ./arch/powerpc/mm/pgtable_32.c:87:11-12: WARNING comparing pointer to 0
> 
> Avoid pointer type value compared to 0.

Applied to powerpc/next.

[1/1] powerpc/mm: Fix comparing pointer to 0 warning
      https://git.kernel.org/powerpc/c/b84bf098fcc49ed6bf4b0a8bed52e9df0e8f1de7

cheers
