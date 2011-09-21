Return-Path: <tglx@linutronix.de>
Date: Wed, 21 Sep 2011 11:55:36 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 53/57] sound: irq: Remove IRQF_DISABLED
In-Reply-To: <s5hsjnqxlxb.wl%tiwai@suse.de>
Message-ID: <alpine.LFD.2.02.1109211154280.2723@ionos>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
	<1316597339-29861-54-git-send-email-yong.zhang0@gmail.com>
	<s5hsjnqxlxb.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: alsa-devel@alsa-project.org,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>, linux-arch@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	=?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Axel Lin <axel.lin@gmail.com>, Liam Girdwood <lrg@ti.com>,
	cbe-oss-dev@lists.ozlabs.org, Wan ZongShun <mcuos.com@gmail.com>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Yong Zhang <yong.zhang0@gmail.com>, linux-arm-kernel@lists.infradead.org,
	Eric Miao <eric.y.miao@gmail.com>, Geoff Levand <geoff@infradead.org>,
	Jiri Kosina <jkosina@suse.cz>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linux-kernel@vger.kernel.org, Sangbeom Kim <sbkim73@samsung.com>,
	Paul Mundt <lethal@linux-sh.org>, Simon Horman <simon@horms.net>,
	Joe Perches <joe@perches.com>, Jarkko Nikula <jhnikula@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 21 Sep 2011, Takashi Iwai wrote:

> At Wed, 21 Sep 2011 17:28:54 +0800,
> Yong Zhang wrote:
> > 
> > Since commit [c58543c8: genirq: Run irq handlers with interrupts disabled],
> 
> Hm, this id hits a different commit:
>     commit c58543c869606532c2382f027d6466f4672ea756
>     Author: David S. Miller <davem@davemloft.net>
>     Date:   Tue Oct 13 00:49:09 2009 -0700
> 
>     sparc64: Set IRQF_DISABLED on LDC channel IRQs.
> 
> You mean commit e58aa3d2d0cc01ad8d6f7f640a0670433f794922?

Yeah.
 
> > We run all interrupt handlers with interrupts disabled
> > and we even check and yell when an interrupt handler
> > returns with interrupts enabled (see commit [b738a50a:
> > genirq: Warn when handler enables interrupts]).
> > 
> > So now this flag is a NOOP and can be removed.
> > 
> > Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> > Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Do you want to merge by yourself or shall I take it to sound git tree?
> Since IRQF_DISABLED isn't used, it can be applied safely in 3.1-based
> tree, right?

Yes, please go ahead. I'll pick up the leftovers.

Thanks,

	tglx
