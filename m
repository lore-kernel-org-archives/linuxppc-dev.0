Return-Path: <pawel.moll@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id B321BB7077
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2012 20:38:56 +1000 (EST)
Message-ID: <1339669732.6598.7.camel@hornet>
Subject: Re: [PATCH] i2c: let the core register devices from devicetree
From: Pawel Moll <pawel.moll@arm.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Date: Thu, 14 Jun 2012 11:28:52 +0100
In-Reply-To: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Viresh Kumar <viresh.kumar@st.com>,
 Mauro Carvalho Chehab <mchehab@redhat.com>, Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-i2c@vger.kernel.org,
 Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>,
 Deepak Sikri <deepak.sikri@st.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Dirk Brandewie <dirk.brandewie@gmail.com>,
 Wolfram Sang <wolfram@the-dreams.de>, Sascha Hauer <s.hauer@pengutronix.de>,
 Rusty Russell <rusty@rustcorp.com.au>, Tang Yuantian <B29983@freescale.com>,
 "Jean Delvare \(PC drivers, core\)" <khali@linux-fr.org>,
 Magnus Damm <damm@opensource.se>, Lars-Peter Clausen <lars@metafoo.de>,
 "Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
 linux-arm-kernel@lists.infradead.org, Jiri Kosina <jkosina@suse.cz>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Karol Lewandowski <k.lewandowsk@samsung.com>, Olof Johansson <olof@lixom.net>,
 Shawn Guo <shawn.guo@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-06-13 at 23:12 +0200, Wolfram Sang wrote:
> Currently, every driver has to do it on its own, but it should be done
> in the core, like we already do with board_info structs.
>=20
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  drivers/i2c/busses/i2c-versatile.c          |    1 -
>  drivers/i2c/i2c-core.c                      |    3 +++

For what it's worth

Tested-by: Pawel Moll <pawel.moll@arm.com>

on Versatile Express.

Regards

Pawe=C5=82
