Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYbQL2q5XzDrGp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 18:11:38 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id t80so7744968pgb.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 01:11:38 -0700 (PDT)
Date: Fri, 18 Aug 2017 01:11:23 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, timur@tabi.org, Xiubo.Lee@gmail.com,
 fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, plai@codeaurora.org,
 bgoswami@codeaurora.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ASoC: fsl: make snd_pcm_hardware const
Message-ID: <20170818081122.GA10136@Asurada>
References: <1502964972-22722-1-git-send-email-bhumirks@gmail.com>
 <1502964972-22722-2-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1502964972-22722-2-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 17, 2017 at 03:46:07PM +0530, Bhumika Goyal wrote:
> Make these const as they are only passed as the 2nd argument to the
> function snd_soc_set_runtime_hwparams, which is const.
> Done using Coccinelle.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
