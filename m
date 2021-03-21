Return-Path: <SRS0=FHsg=IT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF379C433C1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Mar 2021 17:35:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA41C61927
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Mar 2021 17:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA41C61927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F3PsY71hcz304R
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 04:35:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zoso+9Pa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=zoso+9Pa; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F3Ps06zxsz2xxj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Mar 2021 04:34:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=b6kxlAh3fIabeLvigmFVk68R8rwvjb2NK7Orm1rRGAo=; b=zoso+9PaOZXk0kOw2FuTs66wdp
 6ZCwzxl4MbPIgWQNj2SM8rozWv5lm+S1GMySmBVrt3b01r9s335TsV8OW/OsXJi8UV6j6PUHUWDwS
 Qw7UVEJstdbnuL++Qz2UpOfUc8m6D6bjSGE4S/MeUMcEMLj/NrrUbwPPzjKRVcln74+eAh+C5kY9j
 r0sOQqvDKR2rkyhueQH9QgNAQTPCjp3xzMUWSsdVY7SqYdU5pEOB8jJx0pY86V4MrIuIpjtZFBW2f
 8H5cgzZw9b9x83VRXdYwwyIFNiexRHx5KyPuRG1EwLkHIG9xM7b9AdewQTr2fSlzE6gVNlCPNo6Dl
 ktoLcXGQ==;
Received: from rdunlap (helo=localhost)
 by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lO1xw-002QSK-VC; Sun, 21 Mar 2021 17:34:17 +0000
Date: Sun, 21 Mar 2021 10:34:16 -0700 (PDT)
From: Randy Dunlap <rdunlap@infradead.org>
To: Aditya Srivastava <yashsri421@gmail.com>
Subject: Re: [PATCH] crypto: nx: fix incorrect kernel-doc comment syntax in
 files
In-Reply-To: <20210321123007.15505-1-yashsri421@gmail.com>
Message-ID: <84443584-2cbf-5945-2b6-b7a057a72540@infradead.org>
References: <20210321123007.15505-1-yashsri421@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210321_103417_013224_F9F210D0 
X-CRM114-Status: UNSURE (   1.45  )
X-CRM114-Notice: Please train this message.
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
Cc: linuxppc-dev@lists.ozlabs.org, herbert@gondor.apana.org.au, corbet@lwn.net,
 nayna@linux.ibm.com, linux-kernel@vger.kernel.org, pfsmorigo@gmail.com,
 linux-crypto@vger.kernel.org, leitao@debian.org, lukas.bulwahn@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org, davem@davemloft.net,
 paulus@samba.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Looks good. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>


