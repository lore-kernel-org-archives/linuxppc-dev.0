Return-Path: <SRS0=Gm8F=VT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEB9C76194
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jul 2019 13:24:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26AE218DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jul 2019 13:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26AE218DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45sj4T4MZzzDqHg
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jul 2019 23:24:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=pengutronix.de
 (client-ip=2001:67c:670:201:290:27ff:fe1d:cc33; helo=metis.ext.pengutronix.de;
 envelope-from=l.stach@pengutronix.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45shdf1qMczDqGP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2019 23:04:21 +1000 (AEST)
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <l.stach@pengutronix.de>)
 id 1hpXz6-0005yy-7y; Mon, 22 Jul 2019 15:04:08 +0200
Message-ID: <1563800647.2311.13.camel@pengutronix.de>
Subject: Re: [PATCH 10/10] ASoC: fsl_sai: Add support for imx7ulp/imx8mq
From: Lucas Stach <l.stach@pengutronix.de>
To: Daniel Baluta <daniel.baluta@nxp.com>, broonie@kernel.org
Date: Mon, 22 Jul 2019 15:04:07 +0200
In-Reply-To: <20190722124833.28757-11-daniel.baluta@nxp.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
 <20190722124833.28757-11-daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linuxppc-dev@lists.ozlabs.org
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
Cc: alsa-devel@alsa-project.org, viorel.suman@nxp.com, timur@kernel.org,
 Xiubo.Lee@gmail.com, linuxppc-dev@lists.ozlabs.org, shengjiu.wang@nxp.com,
 angus@akkea.ca, tiwai@suse.com, perex@perex.cz, nicoleotsuka@gmail.com,
 linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Am Montag, den 22.07.2019, 15:48 +0300 schrieb Daniel Baluta:
> SAI module on imx7ulp/imx8m features 2 new registers (VERID and PARAM)
> at the beginning of register address space.
> 
> On imx7ulp FIFOs can held up to 16 x 32 bit samples.
> On imx8mq FIFOs can held up to 128 x 32 bit samples.
> 
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index f2441b84877e..b05837465b5a 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -1065,10 +1065,24 @@ static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
> >  	.reg_offset = 0,
>  };
>  
> +static const struct fsl_sai_soc_data fsl_sai_imx7ulp_data = {
> > +	.use_imx_pcm = true,
> > +	.fifo_depth = 16,
> > +	.reg_offset = 8,
> +};
> +
> +static const struct fsl_sai_soc_data fsl_sai_imx8mq_data = {
> > +	.use_imx_pcm = true,
> > +	.fifo_depth = 128,
> > +	.reg_offset = 8,
> +};
> +
>  static const struct of_device_id fsl_sai_ids[] = {
> >  	{ .compatible = "fsl,vf610-sai", .data = &fsl_sai_vf610_data },
> >  	{ .compatible = "fsl,imx6sx-sai", .data = &fsl_sai_imx6sx_data },
> >  	{ .compatible = "fsl,imx6ul-sai", .data = &fsl_sai_imx6sx_data },
> > +	{ .compatible = "fsl,imx7ulp-sai", .data = &fsl_sai_imx7ulp_data },
> > +	{ .compatible = "fsl,imx8mq-sai", .data = &fsl_sai_imx8mq_data },
> > 
Those two new compatibles need to be documented in the DT bindings.

Regards,
Lucas
