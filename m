Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2027D1A05E0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jun 2015 22:39:34 +1000 (AEST)
Message-ID: <558FEAF3.8030308@maciej.szmigiero.name>
Date: Sun, 28 Jun 2015 14:39:15 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
MIME-Version: 1.0
To: Timur Tabi <timur@tabi.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC: Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: fix AC'97 mode
References: <558F28E1.7040204@maciej.szmigiero.name>
 <558F77B8.9060307@tabi.org>
In-Reply-To: <558F77B8.9060307@tabi.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

W dniu 28.06.2015 06:27, Timur Tabi pisze:
> Maciej S. Szmigiero wrote:
>> +    if (newbinding && fsl_ssi_is_ac97(ssi_private)) {
> 
> Is the "newbinding" necessary?  I thought only the original PowerPC device trees were the only one that have the old binding, and they never supported AC97.

If there isn't going to be new platforms added with old bindings then this won't be needed - I'll remove it.

Best regards,
Maciej Szmigiero
