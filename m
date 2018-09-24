Return-Path: <narmstrong@baylibre.com>
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Jtxp36FZzF3JG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 05:07:39 +1000 (AEST)
Received: by mail-wm1-x342.google.com with SMTP id c14-v6so10851340wmb.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 12:07:39 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] drm: meson: use xxxsetbits32
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
 <1537815856-31728-7-git-send-email-clabbe@baylibre.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <9925d909-5f50-499d-744d-f59170e8899a@baylibre.com>
Date: Mon, 24 Sep 2018 21:07:33 +0200
MIME-Version: 1.0
In-Reply-To: <1537815856-31728-7-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Corentin,

On 24/09/2018 21:04, Corentin Labbe wrote:
> This patch convert meson DRM driver to use all xxxsetbits32 functions.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_crtc.c      | 14 ++++---
>  drivers/gpu/drm/meson/meson_dw_hdmi.c   | 33 +++++++++--------
>  drivers/gpu/drm/meson/meson_plane.c     | 13 ++++---
>  drivers/gpu/drm/meson/meson_registers.h |  3 --
>  drivers/gpu/drm/meson/meson_venc.c      | 13 ++++---
>  drivers/gpu/drm/meson/meson_venc_cvbs.c |  4 +-
>  drivers/gpu/drm/meson/meson_viu.c       | 65 +++++++++++++++++----------------
>  drivers/gpu/drm/meson/meson_vpp.c       | 22 +++++------
>  8 files changed, 86 insertions(+), 81 deletions(-)
> 
[...]

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
