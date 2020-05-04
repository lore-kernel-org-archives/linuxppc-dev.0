Return-Path: <SRS0=+v6T=6S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92946C3A5A9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2020 10:58:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46EDF20752
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2020 10:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="AgVSNtd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EDF20752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49G0Ff6jlJzDqcq
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2020 20:58:14 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49G0BN1QfVzDqXR
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2020 20:55:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=AgVSNtd0; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49G0BM4Mxtz9sSW;
 Mon,  4 May 2020 20:55:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1588589724;
 bh=VOZJ+41zv/uZ/NKVIx1QgglexMhIon3i+ZhlW+HFNpE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=AgVSNtd0EKpHhqfVc4Qj1yCW1CRAJqnOrCkYbhWJemSwhGz1lczFqdOXMEOaN+Q2l
 orQzsYvlKHQL/k4nRIyf5tisa4q8BsWSNng5IOXVl/dktxlYCr5S9q7O1LDyAo09Rg
 FAyAlgcyiibMSATur+LOPYkj3RhMKfazyhfQJe4kcZFW2lKNFWGHTYCyn2krXDC14m
 /4xrj2GKdLx9wyuEhf6thS+6EwPRk09x924ORpYI4BJUB08slSf2u1crkPTisDCttt
 sFy3XbxWSFZfqqFkUEDwQ3pAGAvvjJuPJVFAq3881KuvjuYpzCEcGh53+W/+jaYhto
 i/IyxTIcKnvgA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/5200: update contact email
In-Reply-To: <20200502142642.18979-1-wsa@kernel.org>
References: <20200502142642.18979-1-wsa@kernel.org>
Date: Mon, 04 May 2020 20:55:41 +1000
Message-ID: <877dxsdl5e.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: devicetree@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 kernel@pengutronix.de, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Wolfram Sang <wsa@kernel.org> writes:
> My 'pengutronix' address is defunct for years. Merge the entries and use
> the proper contact address.

Is there any point adding the new address? It's just likely to bit-rot
one day too.

I figure the git history is a better source for more up-to-date emails.

cheers

> diff --git a/arch/powerpc/boot/dts/pcm032.dts b/arch/powerpc/boot/dts/pcm032.dts
> index c259c6b3ac5a..780e13d99e7b 100644
> --- a/arch/powerpc/boot/dts/pcm032.dts
> +++ b/arch/powerpc/boot/dts/pcm032.dts
> @@ -3,9 +3,7 @@
>   * phyCORE-MPC5200B-IO (pcm032) board Device Tree Source
>   *
>   * Copyright (C) 2006-2009 Pengutronix
> - * Sascha Hauer <s.hauer@pengutronix.de>
> - * Juergen Beisert <j.beisert@pengutronix.de>
> - * Wolfram Sang <w.sang@pengutronix.de>
> + * Sascha Hauer, Juergen Beisert, Wolfram Sang <kernel@pengutronix.de>
>   */
>  
>  /include/ "mpc5200b.dtsi"
> -- 
> 2.20.1
