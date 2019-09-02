Return-Path: <SRS0=Itbs=W5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CADC3A5A4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Sep 2019 03:16:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2DAA20656
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Sep 2019 03:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DAA20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MFc861RzzDqT3
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Sep 2019 13:16:40 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MFN85rRTzDqYj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Sep 2019 13:06:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 46MFN84MLtz9sBF; Mon,  2 Sep 2019 13:06:16 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 46MFN82G7vz9sDB; Mon,  2 Sep 2019 13:06:16 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 70ed86f4de5bd74dd2d884dcd2f3275c4cfe665f
In-Reply-To: <20190829155021.2915-2-maxiwell@linux.ibm.com>
To: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v2 1/2] powerpc: Add PowerPC Capabilities ELF note
Message-Id: <46MFN82G7vz9sDB@ozlabs.org>
Date: Mon,  2 Sep 2019 13:06:16 +1000 (AEST)
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
Cc: linux-arch@vger.kernel.org, andmike@linux.ibm.com, linuxram@us.ibm.com,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, cclaudio@linux.ibm.com,
 "Maxiwell S . Garcia" <maxiwell@linux.ibm.com>, bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-08-29 at 15:50:20 UTC, "Maxiwell S. Garcia" wrote:
> From: Claudio Carvalho <cclaudio@linux.ibm.com>
> 
> Add the PowerPC name and the PPC_ELFNOTE_CAPABILITIES type in the
> kernel binary ELF note. This type is a bitmap that can be used to
> advertise kernel capabilities to userland.
> 
> This patch also defines PPCCAP_ULTRAVISOR_BIT as being the bit zero.
> 
> Suggested-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> [ maxiwell: Define the 'PowerPC' type in the elfnote.h ]
> Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>

Series applied to powerpc topic/ppc-kvm, thanks.

https://git.kernel.org/powerpc/c/70ed86f4de5bd74dd2d884dcd2f3275c4cfe665f

cheers
