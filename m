Return-Path: <SRS0=hJnm=LM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7EFC48BDF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 04:23:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 854D26117A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 04:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854D26117A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G5m575wjFz3cR0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 14:23:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G5m4600NLz2yhf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 14:22:45 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4G5m4502l3z9sXN; Fri, 18 Jun 2021 14:22:44 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <1fff2054e5dfc00329804dbd3f2a91667c9a8aff.1623438544.git.christophe.leroy@csgroup.eu>
References: <1fff2054e5dfc00329804dbd3f2a91667c9a8aff.1623438544.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] powerpc/64: drop redundant defination of
 spin_until_cond
Message-Id: <162398829870.1363949.16738170586766727812.b4-ty@ellerman.id.au>
Date: Fri, 18 Jun 2021 13:51:38 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 11 Jun 2021 19:10:57 +0000 (UTC), Christophe Leroy wrote:
> linux/processor.h has exactly same defination for spin_until_cond.
> Drop the redundant defination in asm/processor.h

Applied to powerpc/next.

[1/2] powerpc/64: drop redundant defination of spin_until_cond
      https://git.kernel.org/powerpc/c/db8f7066dc498acf9074ed3c11a7a24f318d8d4f
[2/2] powerpc/watchdog: include linux/processor.h for spin_until_cond
      https://git.kernel.org/powerpc/c/2400c13c437debc99d3399a7100d4e8c3fe20a08

cheers
