Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AC9522C0077
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 05:53:08 +1000 (EST)
Message-ID: <5217BD9F.1080704@wwwdotorg.org>
Date: Fri, 23 Aug 2013 13:53:03 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v11] ASoC: fsl: Add S/PDIF machine driver
References: <fac39ed91818630e03f81a5f0cf9ddde0e6a3c3a.1377244995.git.b42378@freescale.com>
 <5217B32C.5070300@wwwdotorg.org> <20130823191353.GK25263@sirena.org.uk>
In-Reply-To: <20130823191353.GK25263@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, s.hauer@pengutronix.de,
 Nicolin Chen <b42378@freescale.com>, tomasz.figa@gmail.com,
 rob.herring@calxeda.com, p.zabel@pengutronix.de, shawn.guo@linaro.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/23/2013 01:13 PM, Mark Brown wrote:
> On Fri, Aug 23, 2013 at 01:08:28PM -0600, Stephen Warren wrote:
>> On 08/23/2013 02:04 AM, Nicolin Chen wrote:
>>> This patch implements a device-tree-only machine driver for
>>> Freescale i.MX series Soc. It works with
>>> spdif_transmitter/spdif_receiver and fsl_spdif.c drivers.
> 
>> The binding looks reasonable to me now. Thanks.
> 
> Is that a Reviewed-by?

Sure, it can be,
Acked-by: Stephen Warren <swarren@nvidia.com>
