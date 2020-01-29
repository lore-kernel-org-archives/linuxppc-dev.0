Return-Path: <SRS0=BLMX=3S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4BEC33CB2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jan 2020 06:16:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E643A206A2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jan 2020 06:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E643A206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 486tXy63w9zDqNC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jan 2020 17:16:34 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 486sF04hKRzDqNf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2020 16:17:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 486sDz1RWgz9sSS; Wed, 29 Jan 2020 16:17:38 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 173bf44bdfc768af3c07cd0aeeb6ad8d1331b77d
In-Reply-To: <20200114110012.17351-1-laurentiu.tudor@nxp.com>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer of ehv_bytechan tty
 driver
Message-Id: <486sDz1RWgz9sSS@ozlabs.org>
Date: Wed, 29 Jan 2020 16:17:38 +1100 (AEDT)
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
Cc: "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "timur@kernel.org" <timur@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 Diana Madalina Craciun <diana.craciun@nxp.com>,
 "swood@redhat.com" <swood@redhat.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2020-01-14 at 11:00:25 UTC, Laurentiu Tudor wrote:
> Michael Ellerman made a call for volunteers from NXP to maintain
> this driver and I offered myself.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/173bf44bdfc768af3c07cd0aeeb6ad8d1331b77d

cheers
