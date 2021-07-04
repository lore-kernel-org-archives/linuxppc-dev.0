Return-Path: <SRS0=zGeg=L4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FBFC07E95
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Jul 2021 13:59:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF894613C1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Jul 2021 13:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF894613C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GHr5j1czDz3bXX
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Jul 2021 23:59:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=qceaWP8b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=qceaWP8b; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GHr582xxhz2yPB
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Jul 2021 23:58:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=g3hdydJBFBCCn6JqsBFpj8zYz33IDGPm9BzSUODFtSQ=; b=qceaWP8bXu3aVqs4WLzfLLbJBP
 C+ZE6vZOXqoJ/HoZn7a23A4uT2p/AaZnrDBpNWcWp6pZjOFMvaaneZNjbpP9G7R0VlydXZA4lsJFk
 lntHShrjl9besVKQJyq5+Cns60cdCdwI48vn/Sl4eUi1H7r0mdZt9Gq1qqYfkfgSgVu3LQzDWRhBr
 JVE21lpsJbImbN91L/3Jw/8f55BS548FQKplksrVtXnFUoHcRuFhwwdJZTjTy/7Z+t1MKTJCh4KIE
 sdST6UdwXX7mtdmAS8690tXhoSA85hyt4GrP1fVJnXM4A1qnPkeGl5fnT3M5uEvAC1LBg3M+CBiz2
 ygC8Dvsg==;
Received: from [2602:306:c5a2:a380:d5cf:ef86:a560:3f26]
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m02dM-009Lo8-H9; Sun, 04 Jul 2021 13:58:13 +0000
Subject: Re: [PATCH] powerpc: Fix spelling mistake "mesages" -> "messages" in
 Kconfig
To: Colin King <colin.king@canonical.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
References: <20210704093846.36972-1-colin.king@canonical.com>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <95c59476-7c97-d689-4a64-06666e25891b@infradead.org>
Date: Sun, 4 Jul 2021 06:58:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210704093846.36972-1-colin.king@canonical.com>
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 7/4/21 2:38 AM, Colin King wrote:
> -	  Enables more verbose log mesages for LV1 hypercall results.
> +	  Enables more verbose log messages for LV1 hypercall results.

Looks good.  Thanks.

Acked by: Geoff Levand <geoff@infradead.org>
