Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0104.hostedemail.com
 [216.40.44.104])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7kb03RNbzDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 04:18:19 +1000 (AEST)
Message-ID: <1499969891.4457.59.camel@perches.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_asrc: constify snd_soc_dai_ops
 structure
From: Joe Perches <joe@perches.com>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Mark Brown
 <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>, Nicolin Chen
 <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
 <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org,  linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Thu, 13 Jul 2017 11:18:11 -0700
In-Reply-To: <20170713101814.Horde.q8OhHejhvSALVEt2o11aUTW@gator4166.hostgator.com>
References: <20170713072351.GA1485@embeddedgus> <s5hlgnsiyg6.wl-tiwai@suse.de>
 <20170713101630.odml56qmsvgxqj64@sirena.org.uk>
 <20170713101814.Horde.q8OhHejhvSALVEt2o11aUTW@gator4166.hostgator.com>
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

On Thu, 2017-07-13 at 10:18 -0500, Gustavo A. R. Silva wrote:
> Hi Mark,
> 
> Quoting Mark Brown <broonie@kernel.org>:
> 
> > On Thu, Jul 13, 2017 at 09:32:41AM +0200, Takashi Iwai wrote:
> > 
> > > please stop posting in this style.  It's really annoying to see
> > > spontaneously popping-up almost same patch for more than two hours
> > > long.
> > > If you have a series of the same fix patches, send them as a patch
> > > set in a shot with a thread.  git-send-email does it right.
> > > I don't mind a couple of patches posted separately, but this is over
> > > the limit.
> > 
> > Or at least just collect them up and send them all at one time even if
> > not as a single thread (you don't want to CC everyone affected by a
> > single patch in the set on everything, that's harder to avoid when
> > sending a series via git, but it can be confusing to get one item in a
> > large patch series without context).
> 
> I like this idea better. I will do so next time. :)

I don't it's better.

It's not that confusing if the 0/n patch cover letter is cc'd
to all the appropriate mailing lists and all the [1..n]/n
patches are sent with in-reply-to of the cover letter and
send to the maintainers and appropriate mailing lists.
