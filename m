Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKYj34CcDzF0W9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 11:13:11 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id y5so7264675pff.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jan 2018 16:13:11 -0800 (PST)
Date: Sun, 14 Jan 2018 16:13:06 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: Re: [PATCH v2 14/16] ASoC: fsl_ssi: Remove cpu_dai_drv from fsl_ssi
 structure
Message-ID: <20180115001305.GD2925@Asurada-CZ80>
References: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
 <1515652995-15996-15-git-send-email-nicoleotsuka@gmail.com>
 <4626cd37-c84c-6187-51ae-73fa419b801e@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4626cd37-c84c-6187-51ae-73fa419b801e@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 14, 2018 at 11:42:59PM +0100, Maciej S. Szmigiero wrote:
> On 11.01.2018 07:43, Nicolin Chen wrote:
> > The cpu_dai_drv is only used for symmetric_rates. So this patch replaces
> > it with a synchronous boolean flag.
> 
> You make cpu_dai_drv common to all SSI instances instead of per-instance.
> 
> What if you have multiple SSIs in the system with different
> symmetric_{rates,samplebits,channels} settings?

Good catch...it should maintain each cpu_dai_drv separately. Thanks!
