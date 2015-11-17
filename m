Return-Path: <anton.bondarenko.sama@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com
 [IPv6:2a00:1450:4010:c07::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D792E1A025F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 21:43:33 +1100 (AEDT)
Received: by lffu14 with SMTP id u14so360951lff.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 02:43:29 -0800 (PST)
Subject: Re: [PATCH] [media] move media platform data to
 linux/platform_data/media
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
References: <4d99e49726942dc4d6a6ee1debf6665b2b47908b.1447751746.git.mchehab@osg.samsung.com>
 <7319142.Cp8MurgLWk@wuerfel>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Sergey Lapin <slapin@ossfans.org>, Timur Tabi <timur@tabi.org>,
 Jaroslav Kysela <perex@perex.cz>, Tomas Cech <sleep_walker@suse.com>,
 Shawn Guo <shawnguo@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Markus Elfring <elfring@users.sourceforge.net>,
 Harald Welte <laforge@openezx.org>, openezx-devel@lists.openezx.org,
 Russell King <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Daniel Ribeiro <drwyrm@gmail.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Stefan Schmidt <stefan@openezx.org>, Sascha Hauer <kernel@pengutronix.de>,
 alsa-devel@alsa-project.org, Mauro Carvalho Chehab
 <mchehab@osg.samsung.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-fbdev@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Fabio Estevam <fabio.estevam@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-spi@vger.kernel.org,
 Philipp Zabel <p.zabel@pengutronix.de>, dmaengine@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Guennadi Liakhovetski
 <g.liakhovetski@gmx.de>, Daniel Mack <daniel@zonque.org>
From: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
Message-ID: <564B04CF.1090507@gmail.com>
Date: Tue, 17 Nov 2015 11:43:27 +0100
MIME-Version: 1.0
In-Reply-To: <7319142.Cp8MurgLWk@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 17.11.2015 10:23, Arnd Bergmann wrote:
> On Tuesday 17 November 2015 07:15:59 Mauro Carvalho Chehab wrote:
>> Now that media has its own subdirectory inside platform_data,
>> let's move the headers that are already there to such subdir.
>>
>>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

Why does dma-imx.h also moved? It's the generic file, not a media specific.

BR, Anton
