Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A117B2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 04:21:36 +1000 (EST)
Message-ID: <521F9129.5010805@wwwdotorg.org>
Date: Thu, 29 Aug 2013 12:21:29 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v12] ASoC: fsl: Add S/PDIF machine driver
References: <1377662686-31696-1-git-send-email-b42378@freescale.com>
In-Reply-To: <1377662686-31696-1-git-send-email-b42378@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, s.hauer@pengutronix.de,
 tomasz.figa@gmail.com, rob.herring@calxeda.com, broonie@kernel.org,
 p.zabel@pengutronix.de, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/27/2013 10:04 PM, Nicolin Chen wrote:
> This patch implements a device-tree-only machine driver for Freescale
> i.MX series Soc. It works with spdif_transmitter/spdif_receiver and
> fsl_spdif.c drivers.

Sorry for the slow response. For the record, the binding,
Acked-by: Stephen Warren <swarren@nvidia.com>
