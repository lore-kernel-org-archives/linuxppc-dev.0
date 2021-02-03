Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D826DC433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 12:35:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DAE64F95
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 12:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DAE64F95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DW1Nf5VFjzF3DK
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 23:35:14 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DW09d0wcPzDwlK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2021 22:40:37 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DW09c0GBmz9vG0; Wed,  3 Feb 2021 22:40:35 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Markus Elfring <Markus.Elfring@web.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paul Mackerras <paulus@samba.org>, Enrico Weigelt <lkml@metux.net>
In-Reply-To: <6dc7d70e-8a40-46ab-897b-d2eaf9a87d77@web.de>
References: <6dc7d70e-8a40-46ab-897b-d2eaf9a87d77@web.de>
Subject: Re: [PATCH 0/2] powerpc/82xx: Adjustments for pq2ads_pci_init_irq()
Message-Id: <161235200985.1516112.15383644631445109361.b4-ty@ellerman.id.au>
Date: Wed,  3 Feb 2021 22:40:35 +1100 (AEDT)
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
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 27 Aug 2019 10:23:29 +0200, Markus Elfring wrote:
> Two update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>   Delete an unnecessary of_node_put() call
>   Use common error handling code
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/82xx: Delete an unnecessary of_node_put() call in pq2ads_pci_init_irq()
      https://git.kernel.org/powerpc/c/60aece416483fdf7e51728a3518438e0458bdabb
[2/2] powerpc/82xx: Use common error handling code in pq2ads_pci_init_irq()
      https://git.kernel.org/powerpc/c/c0cff7a17781f8b02b4837a9fc434a7eed322a14

cheers
