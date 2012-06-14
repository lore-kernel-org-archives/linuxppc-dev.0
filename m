Return-Path: <jacmet@gmail.com>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 37870B704D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2012 17:31:57 +1000 (EST)
Received: by werh12 with SMTP id h12so1043191wer.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2012 00:31:54 -0700 (PDT)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] i2c: let the core register devices from devicetree
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
Date: Thu, 14 Jun 2012 09:31:49 +0200
In-Reply-To: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de> (Wolfram
 Sang's message of "Wed, 13 Jun 2012 23:12:10 +0200")
Message-ID: <87ehpiwdqy.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Viresh Kumar <viresh.kumar@st.com>,
 Mauro Carvalho Chehab <mchehab@redhat.com>, Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linus.walleij@linaro.org>,
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

>>>>> "Wolfram" == Wolfram Sang <w.sang@pengutronix.de> writes:

 Wolfram> Currently, every driver has to do it on its own, but it should
 Wolfram> be done in the core, like we already do with board_info
 Wolfram> structs.

 Wolfram> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
 Wolfram> ---

 Wolfram> Based on v3.5-rc2. Only build tested, I don't have a OF based device
 Wolfram> around at the moment.

Neither have I, but it looks good.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

 Wolfram> @Peter: Why does ocores do the device registration manually via
 Wolfram> platform_data instead of using board_info?

Because of dd14be4c274 (i2c-ocores: Can add I2C devices to the bus), a
patch I wasn't CC'ed on and haven't acked. I only noticed it later when
the I2C tree got merged into mainline.

-- 
Bye, Peter Korsgaard
