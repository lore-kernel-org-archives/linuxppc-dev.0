Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0050.hostedemail.com
 [216.40.44.50])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vQ9Xs0dYYzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2017 11:20:58 +1100 (AEDT)
Message-ID: <1487377247.2198.9.camel@perches.com>
Subject: Re: [PATCH 35/35] sound/soc: Convert remaining uses of pr_warning
 to pr_warn
From: Joe Perches <joe@perches.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio
 Estevam <fabio.estevam@nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki
 <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Fri, 17 Feb 2017 16:20:47 -0800
In-Reply-To: <20170217235751.GA4125@Asurada-Nvidia>
References: <cover.1487314666.git.joe@perches.com>
 <3d93f7226ba34fede99f72ec038098a3d98a139a.1487314667.git.joe@perches.com>
 <20170217202844.GA8215@Asurada-Nvidia>
 <20170217234854.spi62waguwd7kpno@sirena.org.uk>
 <20170217235751.GA4125@Asurada-Nvidia>
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

On Fri, 2017-02-17 at 15:57 -0800, Nicolin Chen wrote:
> On Fri, Feb 17, 2017 at 11:48:54PM +0000, Mark Brown wrote:
> > On Fri, Feb 17, 2017 at 12:28:44PM -0800, Nicolin Chen wrote:
> > > On Thu, Feb 16, 2017 at 11:11:48PM -0800, Joe Perches wrote:
> > > > To enable eventual removal of pr_warning
> > > > 
> > > > This makes pr_warn use consistent for sound/soc
> > > > 
> > > > Prior to this patch, there were 5 uses of pr_warning and
> > > > 10 uses of pr_warn in sound/soc
> > > > 
> > > > Signed-off-by: Joe Perches <joe@perches.com>
> > > 
> > > For imx-audmux.c,
> > 
> > I don't have this patch, perhaps it got caught in a spam filter or
> > perhaps it got deleted because as ever you're not using subject lines
> > reflecting the style for the subsystem.
> 
> My bad that I didn't pay attention to the subject.
> 
> Joe, please fix it in v2. Thanks.
> 
> ASoC: Convert remaining uses of pr_warning to pr_warn

This is a treewide scripted patch which is
basically just a sed.

If or when you apply it, you should
fix it up to suit.

$ git log -1000 --pretty=oneline --no-merges sound/soc | \
  cut -f2- -d" " | cut -f1 -d":" |sort | uniq
ALSA
AsoC
ASoc
ASoC
ASOC
ASoC fix up SND_SOC_WM8985 dependency
drm/i915/dp
kthread
lib/vsprintf.c
scripts/spelling.txt
sgtl5000
SoC
sound/soc
treewide
