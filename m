Return-Path: <narmstrong@baylibre.com>
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JtyM0g5qzF3JL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 05:08:10 +1000 (AEST)
Received: by mail-wr1-x443.google.com with SMTP id s14-v6so20788157wrw.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 12:08:10 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] net: stmmac: dwmac-meson8b: use xxxsetbits32
To: Corentin Labbe <clabbe@baylibre.com>, Gilles.Muller@lip6.fr,
 Julia.Lawall@lip6.fr, agust@denx.de, airlied@linux.ie,
 alexandre.torgue@st.com, alistair@popple.id.au, benh@kernel.crashing.org,
 carlo@caione.org, davem@davemloft.net, galak@kernel.crashing.org,
 joabreu@synopsys.com, khilman@baylibre.com, maxime.ripard@bootlin.com,
 michal.lkml@markovi.net, mpe@ellerman.id.au, mporter@kernel.crashing.org,
 nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org,
 peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org,
 wens@csie.org
Cc: cocci@systeme.lip6.fr, dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
 <1537815856-31728-8-git-send-email-clabbe@baylibre.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <b87baa02-66e7-b855-478a-6d0bb4d39bad@baylibre.com>
Date: Mon, 24 Sep 2018 21:08:04 +0200
MIME-Version: 1.0
In-Reply-To: <1537815856-31728-8-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24/09/2018 21:04, Corentin Labbe wrote:
> This patch convert meson stmmac glue driver to use all xxxsetbits32 functions.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    | 56 +++++++++-------------
>  1 file changed, 22 insertions(+), 34 deletions(-)
> 
[...]

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
