Return-Path: <SRS0=qxeE=IM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4ABC433DB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 16:18:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8253064E66
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 16:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8253064E66
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dz4Tf4Mc8z3cXq
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 03:17:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=merlin.20170209 header.b=aaJt/VQm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1234::107; helo=merlin.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=merlin.20170209 header.b=aaJt/VQm; 
 dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1234::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dz4T94B0Jz30M9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Mar 2021 03:17:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=h3oKT2DIWMi/3UOnem0PmyfrJuvNhkM34vsZ5Qcbs8I=; b=aaJt/VQm3LY5XSCT8IZoqz6Dfu
 RHGD6IcX8kOz4lYEBQzKW4vqCWhl54QfBJZc9YSopxtB289Mz+vP4k/TtDE7uKtCSOpaamIDgWdl4
 J3H9wB23k/bWDyfxP7ATLI6a2NWh+nr14Fsm51QhmRLKaXavPYq9c7JFOuflxxb+e9H+sjk9GmEpQ
 iJCDlH2ynfGFS5JMDOP3i3E/sIipk5T9KcQr7AC9Z2PwsYKjQMgdIYnxXAzYthOStEnVY5MWCPmM8
 XySCxYCSylV8VdUCjv0wf8OaEiaimRs/D9Hx8sj6U5xD7XqIupipP+irq5s+uUddNVb0unAyV7Vcb
 DbiHgJOQ==;
Received: from [2601:1c0:6280:3f0::9757]
 by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lLTQf-001DPd-Ni; Sun, 14 Mar 2021 16:17:22 +0000
Subject: Re: [PATCH] soc: fsl: guts: fix comment syntax in file
To: Aditya Srivastava <yashsri421@gmail.com>, leoyang.li@nxp.com
References: <20210314072828.9270-1-yashsri421@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1cab34f0-dcd1-b8ff-6bab-38ff9adc94b5@infradead.org>
Date: Sun, 14 Mar 2021 09:17:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210314072828.9270-1-yashsri421@gmail.com>
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
Cc: lukas.bulwahn@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/13/21 11:28 PM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for kernel-doc comments.
> There are certain comments in include/linux/fsl/guts.h which follows this
> syntax, but the content inside does not comply with kernel-doc.
> 
> E.g., opening comment for "Freecale 85xx and 86xx Global Utilties
> register set" follows kernel-doc syntax(i.e., '/**'), but the content
> inside does not comply with any kernel-doc specification (function,
> struct, etc).
> 
> This causes unwelcomed warning from kernel-doc:
> "warning: expecting prototype for Freecale 85xx and 86xx Global Utilties register set(). Prototype was for __FSL_GUTS_H__() instead"
> 
> Replace all such comment occurrences with general comment format,
> i.e. '/*' to pervent kernel-doc from parsing these.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> * Applies perfectly on next-20210312
> 
>  include/linux/fsl/guts.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/fsl/guts.h b/include/linux/fsl/guts.h
> index 0ac27b233f12..fdb55ca47a4f 100644
> --- a/include/linux/fsl/guts.h
> +++ b/include/linux/fsl/guts.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-or-later */
> -/**
> +/*
>   * Freecale 85xx and 86xx Global Utilties register set
>   *
>   * Authors: Jeff Brown
> @@ -14,7 +14,7 @@
>  #include <linux/types.h>
>  #include <linux/io.h>
>  
> -/**
> +/*
>   * Global Utility Registers.
>   *
>   * Not all registers defined in this structure are available on all chips, so
> 


-- 
~Randy

