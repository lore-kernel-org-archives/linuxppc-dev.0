Return-Path: <peter.ujfalusi@ti.com>
MIME-Version: 1.0
In-Reply-To: <1316597339-29861-54-git-send-email-yong.zhang0@gmail.com>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
	<1316597339-29861-54-git-send-email-yong.zhang0@gmail.com>
Date: Wed, 21 Sep 2011 13:21:17 +0300
Message-ID: <CAPo=G1zGu7zf2KTKmzZynWQ9X3DS+SjKLFuZkjSQ5KsSuZ6Dgw@mail.gmail.com>
Subject: Re: [PATCH 53/57] sound: irq: Remove IRQF_DISABLED
From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
To: Yong Zhang <yong.zhang0@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Paul Gortmaker <paul.gortmaker@windriver.com>, linux-arch@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	=?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Axel Lin <axel.lin@gmail.com>, Liam Girdwood <lrg@ti.com>,
	cbe-oss-dev@lists.ozlabs.org, Wan ZongShun <mcuos.com@gmail.com>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
	Eric Miao <eric.y.miao@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linux-kernel@vger.kernel.org, Geoff Levand <geoff@infradead.org>,
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

On Wed, Sep 21, 2011 at 12:28 PM, Yong Zhang <yong.zhang0@gmail.com> wrote:
> Since commit [c58543c8: genirq: Run irq handlers with interrupts disabled],
> We run all interrupt handlers with interrupts disabled
> and we even check and yell when an interrupt handler
> returns with interrupts enabled (see commit [b738a50a:
> genirq: Warn when handler enables interrupts]).
>
> So now this flag is a NOOP and can be removed.
>
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
