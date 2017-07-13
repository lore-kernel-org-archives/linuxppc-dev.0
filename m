Return-Path: <garsilva@embeddedor.com>
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com
 [192.185.148.119])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7pvx48h0zDqkm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 07:33:17 +1000 (AEST)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
 by gateway34.websitewelcome.com (Postfix) with ESMTP id 5D95B5B80F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 16:10:57 -0500 (CDT)
Date: Thu, 13 Jul 2017 16:10:56 -0500
Message-ID: <20170713161056.Horde.jVvECgjHYS4t4jiD4hqm2WC@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Joe Perches <joe@perches.com>
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Timur
 Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_asrc: constify snd_soc_dai_ops
 structure
References: <20170713072351.GA1485@embeddedgus> <s5hlgnsiyg6.wl-tiwai@suse.de>
 <20170713101630.odml56qmsvgxqj64@sirena.org.uk>
 <20170713101814.Horde.q8OhHejhvSALVEt2o11aUTW@gator4166.hostgator.com>
 <1499969891.4457.59.camel@perches.com>
In-Reply-To: <1499969891.4457.59.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Joe,

Quoting Joe Perches <joe@perches.com>:

> On Thu, 2017-07-13 at 10:18 -0500, Gustavo A. R. Silva wrote:
>> Hi Mark,
>>
>> Quoting Mark Brown <broonie@kernel.org>:
>>
>> > On Thu, Jul 13, 2017 at 09:32:41AM +0200, Takashi Iwai wrote:
>> >
>> > > please stop posting in this style.  It's really annoying to see
>> > > spontaneously popping-up almost same patch for more than two hours
>> > > long.
>> > > If you have a series of the same fix patches, send them as a patch
>> > > set in a shot with a thread.  git-send-email does it right.
>> > > I don't mind a couple of patches posted separately, but this is over
>> > > the limit.
>> >
>> > Or at least just collect them up and send them all at one time even if
>> > not as a single thread (you don't want to CC everyone affected by a
>> > single patch in the set on everything, that's harder to avoid when
>> > sending a series via git, but it can be confusing to get one item in a
>> > large patch series without context).
>>
>> I like this idea better. I will do so next time. :)
>
> I don't it's better.
>
> It's not that confusing if the 0/n patch cover letter is cc'd
> to all the appropriate mailing lists and all the [1..n]/n
> patches are sent with in-reply-to of the cover letter and
> send to the maintainers and appropriate mailing lists.

I ended up following your suggestions:

https://lkml.org/lkml/2017/7/13/739 (Notice that these are new  
patches. Not related to the ones I previously sent)

Much appreciated
Thanks!
--
Gustavo A. R. Silva
