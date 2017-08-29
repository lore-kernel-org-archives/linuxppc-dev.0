Return-Path: <javier@dowhile0.org>
Received: from mail-io0-x22f.google.com (mail-io0-x22f.google.com
 [IPv6:2607:f8b0:4001:c06::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhMcr4GQ9zDqYG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 18:44:12 +1000 (AEST)
Received: by mail-io0-x22f.google.com with SMTP id 81so15070491ioj.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 01:44:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170828160121.gu4wf7jqu4ditksc@ninjato>
References: <20170615185418.13980-1-javier@dowhile0.org>
 <20170731153009.xkjknygpmckv2pfp@ninjato>
 <CABxcv=mdbE0QGjoi3aLzxRqM3-MbkQ_Ai6fShcGVUGSNNqqrqw@mail.gmail.com>
 <20170828160121.gu4wf7jqu4ditksc@ninjato>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Tue, 29 Aug 2017 10:44:09 +0200
Message-ID: <CABxcv=kSiqDN1=9fSfLkyW=uuXQZAoW4dhw=fco9RyOdDuPAdA@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 00/16] eeprom: at24: Add OF device ID table
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
 Florian Larysch <fl@n621.de>, David Lechner <david@lechnology.com>,
 Rob Herring <robh+dt@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
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

On Mon, Aug 28, 2017 at 6:01 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > But there is a dependency, no? If I apply the driver patch,
>> > non-converted device trees will not find their eeproms anymore. So, I
>>
>> I don't think that's correct. If you apply this patch before the DTS
>> changes, the driver will still match using the I2C device ID table
>> like it has been doing it until today.
>
> My tests do not confirm this. If I add a node with a "renesas,24c01"
> compatible to my board, it works before your patch, but not after. If I
> change it to "atmel,24c01" it works even after your patch. I haven't
> looked into it, though, maybe i2c_of_match_device_sysfs() is stepping on
> our foots here?
>
> Did you test and did it work for you?
>

I would swear that I tested both combinations (driver patch without DT
changes and DTS changes without driver patch), but it was months ago
when I first posted the patches so I may misremembering.

I don't have a DT based system at hand now, but I'll test it again and
let you know probably tomorrow.

Best regards,
Javier
