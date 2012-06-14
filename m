Return-Path: <linus.walleij@linaro.org>
Received: from mail-qa0-f50.google.com (mail-qa0-f50.google.com
 [209.85.216.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB717B7050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2012 03:29:19 +1000 (EST)
Received: by qafl39 with SMTP id l39so2526272qaf.16
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2012 10:29:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
Date: Thu, 14 Jun 2012 19:29:16 +0200
Message-ID: <CACRpkdbWQdqQDF7mP51kdZGpiCS+nJ+91j=AkN8S=3Nzvk9sbQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: let the core register devices from devicetree
From: Linus Walleij <linus.walleij@linaro.org>
To: Wolfram Sang <w.sang@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Viresh Kumar <viresh.kumar@st.com>,
 Mauro Carvalho Chehab <mchehab@redhat.com>, Tony Lindgren <tony@atomide.com>,
 Haojian Zhuang <haojian.zhuang@marvell.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-i2c@vger.kernel.org,
 Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@nvidia.com>,
 Olof Johansson <olof@lixom.net>, Barry Song <21cnbao@gmail.com>,
 Deepak Sikri <deepak.sikri@st.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Pawel Moll <pawel.moll@arm.com>, Wolfram Sang <wolfram@the-dreams.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Rusty Russell <rusty@rustcorp.com.au>,
 Tang Yuantian <B29983@freescale.com>, "Jean Delvare \(PC drivers,
 core\)" <khali@linux-fr.org>, Magnus Damm <damm@opensource.se>,
 Lars-Peter Clausen <lars@metafoo.de>,
 "Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
 linux-arm-kernel@lists.infradead.org, Jiri Kosina <jkosina@suse.cz>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Karol Lewandowski <k.lewandowsk@samsung.com>,
 Dirk Brandewie <dirk.brandewie@gmail.com>, Shawn Guo <shawn.guo@linaro.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 13, 2012 at 11:12 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:

> Currently, every driver has to do it on its own, but it should be done
> in the core, like we already do with board_info structs.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Lee might be able to test this with his DT bindings (and patch them to use
the new handling in the core..)

Yours,
Linus Walleij
