Return-Path: <SRS0=LwoU=45=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F3AC10DCE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2020 17:48:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F05206B1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2020 17:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F05206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48dbsK4KgwzDqJM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2020 04:48:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=mark.brown@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 48dbqK4ZQBzDqJm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2020 04:46:34 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C597930E;
 Thu, 12 Mar 2020 10:46:31 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4565A3F67D;
 Thu, 12 Mar 2020 10:46:31 -0700 (PDT)
Date: Thu, 12 Mar 2020 17:46:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v5 4/7] ASoC: fsl_asrc: rename asrc_priv to asrc
Message-ID: <20200312174629.GI4038@sirena.org.uk>
References: <cover.1583725533.git.shengjiu.wang@nxp.com>
 <8282b290d39dd8dae5da02f5cbb3f647fa778aa0.1583725533.git.shengjiu.wang@nxp.com>
 <20200309213016.GC11333@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PWfwoUCx3AFJRUBq"
Content-Disposition: inline
In-Reply-To: <20200309213016.GC11333@Asurada-Nvidia.nvidia.com>
X-Cookie: Security check: INTRUDER ALERT!
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
 tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz, robh+dt@kernel.org,
 festevam@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--PWfwoUCx3AFJRUBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2020 at 02:30:17PM -0700, Nicolin Chen wrote:
> On Mon, Mar 09, 2020 at 11:58:31AM +0800, Shengjiu Wang wrote:
> > In order to move common structure to fsl_asrc_common.h
> > we change the name of asrc_priv to asrc, the asrc_priv
> > will be used by new struct fsl_asrc_priv.

> This actually could be a cleanup patch which comes as the
> first one in this series, so that we could ack it and get
> merged without depending on others. Maybe next version?

Yes, please.  Or even just send it separately.

--PWfwoUCx3AFJRUBq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5qdXQACgkQJNaLcl1U
h9BEJgf+LDZKX86NoQW0sAyHfoI5bU8JDqMp0vov4A8JY6xc4HBhugGfdjg8WRoa
CaqNzRLw0m6VFU+a/AxSv5OADsO1vkjA08+yXeuWr7wKxasqSAmBwq7tjsa9Cu7S
QB0UowCO1N3Zn7zeWYFoJxiJ1iPlz9rUTDLw6U50yckkct9JlCnTKLmPpO7q5SRN
DSqUC5+8Hc/SZGOSKLoYc1SFqFaNLUxuF7O2harTjFRbWeuEaptWcgmf2CeXgtI0
pFBfaexsGndY8dFMvwkNeD74Yctt4xnefQRXwbMsbfhDpJFdruxSXYNkBHYMsIUk
YzSFifSaFrNhKESXNDY0arVypHltMg==
=rfH4
-----END PGP SIGNATURE-----

--PWfwoUCx3AFJRUBq--
