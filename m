Return-Path: <SRS0=u7tn=UC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC310C04AB5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jun 2019 12:46:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A785E28128
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jun 2019 12:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A785E28128
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45HZYf43XnzDqRJ
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jun 2019 22:46:30 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45HZFy2gMczDqRC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jun 2019 22:32:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45HZFy0QHcz9sP0; Mon,  3 Jun 2019 22:32:53 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 89d87bcba2874d824affb7842bb3960cb6f5be05
X-Patchwork-Hint: ignore
Content-Type: text/plain; charset="utf-8";
In-Reply-To: <20190523122804.4801-1-fbarrat@linux.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 ajd@linux.ibm.com, arbab@linux.ibm.com, aik@ozlabs.ru
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/powernv: Show checkstop reason for NPU2 HMIs
Message-Id: <45HZFy0QHcz9sP0@ozlabs.org>
Date: Mon,  3 Jun 2019 22:32:53 +1000 (AEST)
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
Cc: clombard@linux.ibm.com, groug@kaod.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-05-23 at 12:28:04 UTC, Frederic Barrat wrote:
> If the kernel is notified of an HMI caused by the NPU2, it's currently
> not being recognized and it logs the default message:
> 
>     Unknown Malfunction Alert of type 3
> 
> The NPU on Power 9 has 3 Fault Isolation Registers, so that's a lot of
> possible causes, but we should at least log that it's an NPU problem
> and report which FIR and which bit were raised if opal gave us the
> information.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/89d87bcba2874d824affb7842bb3960c

cheers
