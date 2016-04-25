Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ig0-x244.google.com (mail-ig0-x244.google.com
 [IPv6:2607:f8b0:4001:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qtsD53qXZzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 02:31:01 +1000 (AEST)
Received: by mail-ig0-x244.google.com with SMTP id qu10so11651595igc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 09:31:01 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20160425152643.GZ2274@localhost>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
 <1461166339-11109-7-git-send-email-geert+renesas@glider.be>
 <20160425152643.GZ2274@localhost>
Date: Mon, 25 Apr 2016 18:30:58 +0200
Message-ID: <CAMuHMdWsAj2Tmp3hQQAwZaB39j0KM=kcsobf+NtnrAG-aX5ohg@mail.gmail.com>
Subject: Re: [PATCH 06/14] dmaengine: bcm2835: DT spelling
 s/interrupts-names/interrupt-names/
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Vinod Koul <vinod.koul@intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, Tony Lindgren <tony@atomide.com>,
 Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Joe Perches <joe@perches.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 dmaengine@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Vinod,

On Mon, Apr 25, 2016 at 5:26 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Wed, Apr 20, 2016 at 05:32:11PM +0200, Geert Uytterhoeven wrote:
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  Documentation/devicetree/bindings/sound/davinci-mcbsp.txt | 2 +-
>
> This change does not apply for me, can you please split it up and send the
> sound ones thru sound tree

Sorry, I seem to have mixed two unrelated drivers.
Will split and resend...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
