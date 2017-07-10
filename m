Return-Path: <javier@dowhile0.org>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5ck45gC2zDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 17:47:08 +1000 (AEST)
Received: by mail-it0-x242.google.com with SMTP id v193so12020885itc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 00:47:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170615185418.13980-1-javier@dowhile0.org>
References: <20170615185418.13980-1-javier@dowhile0.org>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Mon, 10 Jul 2017 09:47:05 +0200
Message-ID: <CABxcv==J_QwoivZ0PRWMoG-weAp7F-LpEXkBxw_9jwH3ENKjsw@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 00/16] eeprom: at24: Add OF device ID table
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
 Javier Martinez Canillas <javier@dowhile0.org>, Florian Larysch <fl@n621.de>,
 David Lechner <david@lechnology.com>,
 Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
 Simon Horman <horms@verge.net.au>, Michal Simek <michal.simek@xilinx.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Will Deacon <will.deacon@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Sekhar Nori <nsekhar@ti.com>, Scott Wood <oss@buserror.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joachim Eastwood <manabian@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Magnus Damm <magnus.damm@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <kernel@pengutronix.de>,
 Linux I2C <linux-i2c@vger.kernel.org>
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

On Thu, Jun 15, 2017 at 8:54 PM, Javier Martinez Canillas
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

Are you planning to pick this series? It has been in the list for
months and were resent many times...

Best regards,
Javier
