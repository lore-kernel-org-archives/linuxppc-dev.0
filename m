Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A13CE1A0E6B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 05:18:01 +1000 (AEST)
Date: Wed, 10 Jun 2015 22:17:32 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [patch] ASoC: fsl: add an error check
Message-ID: <20150610191732.GC11734@mwanda>
References: <20150610153723.GB10549@mwanda>
 <20150610165544.GA8552@Asurada>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150610165544.GA8552@Asurada>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Could you please use an subject like:
> ASoC: imx-wm8962: Add a missing error check
> (Since it only applies to this file)
> 

I have been meaning to say something about this.

This is sort of a recurrent problem for me because I'm often the first
person to touch a driver after it's added.  I just copied your patch
prefix from 8de2ae2a7f1f ('ASoC: fsl: add imx-wm8962 machine driver').
Really you should also have used "ASoC: imx-wm8962:" as well.

This is the third new driver today where I have faced this situation.

regards,
dan carpenter
