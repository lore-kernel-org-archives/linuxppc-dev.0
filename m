Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E0CA01A0454
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jun 2015 23:29:17 +1000 (AEST)
Message-ID: <558FF6A8.6070307@tabi.org>
Date: Sun, 28 Jun 2015 08:29:12 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC: Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: fix AC'97 mode
References: <558F28E1.7040204@maciej.szmigiero.name>
 <558F77B8.9060307@tabi.org> <558FEAF3.8030308@maciej.szmigiero.name>
In-Reply-To: <558FEAF3.8030308@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Maciej S. Szmigiero wrote:
> If there isn't going to be new platforms added with old bindings then this won't be needed - I'll remove it.

I would love it if someone would port those original device trees to the 
new binding, so that we can get rid of the old one.  But we should 
definitely not allow new device trees with the old binding.
