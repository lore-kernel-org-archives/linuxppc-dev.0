Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C786AC0502C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Aug 2022 13:19:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MHlCD2hjRz3c6r
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:52 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MHl6M4MKQz3c6Z
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2022 23:15:39 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4MHl6L1w6Lz4xGS;
	Wed, 31 Aug 2022 23:15:38 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-spi@vger.kernel.org
In-Reply-To: <20220824082130.21934-1-wsa+renesas@sang-engineering.com>
References: <20220824082130.21934-1-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 0/2] spi: remove "spidev" nodes from DTs
Message-Id: <166195164122.45984.7055398708417257507.b4-ty@ellerman.id.au>
Date: Wed, 31 Aug 2022 23:14:01 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 24 Aug 2022 10:21:27 +0200, Wolfram Sang wrote:
> There were two DTs left specifying "spidev" directly. Remove them.
> 
> Wolfram Sang (2):
>   ARM: dts: stm32: argon: remove spidev node
>   powerpc/82xx: remove spidev node from mgcoge
> 
> arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi | 6 ------
>  arch/powerpc/boot/dts/mgcoge.dts                 | 7 -------
>  2 files changed, 13 deletions(-)
> 
> [...]

Patch 2 applied to powerpc/next.

[2/2] powerpc/82xx: remove spidev node from mgcoge
      https://git.kernel.org/powerpc/c/fd20b60aea6a37788f2f761af405b41c6c34473b

cheers
