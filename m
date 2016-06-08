Return-Path: <linus.walleij@linaro.org>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
 [209.85.218.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPnVd1z69zDqp9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 22:16:57 +1000 (AEST)
Received: by mail-oi0-f48.google.com with SMTP id k23so9310795oih.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 05:16:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1465321121-22238-6-git-send-email-peter.griffin@linaro.org>
References: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
 <1465321121-22238-6-git-send-email-peter.griffin@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 8 Jun 2016 14:15:55 +0200
Message-ID: <CACRpkdaFhAbWtoOmmK4m-MaQsNgPya4mEOmAUDZmNNxvRotY3A@mail.gmail.com>
Subject: Re: [PATCH 5/8] dmaengine: ste_dma40: Only calculate residue if
 txstate exists.
To: Peter Griffin <peter.griffin@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:ARM/STI ARCHITECTURE" <kernel@stlinux.com>,
 Vinod Koul <vinod.koul@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Leo Li <leoli@freescale.com>,
 Zhang Wei <zw@zh-kernel.org>, Barry Song <baohua@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>,
 Laxman Dewangan <ldewangan@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Alexandre Courbot <gnurou@gmail.com>, Lee Jones <lee.jones@linaro.org>,
 dmaengine@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 7, 2016 at 7:38 PM, Peter Griffin <peter.griffin@linaro.org> wrote:

> There is no point calculating the residue if there is
> no txstate to store the value.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
