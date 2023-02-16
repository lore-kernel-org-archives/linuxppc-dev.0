Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0A6C636D4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Feb 2023 02:21:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PHJbK348Lz3cjC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Feb 2023 13:21:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=T214lDYw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=T214lDYw;
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PHJZD0Ncwz3cCn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2023 13:20:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=kSGA/MlD2Xuj25JeBde+v37M89+xiA/8ymC62wNi/ao=; b=T214lDYwlH/i6uBH6BNzlCk6rx
	4nxUsEUyOjm+8Jmw+aXlMddrYn/laIc6xaoE+fU4xLZAbrRZBTC3LQERXZaHxqyaq3W1za55ImRLb
	oRJqgBk2bbAoKusoW8hJcWVjQvwN/GXXKPpP0KEx9Me1zbsMO5aAoQq3UZbhtS09vh3lJ5OBp+3p+
	ucDo5hPWB04m3UQNM2QNgXI+pMV5gVhPCK4n5Ey/HKW4DMh6xGS2Wb429iqZu0yUjZCOn2o30ASdw
	RjRw82BdCQgPjZHS1lWtlsnK8erByUyCysDqb5Q5dNk6Fbck51RiTbxF3aanEJLBMetCqMtAWFXLh
	C3zLEGgA==;
Received: from [2601:1c2:980:9ec0::df2f]
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSTsb-008HVN-8k; Thu, 16 Feb 2023 02:20:13 +0000
Message-ID: <1ea2a91a-c724-04b2-6154-d0797273552c@infradead.org>
Date: Wed, 15 Feb 2023 18:20:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] usb: fix some spelling mistakes in comment of gadget
Content-Language: en-US
To: Zhou nan <zhounan@nfschina.com>, leoyang.li@nxp.com,
 gregkh@linuxfoundation.org
References: <20230216013535.6399-1-zhounan@nfschina.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230216013535.6399-1-zhounan@nfschina.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 2/15/23 17:35, Zhou nan wrote:
> usb: Fix spelling mistake in comments of gadget.
> 
> Signed-off-by: Zhou nan <zhounan@nfschina.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> v2:
> - Modify the title and description text.
> ---
>  drivers/usb/gadget/udc/fsl_udc_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)


-- 
~Randy
