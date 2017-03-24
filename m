Return-Path: <daniel.baluta@gmail.com>
Received: from mail-io0-x234.google.com (mail-io0-x234.google.com
 [IPv6:2607:f8b0:4001:c06::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vqFcG2BcmzDqdq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 18:37:02 +1100 (AEDT)
Received: by mail-io0-x234.google.com with SMTP id b140so11979748iof.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 00:37:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170324045814.GA15344@Asurada-CZ80>
References: <1490270510-17061-1-git-send-email-daniel.baluta@gmail.com>
 <20170324045814.GA15344@Asurada-CZ80>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 24 Mar 2017 09:37:00 +0200
Message-ID: <CAEnQRZCPcvkGUTc5bFKuOi-W1v39LmO_gAs31J_cWe6gFVVFEw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: WM8962: Let codec driver enable/disable its MCLK
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Timur Tabi <timur@tabi.org>, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 mihai.serban@nxp.com, viorel.suman@nxp.com, shengjiu.wang@nxp.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 24, 2017 at 6:58 AM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Thu, Mar 23, 2017 at 02:01:50PM +0200, Daniel Baluta wrote:
>> From: Nicolin Chen <b42378@freescale.com>
>>
>> WM8962 needs its MCLK when powerup in wm8962_resume(). Thus it's better
>> to control the MCLK in codec driver. Thus remove the clock enable in
>> machine dirver accordingly.
>>
>> While at it, get rid of imx_wm8962_remove function since it is now
>> empty.
>>
>> Signed-off-by: Nicolin Chen <b42378@freescale.com>
>
> Hmm...it'd probably be better to let yourself be the author and remove
> my signed-off here. Just got an email deliver failure since that email
> address is apparently not available any more.

Hi Nic,

I will fix the prefix subject as suggested. Is it OK to use
your current email address for the signed-off-by tag?

Daniel.
