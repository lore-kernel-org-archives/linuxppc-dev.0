Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DC021A099E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 01:10:38 +1100 (AEDT)
Subject: Re: [PATCH 2/2] ASoC: fsl: select SND_SOC_FSL_SAI or SND_SOC_FSL_SSI
 depending on SoC type
To: =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Fabio Estevam
 <fabio.estevam@freescale.com>, Jaroslav Kysela <perex@perex.cz>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1452622411-16674-1-git-send-email-LW@KARO-electronics.de>
 <1452622411-16674-2-git-send-email-LW@KARO-electronics.de>
 <1452622411-16674-3-git-send-email-LW@KARO-electronics.de>
 <569545EB.4080307@tabi.org> <20160113133810.167d2dbb@ipc1.ka-ro>
From: Timur Tabi <timur@tabi.org>
Message-ID: <56965AE0.40706@tabi.org>
Date: Wed, 13 Jan 2016 08:10:40 -0600
MIME-Version: 1.0
In-Reply-To: <20160113133810.167d2dbb@ipc1.ka-ro>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Lothar Waßmann wrote:
> Why? If more than one of the IMX6 SoCs are selected, both interfaces
> may be selected at the same time without any harm.

Oh, ok.  I thought the point behind the patch was that you *souldn't* 
enable the the SSI driver on an i.MX6UL.
