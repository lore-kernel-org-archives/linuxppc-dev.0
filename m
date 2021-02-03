Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C78C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 12:37:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D7A64E36
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 12:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D7A64E36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DW1RG2qlYzF39F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 23:37:30 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DW09f5pXczDwt7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2021 22:40:38 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DW09f1S2Sz9vDt; Wed,  3 Feb 2021 22:40:37 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Frank Rowand <frank.rowand@sony.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Allison Randal <allison@lohutok.net>, Markus Elfring <Markus.Elfring@web.de>,
 Oliver O'Halloran <oohall@gmail.com>, Nathan Lynch <nathanl@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paul Mackerras <paulus@samba.org>, Gen Zhang <blackgod016574@gmail.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <db28c84d-ac07-6d9a-a371-c97ab72bf763@web.de>
References: <db28c84d-ac07-6d9a-a371-c97ab72bf763@web.de>
Subject: Re: [PATCH 0/2] PowerPC-pSeries: Adjustments for dlpar_store()
Message-Id: <161235200944.1516112.5674406874820012967.b4-ty@ellerman.id.au>
Date: Wed,  3 Feb 2021 22:40:37 +1100 (AEDT)
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

On Tue, 27 Aug 2019 14:40:42 +0200, Markus Elfring wrote:
> Two update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>   Delete an unnecessary kfree() call
>   Delete an error message for a failed string duplication
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/pseries: Delete an unnecessary kfree() call in dlpar_store()
      https://git.kernel.org/powerpc/c/de060ac83e5c1fe5fb8c505a4e99c1fe4f70ff94
[2/2] powerpc/pseries: Delete an error message for a failed string duplication in dlpar_store()
      https://git.kernel.org/powerpc/c/6e7a4da754f3087fa1f0839c1128aac233c21442

cheers
