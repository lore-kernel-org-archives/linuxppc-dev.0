Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0114.hostedemail.com
 [216.40.44.114])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x890b4VDvzDqgP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 21:08:30 +1000 (AEST)
Message-ID: <1500030501.4457.70.camel@perches.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_asrc: constify snd_soc_dai_ops
 structure
From: Joe Perches <joe@perches.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Takashi Iwai
 <tiwai@suse.de>, Timur Tabi <timur@tabi.org>, Nicolin Chen
 <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
 <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org,  linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Fri, 14 Jul 2017 04:08:21 -0700
In-Reply-To: <20170714110233.fqkmgy7kyhje7mfy@sirena.org.uk>
References: <20170713072351.GA1485@embeddedgus> <s5hlgnsiyg6.wl-tiwai@suse.de>
 <20170713101630.odml56qmsvgxqj64@sirena.org.uk>
 <20170713101814.Horde.q8OhHejhvSALVEt2o11aUTW@gator4166.hostgator.com>
 <1499969891.4457.59.camel@perches.com>
 <20170714110233.fqkmgy7kyhje7mfy@sirena.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-07-14 at 12:02 +0100, Mark Brown wrote:
> On Thu, Jul 13, 2017 at 11:18:11AM -0700, Joe Perches wrote:
> 
> > I don't it's better.
> > It's not that confusing if the 0/n patch cover letter is cc'd
> > to all the appropriate mailing lists and all the [1..n]/n
> > patches are sent with in-reply-to of the cover letter and
> > send to the maintainers and appropriate mailing lists.
> 
> With large serieses like Gustavo is sending the CC list can easily hit
> the points where mailing lists start blocking it, and the individual
> pathces really do need to go to the relevant people so they have sight
> of them.

I agree and that's what I wrote.
