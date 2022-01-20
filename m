Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95176C433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jan 2022 06:30:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JfXgX5C8Mz3cB0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jan 2022 17:30:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=gW8o1nPn;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JfXfq0Qskz2ymt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2022 17:29:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=gW8o1nPn; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4JfXfl22hFz4y3h;
 Thu, 20 Jan 2022 17:29:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1642660177;
 bh=R8Lod9NCI3CxXO/2uoFfkneQILqcaNlu86/osFgCPZw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=gW8o1nPnWaSH1pl/Q48PFuObAFuQuO44Q1u+3v7D0bT8MRNn9d67w3bhfzPNngK/L
 eMahvidGZXdGUDyOmAZ75zHT3iSfy+LFaSreoZYPsNsSj7H76oAuPO5oGSfc+dduTo
 iaOexIEQXOnU9b0BBHXIC7oH/W2A4gY8gamLFzQCZF5DicbhrHCBiQGptGOSuz0Lnv
 yEks+86Pe2rnmuPaxzrBzPS5BYLviPiPlr3wvcjIG74WkbnS6I41KADbc4o6eLJxGA
 8JWYs+M6lyOtIzrVTZffJ8b6Ft9heTlm1oFoYLIww2OzIO4Ns2nPEW/A9ICbivLrxC
 FQn2VQ4J3YZ4w==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Maxim <bigunclemax@gmail.com>, vladimir.oltean@nxp.com
Subject: Re: [PATCH v2] powerpc: dts: t1040rdb: fix ports names for Seville
 Ethernet switch
In-Reply-To: <20220111173723.26212-1-bigunclemax@gmail.com>
References: <20220111152947.6zvt7j7366wsg6o2@skbuf>
 <20220111173723.26212-1-bigunclemax@gmail.com>
Date: Thu, 20 Jan 2022 17:29:31 +1100
Message-ID: <87czkmudh0.fsf@mpe.ellerman.id.au>
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
Cc: andrew@lunn.ch, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 fido_max@inbox.ru, robh+dt@kernel.org, paulus@samba.org, bigunclemax@gmail.com,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Maxim <bigunclemax@gmail.com> writes:
> From: Maxim Kiselev <bigunclemax@gmail.com>
>
> On board rev A, the network interface labels for the switch ports
> written on the front panel are different than on rev B and later.
>
> This patch fixes network interface names for the switch ports according
> to labels that are written on the front panel of the board rev B.
> They start from ETH3 and end at ETH10.
>
> This patch also introduces a separate device tree for rev A.
> The main device tree is supposed to cover rev B and later.
>
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
> Reviewed-by: Maxim Kochetkov <fido_max@inbox.ru>
> ---
>  arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts | 30 ++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/t1040rdb.dts       |  8 +++---
>  2 files changed, 34 insertions(+), 4 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts

I applied this but it generated errors, you should have got some reports
from the kernel build robot.

cheers
