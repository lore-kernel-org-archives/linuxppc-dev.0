Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC8cH5s2czDrTy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 18:01:19 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id f66so3908980iof.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 01:01:19 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20170718214339.7774-49-robh@kernel.org>
References: <20170718214339.7774-49-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Jul 2017 10:01:16 +0200
Message-ID: <CAMuHMdUzoTMV3qvFckzHMDt6Xk8G9-PJDeVu-PCN-XhwUQx_uw@mail.gmail.com>
Subject: Re: [PATCH] soc: Convert to using %pOF instead of full_name
To: Rob Herring <robh@kernel.org>
Cc: "arm@kernel.org" <arm@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Scott Wood <oss@buserror.net>,
 Qiang Zhao <qiang.zhao@nxp.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
 Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linux-mediatek@lists.infradead.org,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 18, 2017 at 11:43 PM, Rob Herring <robh@kernel.org> wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
