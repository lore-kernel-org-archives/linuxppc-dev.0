Return-Path: <vz@mleia.com>
Received: from mail.mleia.com (mleia.com [178.79.152.223])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xPFsP6scKzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Aug 2017 04:32:41 +1000 (AEST)
Subject: Re: [PATCH] mtd: nand: Rename nand.h into rawnand.h
To: Boris Brezillon <boris.brezillon@free-electrons.com>
References: <1501860550-16506-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501860550-16506-2-git-send-email-boris.brezillon@free-electrons.com>
Cc: Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 Peter Pan <peterpandong@micron.com>, Jonathan Corbet <corbet@lwn.net>,
 Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 Hartley Sweeten <hsweeten@visionengravers.com>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>, Eric Miao <eric.y.miao@gmail.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
 Alexander Clouter <alex@digriz.org.uk>, Daniel Mack <daniel@zonque.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Simtec Linux Team
 <linux@simtec.co.uk>, Steven Miao <realmz6@gmail.com>,
 Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>,
 Ralf Baechle <ralf@linux-mips.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>,
 Kamal Dasu <kdasu.kdev@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, Han Xu <han.xu@nxp.com>,
 Harvey Hunt <harveyhuntnexus@gmail.com>,
 Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Wan ZongShun
 <mcuos.com@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Maxim Levitsky <maximlevitsky@gmail.com>,
 Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Stefan Agner <stefan@agner.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-cris-kernel@axis.com,
 linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-mediatek@lists.infradead.org,
 linux-oxnas@lists.tuxfamily.org, linuxppc-dev@lists.ozlabs.org,
 devel@driverdev.osuosl.org
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <5e849e7d-37ff-d1f6-5451-9954f89667ae@mleia.com>
Date: Fri, 4 Aug 2017 21:22:17 +0300
MIME-Version: 1.0
In-Reply-To: <1501860550-16506-2-git-send-email-boris.brezillon@free-electrons.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Boris,

On 04.08.2017 18:29, Boris Brezillon wrote:
> We are planning to share more code between different NAND based
> devices (SPI NAND, OneNAND and raw NANDs), but before doing that
> we need to move the existing include/linux/mtd/nand.h file into
> include/linux/mtd/rawnand.h so we can later create a nand.h header
> containing all common structure and function prototypes.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Peter Pan <peterpandong@micron.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khalasa@piap.pl>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Alexander Clouter <alex@digriz.org.uk>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Simtec Linux Team <linux@simtec.co.uk>
> Cc: Steven Miao <realmz6@gmail.com>
> Cc: Mikael Starvik <starvik@axis.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Wenyou Yang <wenyou.yang@atmel.com>
> Cc: Josh Wu <rainyfeeling@outlook.com>
> Cc: Kamal Dasu <kdasu.kdev@gmail.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Han Xu <han.xu@nxp.com>
> Cc: Harvey Hunt <harveyhuntnexus@gmail.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: adi-buildroot-devel@lists.sourceforge.net
> Cc: linux-cris-kernel@axis.com
> Cc: linux-mips@linux-mips.org
> Cc: linux-sh@vger.kernel.org
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-oxnas@lists.tuxfamily.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: devel@driverdev.osuosl.org
> ---
> Hi All,
> 
> Sorry for the huge Cc list, but I'd like to collect as much acks as
> possible for this patch which is actually part of a bigger series [1].
> 
> Note that there's nothing complicated here, it's just a mechanical
> s/nand\.h/rawnand\.h/ replacement, but it impacts several architectures,
> the doc and staging directories.
> 
> Regards,
> 
> Boris
> 
> [1]https://lwn.net/Articles/723694/
> ---

[snip]

>  drivers/mtd/nand/lpc32xx_mlc.c                  | 2 +-
>  drivers/mtd/nand/lpc32xx_slc.c                  | 2 +-

For LPC32xx drivers

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
With best wishes,
Vladimir
