Return-Path: <javier@dowhile0.org>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdg1Q6k7YzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 18:07:22 +1000 (AEST)
Received: by mail-it0-x243.google.com with SMTP id i206so4439697ita.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 01:07:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170523133448.4794-1-javier@dowhile0.org>
References: <20170523133448.4794-1-javier@dowhile0.org>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Thu, 1 Jun 2017 10:07:19 +0200
Message-ID: <CABxcv=kC0Bfxsm73x9AY6OiQCEZOafidMT+kv=qUqpqnaMAMaA@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] eeprom: at24: Add OF device ID table
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
 Javier Martinez Canillas <javier@dowhile0.org>,
 =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 Stuart Yoder <stuart.yoder@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
 David Lechner <david@lechnology.com>, Rob Herring <robh+dt@kernel.org>,
 Linux I2C <linux-i2c@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Jackson <mpfj@newflow.co.uk>, Fabio Estevam <fabio.estevam@nxp.com>,
 Simon Horman <horms@verge.net.au>, Michal Simek <michal.simek@xilinx.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Li Yang <leoyang.li@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Florian Larysch <fl@n621.de>, Magnus Damm <magnus.damm@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sekhar Nori <nsekhar@ti.com>,
 Scott Wood <oss@buserror.net>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Joachim Eastwood <manabian@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jason Cooper <jason@lakedaemon.net>, Santosh Shilimkar <ssantosh@kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Hongtao Jia <hongtao.jia@nxp.com>,
 Tony Lindgren <tony@atomide.com>, Paul Mackerras <paulus@samba.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Dinh Nguyen <dinguyen@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Wolfram,

On Tue, May 23, 2017 at 3:34 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
>
> This series is a follow-up to patch [0] that added an OF device ID table
> to the at24 EEPROM driver. As you suggested [1], this version instead of
> adding entries for every used <vendor,device> tuple, only adds a single
> entry for each chip type using the "atmel" vendor as a generic fallback.
>
> The first patch documents in the DT binding what's the correct vendor to
> use and what are the ones that are being deprecated. The second one adds
> the OF device ID table for the at24 driver and the next patches use this
> vendor in the compatible string to each DTS that defines a compatible I2C
> EEPROM device node.
>
> Patches can be applied independently since the DTS changes without driver
> changes are no-op and the OF table won't be used without the DTS changes.
>
> [0]: https://lkml.org/lkml/2017/3/14/589
> [1]: https://lkml.org/lkml/2017/3/15/99
>

Any comments on this series?

Best regards,
Javier
