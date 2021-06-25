Return-Path: <SRS0=zi2C=LT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B02C2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 06:25:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB01610F7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 06:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB01610F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GB6Sz0Vcvz3bwB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 16:25:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GB6RV2m0gz2yhr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jun 2021 16:24:38 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4GB6RT2JYfz9sXb; Fri, 25 Jun 2021 16:24:37 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20210621064938.2021419-1-mpe@ellerman.id.au>
References: <20210621064938.2021419-1-mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc/prom_init: Convert prom_strcpy() into
 prom_strscpy_pad()
Message-Id: <162460208744.3247425.11901434488919269002.b4-ty@ellerman.id.au>
Date: Fri, 25 Jun 2021 16:21:27 +1000
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 21 Jun 2021 16:49:37 +1000, Michael Ellerman wrote:
> In a subsequent patch we'd like to have something like a strscpy_pad()
> implementation usable in prom_init.c.
> 
> Currently we have a strcpy() implementation with only one caller, so
> convert it into strscpy_pad() and update the caller.

Applied to powerpc/next.

[1/2] powerpc/prom_init: Convert prom_strcpy() into prom_strscpy_pad()
      https://git.kernel.org/powerpc/c/f47d5a4fc254e62ea5af5cbb2fc3e68901def434
[2/2] powerpc/prom_init: Pass linux_banner to firmware via option vector 7
      https://git.kernel.org/powerpc/c/ffaacd97fd37b9f4e825d8107f5cba5470458f0e

cheers
