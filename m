Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C2C71A0075
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2015 08:43:09 +1000 (AEST)
Message-ID: <55BFEE68.7030007@maciej.szmigiero.name>
Date: Tue, 04 Aug 2015 00:42:48 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
CC: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Markus Pargmann <mpa@pengutronix.de>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 6/6 v2] ASoC: fsl_ssi: adjust set DAI format in AC'97 mode
References: <55BA364E.1000803@maciej.szmigiero.name>
 <20150731055843.GX30895@pengutronix.de>
 <55BB9082.4030206@maciej.szmigiero.name>
 <20150802185103.GD19600@pengutronix.de>
 <55BE9D3B.3090303@maciej.szmigiero.name>
 <20150803162147.GB20873@sirena.org.uk>
In-Reply-To: <20150803162147.GB20873@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03.08.2015 18:21, Mark Brown wrote:
> On Mon, Aug 03, 2015 at 12:44:11AM +0200, Maciej S. Szmigiero wrote:
>> Adjust set DAI format function in fsl_ssi driver
>> so it doesn't fail and clears RXDIR in AC'97 mode.
>>
>> Changes from v1: fix indentation to be consistent with rest
>> of the driver.
> 
> Inter version changelogs go after the --- as covered in
> SubmittingPatches.
> 
>>
>> Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
> 
> Please don't bury new patches in reply to old submissions, especially
> not individual patches - it makes it hard to work out what's going on
> and make sure that the most current version of everything is being
> applied.  In order to avoid confusion I'm not going to look at these,
> please resubmit as a new thread.
> 
> Please also try to thread your patch series together (git send-email can
> do this for you) - it also helps people keep track of things.

Thanks for information.

In cases like this where only one patch of six patch series is updated
should other ones be resubmitted as well to keep the full patch series
together?

Best regards,
Maciej Szmigiero
