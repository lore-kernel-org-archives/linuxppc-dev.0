Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44D0C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:33:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5382320643
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5382320643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445SPG0ZmFzDqNH
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 21:33:54 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445RNL6rrRzDq69
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 20:48:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 445RNL428fz9sDr; Fri, 22 Feb 2019 20:48:02 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d065ee93aab6ef4c2a5af5c455b5044bd5136547
X-Patchwork-Hint: ignore
In-Reply-To: <3695e169b0367503f3a424d4862cba5a247fabf4.1550226577.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: drop unused GENERIC_CSUM Kconfig item
Message-Id: <445RNL428fz9sDr@ozlabs.org>
Date: Fri, 22 Feb 2019 20:48:02 +1100 (AEDT)
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
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2019-02-15 at 10:32:02 UTC, Christophe Leroy wrote:
> Commit d4fde568a34a ("powerpc/64: Use optimized checksum routines on
> little-endian") converted last powerpc user of GENERIC_CSUM.
> 
> This patch does a final cleanup dropping the Kconfig GENERIC_CSUM
> option which is always 'n', and associated piece of code in
> asm/checksum.h
> 
> Fixes: d4fde568a34a ("powerpc/64: Use optimized checksum routines on little-endian")
> Reported-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d065ee93aab6ef4c2a5af5c455b5044b

cheers
