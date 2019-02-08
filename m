Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4919AC169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:18:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07C220844
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07C220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wy371F2wzDqZS
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 01:18:43 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wwMS6XBqzDqWt
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 00:02:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43wwMS1YL8z9sPL; Sat,  9 Feb 2019 00:02:43 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b174b4fb919d118d9ac546b99a69574dfa431f7f
X-Patchwork-Hint: ignore
In-Reply-To: <20190201004201.6512-1-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/powernv: Escalate reset when IODA reset fails
Message-Id: <43wwMS1YL8z9sPL@ozlabs.org>
Date: Sat,  9 Feb 2019 00:02:43 +1100 (AEDT)
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2019-02-01 at 00:42:01 UTC, Oliver O'Halloran wrote:
> The IODA reset is used to flush out any OS controlled state from the PHB.
> This reset can fail if a PHB fatal error has occurred in early boot,
> probably due to a because of a bad device. We already do a fundemental
> reset of the device in some cases, so this patch just adds a test to force
> a full reset if firmware reports an error when performing the IODA reset.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b174b4fb919d118d9ac546b99a69574d

cheers
