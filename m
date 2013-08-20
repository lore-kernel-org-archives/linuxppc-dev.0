Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 281692C0102
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 05:01:01 +1000 (EST)
Message-ID: <5213BCDF.2010705@wwwdotorg.org>
Date: Tue, 20 Aug 2013 13:00:47 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Nicole Otsuka <nicoleotsuka@gmail.com>
Subject: Re: [alsa-devel] [PATCH v9 2/2] ASoC: fsl: Add S/PDIF machine driver
References: <cover.1376972170.git.b42378@freescale.com>
 <ede222d17047e863da34a78069ceead2668bd5d2.1376972170.git.b42378@freescale.com>
 <52139680.1010800@wwwdotorg.org>
 <CAGoOwPQ_7F1-3AetKBF35pwO_-LNY6yUtx_r8Mn+HZia_WqyoA@mail.gmail.com>
In-Reply-To: <CAGoOwPQ_7F1-3AetKBF35pwO_-LNY6yUtx_r8Mn+HZia_WqyoA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, linuxppc-dev@lists.ozlabs.org,
 s.hauer@pengutronix.de, Nicolin Chen <b42378@freescale.com>, timur@tabi.org,
 rob.herring@calxeda.com, tomasz.figa@gmail.com, broonie@kernel.org,
 p.zabel@pengutronix.de, R65777@freescale.com, shawn.guo@linaro.org,
 festevam@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/20/2013 10:54 AM, Nicole Otsuka wrote:
> Hi Stephen,
> 
> I have a whole changelist in the cover letter (PATCH 0/2). Please take a
> look at it.
> 
> And about the codec dummy things.. I do that only because the codec
> driver's doc say so.

The DT binding document is not meant to be influenced by internal driver
architecture.
