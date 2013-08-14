Return-Path: <B42378@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BAFFA2C0133
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 15:44:10 +1000 (EST)
Date: Wed, 14 Aug 2013 13:30:17 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [alsa-devel] [PATCH v4 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130814053016.GF31651@MrMyself>
References: <1376308870-14232-1-git-send-email-b42378@freescale.com>
 <1376308870-14232-2-git-send-email-b42378@freescale.com>
 <CAOMZO5A7noEb98yuCPY6o2mf-FikFcMYiDLpg3huPKHMO7Fwdw@mail.gmail.com>
 <20130814032658.GA16915@S2101-09.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130814032658.GA16915@S2101-09.ap.freescale.net>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de,
 linuxppc-dev@lists.ozlabs.org, timur@tabi.org, rob.herring@calxeda.com,
 broonie@kernel.org, p.zabel@pengutronix.de, Fabio Estevam <festevam@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shwan,

On Wed, Aug 14, 2013 at 11:27:00AM +0800, Shawn Guo wrote:
> I do not think we need this general compatible string.  Device tree
> compatible should be specific.

So I should just use 'fsl,<chip>-spdif" and list all <chip>-spdif
in compatible list?

I added 'fsl,fsl-spdif' just for those not-in-list chips, Vybrid
for example. So you think I should add all the possible chips to 
the list? But what if some chip I don't know right now that also
uses this spdif controller? Add them to the list later?

Thank you.
