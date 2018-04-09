Return-Path: <festevam@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KCTF0TrszF0Pc
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 11:31:57 +1000 (AEST)
Received: by mail-oi0-x242.google.com with SMTP id u141-v6so6118009oif.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2018 18:31:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523234034-33018-1-git-send-email-nicoleotsuka@gmail.com>
References: <1523234034-33018-1-git-send-email-nicoleotsuka@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 8 Apr 2018 22:31:54 -0300
Message-ID: <CAOMZO5D-HNjLyLHft4OiTt806ePJvMbuhKZ4yzO07pD2-w4kqA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_esai: Add freq check in
 set_dai_sysclk()
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 8, 2018 at 9:33 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> The freq parameter indicates the physical frequency of an actual
> input clock or a desired frequency of an output clock for HCKT/R.
> It should never be passed 0. This might cause Division-by-zero.
>
> So this patch adds a check to fix it.
>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
