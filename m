Return-Path: <B42378@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 54E9F2C010A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 12:23:11 +1000 (EST)
Date: Wed, 14 Aug 2013 10:09:12 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH v4 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130814020911.GA31651@MrMyself>
References: <1376308870-14232-1-git-send-email-b42378@freescale.com>
 <1376308870-14232-2-git-send-email-b42378@freescale.com>
 <CAOMZO5A7noEb98yuCPY6o2mf-FikFcMYiDLpg3huPKHMO7Fwdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAOMZO5A7noEb98yuCPY6o2mf-FikFcMYiDLpg3huPKHMO7Fwdw@mail.gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de,
 timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org,
 p.zabel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Fabio,

   Thank you for the comments.

On Tue, Aug 13, 2013 at 02:58:26PM -0300, Fabio Estevam wrote:
> On Mon, Aug 12, 2013 at 9:01 AM, Nicolin Chen <b42378@freescale.com> wrote:
> > +Required properties:
> > +
> > +  - compatible : Compatible list, contains "fsl,<chip>-spdif". Using general
> 
> Can't we just use "fsl,fsl-spdif" instead?
> 
> > +  "fsl,fsl-spdif" will get the default SoC type -- imx6q-spdif.
> > +
> 
> I think this is not the usual approach we do with dt.
> 
> > +static const struct of_device_id fsl_spdif_dt_ids[] = {
> > +       { .compatible = "fsl,fsl-spdif", },
> 
> Isn't only the first entry enough here?

I just saw Mark's words as well. So I don't need to change this part right?
But I'd like to add imx35 on it.


> This MODULE_ALIAS name does not match the name you provided earlier:
> 
> .name = "fsl-spdif-dai"
>

I'll fix it in v5.

Best regards,
Nicolin Chen
