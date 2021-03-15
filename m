Return-Path: <SRS0=qf4I=IN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72027C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 00:38:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A815764E77
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 00:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A815764E77
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DzHZv4KMyz3cLp
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 11:38:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=merlin.20170209 header.b=o7dJPAxQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1234::107; helo=merlin.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=merlin.20170209 header.b=o7dJPAxQ; 
 dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1234::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DzHZQ07VMz30PK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Mar 2021 11:37:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
 Reply-To:Cc:Content-ID:Content-Description;
 bh=38vnoiIBOpESzfxEzG3nj/BXtJ6NAK+uvQW+9Jymr90=; b=o7dJPAxQEyNHYvJBMVEFxYCZvt
 GlzMmNEll8MvN8KC1a8KTY4xWLe+5Q4BtB8mhTtudk6UhN8y7NGPpb9hpQnmiyeglrtWzHO8kvhHS
 HN0xE2UmQmrWr4TRCf77Fkg79Mrp/ANzfsabi/8dp1Df+c81a6F7Pl372Pb+wQpVe321q5t9Ykcys
 xPHO0/4+emwlb8X2Uk0OHLfBobaP7ZqoC8nwa79bRF0SdyyJaYKWfRbueCdWr1+0r37c3ckbNMLrj
 hr6ukL2KFqetU3oJhMFN2WGFIM9f4rH1PRs0C8TI2y+agX7kXzj0pAtIR9Zo3VAR4iTuY/1svVzOZ
 l1NflJ8Q==;
Received: from [2601:1c0:6280:3f0::9757]
 by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lLbEs-001F1y-GK; Mon, 15 Mar 2021 00:37:42 +0000
Subject: Re: [PATCH] powerpc: kernel: Trivial spelling fixes throughout the
 file head_fsl_booke.S
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org,
 rppt@kernel.org, oss@buserror.net, christophe.leroy@csgroup.eu,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210314220436.3417083-1-unixbhaskar@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f8dc3cbe-54f4-1da1-b14f-4735d28aad13@infradead.org>
Date: Sun, 14 Mar 2021 17:37:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210314220436.3417083-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 3/14/21 3:04 PM, Bhaskar Chowdhury wrote:
> 
> Trivial spelling fixes throughout the file.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  arch/powerpc/kernel/head_fsl_booke.S | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
> index fdd4d274c245..c6fcfca0b0d7 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -403,7 +403,7 @@ interrupt_base:
>  	EXCEPTION(0x2900, AP_UNAVAIL, AuxillaryProcessorUnavailable, \
>  		  unknown_exception, EXC_XFER_STD)
> 
> -	/* Decrementer Interrupt */
> +	/* Decremented Interrupt */

No, the comment matches the macro (or whatever that is).

>  	DECREMENTER_EXCEPTION
> 
>  	/* Fixed Internal Timer Interrupt */


-- 
~Randy

