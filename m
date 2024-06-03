Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7328C25B76
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jun 2024 15:57:14 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VljIBWF+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VtJJS6QmSz3ccN
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Jun 2024 01:57:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VljIBWF+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VtJHb2prRz3cXh
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jun 2024 01:56:27 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B34D560ED4;
	Mon,  3 Jun 2024 15:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EADC2BD10;
	Mon,  3 Jun 2024 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717430179;
	bh=futJcvAhuekfJi6Omn7IDi2rhi/asO2I+BKkZvgElD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VljIBWF+dF5NH50qa7/pjnUwX8u4zmTFEdKqAtElPselZAWfTQWGquNldjtc6QorB
	 xLJIRbYv5GblmgpQVMRgzkud0jMZaO/wXyoaFCxSL4YB/8kVpXIB6/BuMirHRkTtQA
	 PSwe4ewy560D80s3uy6x9rz1FK439Z+Fjv4dSs7z5/XwT6JkLHsQnvTUjlfRObv9oH
	 O6qA5r4omEBw06am6z03aXxwI/2OCfK4uyvmypWvQ9Z2lVn7LpnAMTWZYSOoQ0xuzv
	 cli7XbUcMs7hjGScsIeJYyAx4Y3ejoybgJyEDZOCWNKhtIrpVqoFDQ1fYFJUDi1fyH
	 4IYRNNw9eqabQ==
Date: Mon, 3 Jun 2024 10:56:16 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v4 1/2] ASoC: dt-bindings: fsl,xcvr: Add compatible
 string for i.MX95
Message-ID: <171743017410.508888.18301786325836336214.robh@kernel.org>
References: <1716972002-2315-1-git-send-email-shengjiu.wang@nxp.com>
 <1716972002-2315-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716972002-2315-2-git-send-email-shengjiu.wang@nxp.com>
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
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, lgirdwood@gmail.com, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, tiwai@suse.com, nicoleotsuka@gmail.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On Wed, 29 May 2024 16:40:01 +0800, Shengjiu Wang wrote:
> Add compatible string "fsl,imx95-xcvr" for i.MX95 platform.
> 
> The difference between each platform is in below table.
> 
> +---------+--------+----------+--------+
> |  SOC	  |  PHY   | eARC/ARC | SPDIF  |
> +---------+--------+----------+--------+
> | i.MX8MP |  V1    |  Yes     |  Yes   |
> +---------+--------+----------+--------+
> | i.MX93  |  N/A   |  N/A     |  Yes   |
> +---------+--------+----------+--------+
> | i.MX95  |  V2    |  N/A     |  Yes   |
> +---------+--------+----------+--------+
> 
> On i.MX95, there are two PLL clock sources, they are the parent
> clocks of the XCVR root clock. one is for 8kHz series rates, named
> as 'pll8k', another one is for 11kHz series rates, named as 'pll11k'.
> They are optional clocks, if there are such clocks, then the driver
> can switch between them to support more accurate sample rates.
> 
> As 'pll8k' and 'pll11k' are optional, then add 'minItems: 4' for
> clocks and clock-names properties.
> 
> On i.MX95, the 'interrupts' configuration has the same constraint
> as i.MX93.
> 
> Only on i.MX8MP, the 'resets' is required, but for i.MX95 and i.MX93
> there is no such hardware setting.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,xcvr.yaml   | 32 ++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

