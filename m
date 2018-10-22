Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F79C67863
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 10:18:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE9BC20658
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 10:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9BC20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42dstD72DPzF35y
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 21:18:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ds2m348XzDrVx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 20:40:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42ds2m2MS9z9sDJ; Mon, 22 Oct 2018 20:40:48 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0f99153def98134403c9149128e59d3e1786cf04
In-Reply-To: <c0cec03a57070ef3662ae7e2ddffbdeefb128b81.1539891327.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, radu.rendec@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/msi: Fix compile error on mpc83xx
Message-Id: <42ds2m2MS9z9sDJ@ozlabs.org>
Date: Mon, 22 Oct 2018 20:40:47 +1100 (AEDT)
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

On Fri, 2018-10-19 at 06:12:50 UTC, Christophe Leroy wrote:
> mpic_get_primary_version() is not defined when not using MPIC.
> The compile error log like:
> 
> arch/powerpc/sysdev/built-in.o: In function `fsl_of_msi_probe':
> fsl_msi.c:(.text+0x150c): undefined reference to `fsl_mpic_primary_get_version'
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Reported-by: Radu Rendec <radu.rendec@gmail.com>
> Fixes: 807d38b73b6 ("powerpc/mpic: Add get_version API both for internal and external use")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0f99153def98134403c9149128e59d

cheers
