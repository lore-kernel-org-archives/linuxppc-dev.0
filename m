Return-Path: <SRS0=MBk5=EB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6101DC4363A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2020 13:34:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81BCA206DD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2020 13:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYC1/7QI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BCA206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CKbR93w6PzDqHq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 00:34:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=sYC1/7QI; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CKbLD1j65zDqHS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2020 00:30:11 +1100 (AEDT)
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0EB0624641;
 Mon, 26 Oct 2020 13:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603719008;
 bh=47xZnNmgaWb2Nvry34Wr0Gg1IlbyBbZg6E0TRu2Og8U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sYC1/7QI8zplIgXIdmH+wo8zWU0rdI7LtnjUjK9PriIjHJka+pxMljrbGIEGcjpJ0
 HDpl8AcGB6iuB+R8Q1SwfdWqvIymNTn4VmxiY0kDQei4uVUCjqj96VDBcnOv36RiTH
 NlNQV4mCEqg64Iv5xk3NrhwW3oTlHPWK4Ccl+LOY=
Date: Mon, 26 Oct 2020 13:30:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 2/2] ASoC: fsl_aud2htx: Add aud2htx module driver
Message-ID: <20201026133003.GD7402@sirena.org.uk>
References: <1603708855-2663-1-git-send-email-shengjiu.wang@nxp.com>
 <1603708855-2663-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qGV0fN9tzfkG3CxV"
Content-Disposition: inline
In-Reply-To: <1603708855-2663-2-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Safety Third.
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, timur@kernel.org,
 Xiubo.Lee@gmail.com, lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org,
 tiwai@suse.com, perex@perex.cz, nicoleotsuka@gmail.com, robh+dt@kernel.org,
 festevam@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 26, 2020 at 06:40:55PM +0800, Shengjiu Wang wrote:

> +static int fsl_aud2htx_hw_params(struct snd_pcm_substream *substream,
> +				 struct snd_pcm_hw_params *params,
> +				 struct snd_soc_dai *cpu_dai)
> +{
> +	struct fsl_aud2htx *aud2htx = snd_soc_dai_get_drvdata(cpu_dai);
> +
> +	/* DMA request when number of entries < WTMK_LOW */
> +	regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> +			   AUD2HTX_CTRE_DT_MASK, 0);
> +
> +	/* Disable interrupts*/
> +	regmap_update_bits(aud2htx->regmap, AUD2HTX_IRQ_MASK,
> +			   AUD2HTX_WM_HIGH_IRQ_MASK |
> +			   AUD2HTX_WM_LOW_IRQ_MASK |
> +			   AUD2HTX_OVF_MASK,
> +			   AUD2HTX_WM_HIGH_IRQ_MASK |
> +			   AUD2HTX_WM_LOW_IRQ_MASK |
> +			   AUD2HTX_OVF_MASK);
> +
> +	/* Configur watermark */
> +	regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> +			   AUD2HTX_CTRE_WL_MASK,
> +			   AUD2HTX_WTMK_LOW << AUD2HTX_CTRE_WL_SHIFT);
> +	regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> +			   AUD2HTX_CTRE_WH_MASK,
> +			   AUD2HTX_WTMK_HIGH << AUD2HTX_CTRE_WH_SHIFT);
> +	return 0;
> +}

This doesn't look like a hw_params operation - it doesn't appear to
reference the params at all, or even containt any conditional
statements.  Shouldn't this be configured just once at driver load?

--qGV0fN9tzfkG3CxV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+Wz1sACgkQJNaLcl1U
h9BRkgf9GJDUVG/3LsgNUi10w457aA3PPnnK/cZnW28xpxfqtNNpZ2+HycVG+ky1
qwJAezTyWBG+OP2aZy3h8F68htNT3KqgkybywSCjdE8/wSqvTT42KTRDbqJuhr1F
Mnx1+Opres2oQkJqcTUqUkcnIc4gSSZYR9vzzUF7oRPgxF6AKTFLwFfDSsve8Nds
b1oJ6xeiAXrNZM+S1+ESvuaSlZzrK3fL00OxgFG0IjELhy+Wcasf+5QKbiego3BK
2PcYrQjRLqXCqXOw9ABpKZWUqruNAf6JuRryoGETL+OPP2uXRuwh5lXIhUKfNosa
tv1qtawmZN4dyUUGxBPWVV44Lf1FPw==
=1hAM
-----END PGP SIGNATURE-----

--qGV0fN9tzfkG3CxV--
