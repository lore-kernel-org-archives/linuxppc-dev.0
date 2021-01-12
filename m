Return-Path: <SRS0=j7bs=GP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6886C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Jan 2021 18:51:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDEC522C9F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Jan 2021 18:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEC522C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DFfnB6Jt1zDrBk
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 05:51:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=WiSTIs/5; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DFfkX1gftzDqrC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2021 05:49:23 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id F14B022B4B;
 Tue, 12 Jan 2021 18:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610477361;
 bh=+wilW7PR6EUwuOxtL99UfUGxy2Y3s4HM648aqDLGvwQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WiSTIs/5MU3rCUxPQxxY/GuKYx1VicPZeMoEfe9QgXpL6SNF2KfL2sxOGcKTFPnvq
 zSCMSDbeHOt2/UyUpwPt6m4obluPhqZKH2mSGyEEhnrhSrgiLfRv6NvM2AjZIjMEjE
 fyPy8uYlPfq+CHXXns6yleUqwKsP6nalVhu2sA/4+8GTGuve3q6C4yyKSmG0GIw4x1
 LkysKVr0ypvfhDlGvovfK0QGiTRV84Q7LFIbaeIB6z4cvj89h4xteLNFfb8mhPptqF
 BMHPGvKmpBVsqnpUyan7x5MjXsyJyqeXkKjANBcLIcqkEMIWjvMcLF0j+JX4Ujry4N
 XsSS0/5UigVPw==
Date: Tue, 12 Jan 2021 18:48:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] ASoC: imx-hdmi: Fix warning of the uninitialized
 variable ret
Message-ID: <20210112184848.GG4646@sirena.org.uk>
References: <1608115464-18710-1-git-send-email-shengjiu.wang@nxp.com>
 <20210112181949.GA3241630@ubuntu-m3-large-x86>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6BvahUXLYAruDZOj"
Content-Disposition: inline
In-Reply-To: <20210112181949.GA3241630@ubuntu-m3-large-x86>
X-Cookie: Stay away from hurricanes for a while.
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
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
 tiwai@suse.com, perex@perex.cz, nicoleotsuka@gmail.com, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--6BvahUXLYAruDZOj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 12, 2021 at 11:19:49AM -0700, Nathan Chancellor wrote:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> >
> > Signed-off-by: shengjiu wang <shengjiu.wang@nxp.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---

> I still see a warning in v5.11-rc3 that is fixed by this patch, is it
> not going in this release cycle? It is a regression fix, seems like it
> should.

This is a random warning fix, why would you expect it to be sent as a
bug fix?  This is the first indication I've seen that anyone is seeing
it in mainline, in general the people who report and fix warnings are
doing so based on -next and the patch seems to be from a month ago.  I
don't have this in my inbox so I assume it's applied already or needs to
be resubmitted anyway.

--6BvahUXLYAruDZOj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/97w8ACgkQJNaLcl1U
h9C44Qf/bxW+CXB4DwJTofrPuzVBuAQ6vUrmIqtZSde3b3oZ60V4fS3Weuw63ihH
QkztqOp+rn7uoHY3X1+XDUwi4+suPoag7X04Q8EKvLyhtovjOZP0Tp+gC+FXEPad
SM9gdRlMJLyJoVQSvjzJueO9vkXLy9OZoq73zH444VcmzTzGXP6Bz5wug2m9LHC2
rMEMY3mbhLDLD9zGqL/CVE5OOsFHRfAlqWb+QMJaa9QY+IrPri8XqO72mNceYFbg
grmrNQjES0IvzOa+7mxrK58M/L6iT+m9LybUHxxxINucdDdEYMV5hIY1OLzretHi
4BhzHK5m28Q8w3p+a7ZXY2D59aZbOg==
=DgaF
-----END PGP SIGNATURE-----

--6BvahUXLYAruDZOj--
