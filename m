Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vQ9252WtCzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2017 10:57:49 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id y6so4933433pgy.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 15:57:49 -0800 (PST)
Date: Fri, 17 Feb 2017 15:57:52 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Joe Perches <joe@perches.com>, Timur Tabi <timur@tabi.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 35/35] sound/soc: Convert remaining uses of pr_warning to
 pr_warn
Message-ID: <20170217235751.GA4125@Asurada-Nvidia>
References: <cover.1487314666.git.joe@perches.com>
 <3d93f7226ba34fede99f72ec038098a3d98a139a.1487314667.git.joe@perches.com>
 <20170217202844.GA8215@Asurada-Nvidia>
 <20170217234854.spi62waguwd7kpno@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170217234854.spi62waguwd7kpno@sirena.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 17, 2017 at 11:48:54PM +0000, Mark Brown wrote:
> On Fri, Feb 17, 2017 at 12:28:44PM -0800, Nicolin Chen wrote:
> > On Thu, Feb 16, 2017 at 11:11:48PM -0800, Joe Perches wrote:
> > > To enable eventual removal of pr_warning
> > > 
> > > This makes pr_warn use consistent for sound/soc
> > > 
> > > Prior to this patch, there were 5 uses of pr_warning and
> > > 10 uses of pr_warn in sound/soc
> > > 
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > 
> > For imx-audmux.c,
> 
> I don't have this patch, perhaps it got caught in a spam filter or
> perhaps it got deleted because as ever you're not using subject lines
> reflecting the style for the subsystem.

My bad that I didn't pay attention to the subject.

Joe, please fix it in v2. Thanks.

ASoC: Convert remaining uses of pr_warning to pr_warn
