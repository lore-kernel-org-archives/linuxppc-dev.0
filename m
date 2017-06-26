Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxDjL5G7DzDr26
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 02:17:26 +1000 (AEST)
Received: by mail-io0-x243.google.com with SMTP id h134so511965iof.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 09:17:26 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CAOMZO5AWgPv6bOFjpt4vC1PSMNpC+dpR2A90+fc2Z_uojoUAmA@mail.gmail.com>
References: <1498489947-17272-1-git-send-email-madalin.bucur@nxp.com>
 <CAOMZO5AWgPv6bOFjpt4vC1PSMNpC+dpR2A90+fc2Z_uojoUAmA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Jun 2017 18:17:22 +0200
Message-ID: <CAMuHMdW54XAVGvx14286Ot5itGoTPPfaWA75fJH4PhVz9UQwUQ@mail.gmail.com>
Subject: Re: [PATCH] fsl/fman: add dependency on HAS_DMA
To: Fabio Estevam <festevam@gmail.com>
Cc: madalin.bucur@nxp.com, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 26, 2017 at 5:20 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Jun 26, 2017 at 12:12 PM, Madalin Bucur <madalin.bucur@nxp.com> wrote:
>> A previous commit inserted a dependency on DMA API that requires
>> HAS_DMA to be added in Kconfig.
>
> It would be nice to specify the commit that caused this.

That would be commit 5567e989198b5a8d ("fsl/fman: propagate dma_ops").

However, none of the fman code uses any DMA API calls, so IMHO
the set_dma_ops() should be done somewhere else.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
