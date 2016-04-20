Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-io0-x244.google.com (mail-io0-x244.google.com
 [IPv6:2607:f8b0:4001:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqmGj6c92zDqZQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 01:37:32 +1000 (AEST)
Received: by mail-io0-x244.google.com with SMTP id z133so7447425iod.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 08:37:32 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
Date: Wed, 20 Apr 2016 17:37:30 +0200
Message-ID: <CAMuHMdUUCJEAyhstdi1oxJXmyOh5wFbsE1JiaMs4f2ojGwSoig@mail.gmail.com>
Subject: Re: [PATCH 00/14] DT: Fix spelling of standard properties
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
 Tony Lindgren <tony@atomide.com>,
 Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Vinod Koul <vinod.koul@intel.com>,
 Mark Brown <broonie@kernel.org>,
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

On Wed, Apr 20, 2016 at 5:32 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> This patch series fixes misspellings of various standard DT properties
> in DT binding documentation, DTS files, and error messages.

BTW, this is against next-20160420.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
