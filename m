Return-Path: <HartleyS@visionengravers.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0134.outbound.protection.outlook.com [104.47.32.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xR7Jw0P28zDqp7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 05:44:31 +1000 (AEST)
From: Hartley Sweeten <HartleyS@visionengravers.com>
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger
 <richard@nod.at>, "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>
CC: David Woodhouse <dwmw2@infradead.org>, Brian Norris
 <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, "Cyrille
 Pitchen" <cyrille.pitchen@wedev4u.fr>, Peter Pan <peterpandong@micron.com>,
 Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman
 <khilman@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn
 <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@free-electrons.com>, Alexander Sverdlin
 <alexander.sverdlin@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Imre Kaloz
 <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Eric Miao
 <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, "Aaro
 Koskinen" <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
 "Alexander Clouter" <alex@digriz.org.uk>, Daniel Mack <daniel@zonque.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Simtec Linux Team
 <linux@simtec.co.uk>, Steven Miao <realmz6@gmail.com>, Mikael Starvik
 <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Ralf Baechle
 <ralf@linux-mips.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich
 Felker <dalias@libc.org>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu
 <rainyfeeling@outlook.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Masahiro
 Yamada <yamada.masahiro@socionext.com>, "Han Xu" <han.xu@nxp.com>, Harvey
 Hunt <harveyhuntnexus@gmail.com>, "Vladimir Zapolskiy" <vz@mleia.com>,
 Sylvain Lemieux <slemieux.tyco@gmail.com>, "Matthias Brugger"
 <matthias.bgg@gmail.com>, Wan ZongShun <mcuos.com@gmail.com>, "Neil
 Armstrong" <narmstrong@baylibre.com>, Ezequiel Garcia
 <ezequiel.garcia@free-electrons.com>, Maxim Levitsky
 <maximlevitsky@gmail.com>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Stefan Agner <stefan@agner.ch>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org"
 <linux-omap@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org"
 <linux-samsung-soc@vger.kernel.org>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>, "linux-cris-kernel@axis.com"
 <linux-cris-kernel@axis.com>, "linux-mips@linux-mips.org"
 <linux-mips@linux-mips.org>, "linux-sh@vger.kernel.org"
 <linux-sh@vger.kernel.org>, "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>, "linux-oxnas@lists.tuxfamily.org"
 <linux-oxnas@lists.tuxfamily.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "devel@driverdev.osuosl.org"
 <devel@driverdev.osuosl.org>
Subject: RE: [PATCH] mtd: nand: Rename nand.h into rawnand.h
Date: Mon, 7 Aug 2017 19:44:22 +0000
Message-ID: <SN1PR0101MB1565E57B6E4B074BC235DCACD0B50@SN1PR0101MB1565.prod.exchangelabs.com>
References: <1501860550-16506-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501860550-16506-2-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1501860550-16506-2-git-send-email-boris.brezillon@free-electrons.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

T24gRnJpZGF5LCBBdWd1c3QgMDQsIDIwMTcgODoyOSBBTSwgQm9yaXMgQnJlemlsbG9uIHdyb3Rl
Og0KPiBXZSBhcmUgcGxhbm5pbmcgdG8gc2hhcmUgbW9yZSBjb2RlIGJldHdlZW4gZGlmZmVyZW50
IE5BTkQgYmFzZWQNCj4gZGV2aWNlcyAoU1BJIE5BTkQsIE9uZU5BTkQgYW5kIHJhdyBOQU5Ecyks
IGJ1dCBiZWZvcmUgZG9pbmcgdGhhdA0KPiB3ZSBuZWVkIHRvIG1vdmUgdGhlIGV4aXN0aW5nIGlu
Y2x1ZGUvbGludXgvbXRkL25hbmQuaCBmaWxlIGludG8NCj4gaW5jbHVkZS9saW51eC9tdGQvcmF3
bmFuZC5oIHNvIHdlIGNhbiBsYXRlciBjcmVhdGUgYSBuYW5kLmggaGVhZGVyDQo+IGNvbnRhaW5p
bmcgYWxsIGNvbW1vbiBzdHJ1Y3R1cmUgYW5kIGZ1bmN0aW9uIHByb3RvdHlwZXMuDQoNCkZvciBl
cDkzeHgsDQoNCkFja2VkLWJ5OiBIIEhhcnRsZXkgU3dlZXRlbiA8aHN3ZWV0ZW5AdmlzaW9uZW5n
cmF2ZXJzLmNvbT4NCg==
