Return-Path: <caleb@crome.org>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttztY4XcNzDqMC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 05:32:04 +1100 (AEDT)
Received: by mail-oi0-x244.google.com with SMTP id v84so75498154oie.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jan 2017 10:32:04 -0800 (PST)
MIME-Version: 1.0
Sender: caleb@crome.org
In-Reply-To: <20170104182712.d3vv47g4v5ylis5e@sirena.org.uk>
References: <1483467777-8651-1-git-send-email-caleb@signalessence.com>
 <20170104182712.d3vv47g4v5ylis5e@sirena.org.uk>
From: ccrome <ccrome@gmail.com>
Date: Wed, 4 Jan 2017 10:31:42 -0800
Message-ID: <CAG5mAdzxUhhwjBLWZw6aX_--oAOB0Mbc3+Do-TpNRPqGcC8YVQ@mail.gmail.com>
Subject: Re: [PATCH] fsl_ssi: set fifo watermark to more reliable value
To: Mark Brown <broonie@kernel.org>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 4, 2017 at 10:27 AM, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jan 03, 2017 at 10:22:57AM -0800, Caleb Crome wrote:
> > From: Caleb Crome <caleb@crome.org>
> >
> > The fsl_ssi fifo watermark is by default set to 2 free spaces (i.e.
> > activate DMA on FIFO when only 2 spaces are left.)  This means the
>
> Please submit patches using subject lines reflecting the style for the
> subsystem.  This makes it easier for people to identify relevant
> patches.  Look at what existing commits in the area you're changing are
> doing and make sure your subject lines visually resemble what they're
> doing.

Shoot, yes of course.  I forgot to check the subject format against
extant patches.

The subject should be

[PATCH] ASoC: fsl_ssi: set fifo watermark to more reliable value

Correct?

Should I re-submit?

Thanks,
 -Caleb
