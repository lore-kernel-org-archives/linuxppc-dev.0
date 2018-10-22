Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC0EC67863
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 09:44:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C96F620652
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 09:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96F620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ds6t60RzzDrTg
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 20:44:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42drw73vgjzDrdf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 20:35:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42drw739fGz9sDL; Mon, 22 Oct 2018 20:35:03 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: aa5456abdc20568f5da348209148a9c75a32468a
In-Reply-To: <f3a64e8451cd539f8a2e864045576ad99598160d.1529589663.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, malat@debian.org,
 aneesh.kumar@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/mm: fix missing prototypes in slice.c
Message-Id: <42drw739fGz9sDL@ozlabs.org>
Date: Mon, 22 Oct 2018 20:35:02 +1100 (AEDT)
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

On Fri, 2018-06-22 at 13:49:48 UTC, Christophe Leroy wrote:
> This patch fixes the following warnings (obtained with make W=1).
> 
> arch/powerpc/mm/slice.c: At top level:
> arch/powerpc/mm/slice.c:682:15: error: no previous prototype for 'arch_get_unmapped_area' [-Werror=missing-prototypes]
>  unsigned long arch_get_unmapped_area(struct file *filp,
>                ^
> arch/powerpc/mm/slice.c:692:15: error: no previous prototype for 'arch_get_unmapped_area_topdown' [-Werror=missing-prototypes]
>  unsigned long arch_get_unmapped_area_topdown(struct file *filp,
>                ^
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/aa5456abdc20568f5da348209148a9

cheers
