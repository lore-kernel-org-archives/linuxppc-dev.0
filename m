Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3BBAC2C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 04:27:01 +1000 (EST)
Message-ID: <5215066D.5030603@wwwdotorg.org>
Date: Wed, 21 Aug 2013 12:26:53 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v10 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
References: <cover.1377054540.git.b42378@freescale.com>
 <03182ed7464c156ec6345194d3f7ec920f753c2f.1377054540.git.b42378@freescale.com>
In-Reply-To: <03182ed7464c156ec6345194d3f7ec920f753c2f.1377054540.git.b42378@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, festevam@gmail.com,
 s.hauer@pengutronix.de, timur@tabi.org, rob.herring@calxeda.com,
 tomasz.figa@gmail.com, broonie@kernel.org, p.zabel@pengutronix.de,
 R65777@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/20/2013 09:13 PM, Nicolin Chen wrote:
> This patch implements a device-tree-only CPU DAI driver for Freescale
> S/PDIF controller that supports stereo playback and record feature.

The DT bindings part of this patch,
Acked-by: Stephen Warren <swarren@nvidia.com>
