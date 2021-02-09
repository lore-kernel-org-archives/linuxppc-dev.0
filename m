Return-Path: <SRS0=hK36=HL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F02FC433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Feb 2021 22:32:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F8864DEE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Feb 2021 22:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F8864DEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DZyM24M12zDvYK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 09:32:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BKFMhqjR; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DZyK50Bh3zDvY7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2021 09:30:48 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F26A64DCF;
 Tue,  9 Feb 2021 22:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612909845;
 bh=aElboiqUnwR60IIieAwxZ0/UogaCICdYpqt/BDC5xaQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BKFMhqjRdwMrFoFFLkOj2yPtqpuqDT/GMWk+myP7cSptzE+Er4bomoT8tCrcpQCfk
 uHtrZFcQYPbUh4e649w5HEj9scECzBRpVwwqEcylAxQorsP39a76Th42S/+9wtbrYT
 sX/dgfaYhvMT1fW/ay7NRhiqzmKc235luf6B+ocqTQ9qNuoJZb54vmJ1kG792QuYEH
 z0V8030k94Ht4PSKt96eINydx2ReggFZT2PxWEo0rMwcAbhpPFV6ZhzkH2wtY9+f6G
 04LNghwVNW/tjlGCktHNoj3g80Moh7fyFzpZeSyY4X661b4tpC+v4Md3fu75wB+PDR
 wyw3Iy2cgtwOQ==
Date: Tue, 9 Feb 2021 22:29:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: Re: [PATCH v2 2/7] ASoC: fsl_rpmsg: Add CPU DAI driver for audio
 base on rpmsg
Message-ID: <20210209222953.GF4916@sirena.org.uk>
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-3-git-send-email-shengjiu.wang@nxp.com>
 <20210208115112.GD8645@sirena.org.uk>
 <CAA+D8AMRGRRk6FzdiqaHAP1=dPJngNgmdGmU59vrroXA9BMyXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Content-Disposition: inline
In-Reply-To: <CAA+D8AMRGRRk6FzdiqaHAP1=dPJngNgmdGmU59vrroXA9BMyXw@mail.gmail.com>
X-Cookie: Put your trust in those who are worthy.
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 09, 2021 at 05:16:16PM +0800, Shengjiu Wang wrote:
> On Mon, Feb 8, 2021 at 7:53 PM Mark Brown <broonie@kernel.org> wrote:

> > hw_params() can be called multiple times and there's no need for it to
> > be balanced with hw_free(), I'd move this to a different callback (DAPM
> > should work well).

> Which callback should I use? Is there an example?

Like I say I'd actually recommend moving this control to DAPM.

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAjDOAACgkQJNaLcl1U
h9BfxAf/fm751rk1InZcdQUy/P0JjMUL41sYCGQ90Gg1k2R3RCuWuoeTeCO0a0Yb
l474cbyVRak4jHTNNgBjRryRcKW9r/NvV+WOdVVUKdVRJ+PpL3VzFLu0nSll9vDg
aF/J74dcRx2+yj/+Ey8kDwbANEmjGKHdYd9NuJcPcPk+owkE9h0h48n4DpuFucQj
O7anqyPPxnh1mW/gKSE1Sn0f8MhSWelw+xdX5PlWrMw/gbuW+OyAhwt1DyOMgakW
xooN5vm0ALYQtVOM1RnKsKta5TDZjlRkI6Zkv4mojbihSKV/rxTju0sLoblIQ/Ju
0jO/4lAwVhqvokUPYs1HmRwF9Sat4A==
=1sE+
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--
