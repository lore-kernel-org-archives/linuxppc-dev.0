Return-Path: <SRS0=zlGz=J2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76899C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 14:08:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5EF66105A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 14:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5EF66105A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FWHRV37lhz3bww
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 00:08:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FWHJc4fhfz3btR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Apr 2021 00:02:56 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FWHJb6lklz9tB1; Fri, 30 Apr 2021 00:02:55 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Yang Li <yang.lee@linux.alibaba.com>, mpe@ellerman.id.au
In-Reply-To: <1612236877-104974-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1612236877-104974-1-git-send-email-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH] powerpc/64s: remove unneeded semicolon
Message-Id: <161970488472.4033873.17685966571846339561.b4-ty@ellerman.id.au>
Date: Fri, 30 Apr 2021 00:01:24 +1000
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
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2 Feb 2021 11:34:36 +0800, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./arch/powerpc/platforms/powernv/setup.c:160:2-3: Unneeded semicolon

Applied to powerpc/next.

[1/1] powerpc/64s: remove unneeded semicolon
      https://git.kernel.org/powerpc/c/caea7b833d866e0badf4b12dc41bf9fe6a7295f3

cheers
