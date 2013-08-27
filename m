Return-Path: <B42378@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CD8C52C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 12:13:24 +1000 (EST)
Date: Tue, 27 Aug 2013 10:01:08 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v11] ASoC: fsl: Add S/PDIF machine driver
Message-ID: <20130827020107.GB3758@MrMyself>
References: <fac39ed91818630e03f81a5f0cf9ddde0e6a3c3a.1377244995.git.b42378@freescale.com>
 <5217B32C.5070300@wwwdotorg.org>
 <20130823191353.GK25263@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130823191353.GK25263@sirena.org.uk>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de,
 Stephen Warren <swarren@wwwdotorg.org>, s.hauer@pengutronix.de,
 tomasz.figa@gmail.com, rob.herring@calxeda.com, p.zabel@pengutronix.de,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 23, 2013 at 08:13:53PM +0100, Mark Brown wrote:
> On Fri, Aug 23, 2013 at 01:08:28PM -0600, Stephen Warren wrote:
> > On 08/23/2013 02:04 AM, Nicolin Chen wrote:
> > > This patch implements a device-tree-only machine driver for Freescale
> > > i.MX series Soc. It works with spdif_transmitter/spdif_receiver and
> > > fsl_spdif.c drivers.
> 
> > The binding looks reasonable to me now. Thanks.
> 
> Is that a Reviewed-by?

Sir,
I think this patch hasn't been applied yet, already been acked though.
Is there any problem in it?

Thank you.
Nicolin
