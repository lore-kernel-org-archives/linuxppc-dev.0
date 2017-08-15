Return-Path: <ckeepax@opensource.cirrus.com>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWlnq3tyNzDrJV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 18:22:06 +1000 (AEST)
Date: Tue, 15 Aug 2017 09:11:43 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bhumika Goyal <bhumirks@gmail.com>
CC: <julia.lawall@lip6.fr>, <brian.austin@cirrus.com>,
 <Paul.Handrigan@cirrus.com>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
 <bardliao@realtek.com>, <chiou@realtek.com>, <timur@tabi.org>,
 <nicoleotsuka@gmail.com>, <Xiubo.Lee@gmail.com>,
 <fabio.estevam@nxp.com>, <yang.jie@linux.intel.com>,
 <peter.ujfalusi@ti.com>, <jarkko.nikula@bitmer.com>,
 <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
 <robert.jarzmik@free.fr>, <plai@codeaurora.org>,
 <bgoswami@codeaurora.org>, <krzk@kernel.org>, <sbkim73@samsung.com>,
 <s.nawrocki@samsung.com>, <alsa-devel@alsa-project.org>,
 <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-omap@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 01/11] ASoC: codecs: make snd_soc_platform_driver const
Message-ID: <20170815081143.cpkronjaqjo5ike5@localhost.localdomain>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
 <1502710730-18912-2-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1502710730-18912-2-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 14, 2017 at 05:08:40PM +0530, Bhumika Goyal wrote:
> Make these const as they are either passed as the 2nd argument to the
> function devm_snd_soc_register_platform or snd_soc_register_platform,
> and the arguments are of type const.
> Done using Coccinelle.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---

For the Wolfson bits:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
