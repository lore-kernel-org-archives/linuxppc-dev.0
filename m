Return-Path: <SRS0=37tr=TD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27649C43219
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 07:18:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C312075C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 07:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C312075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44wNl56b3vzDqc7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 17:18:09 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44wNKD2MYZzDqPb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2019 16:59:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44wNKC2Pt1z9sP8; Fri,  3 May 2019 16:59:10 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1ba2143606a10f1c2e7308bc7abd940a6381cffd
X-Patchwork-Hint: ignore
In-Reply-To: <20190327053137.15173-2-alastair@au1.ibm.com>
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v4 1/7] ocxl: Split pci.c
Message-Id: <44wNKC2Pt1z9sP8@ozlabs.org>
Date: Fri,  3 May 2019 16:59:10 +1000 (AEST)
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-03-27 at 05:31:30 UTC, "Alastair D'Silva" wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> In preparation for making core code available for external drivers,
> move the core code out of pci.c and into core.c
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1ba2143606a10f1c2e7308bc7abd940a

cheers
