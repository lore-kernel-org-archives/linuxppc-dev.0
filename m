Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m68p2SZnzDqwW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 17:52:10 +1000 (AEST)
Date: Wed, 16 May 2018 09:33:51 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, David Brown <david.brown@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Brendan Higgins <brendanhiggins@google.com>, openbmc@lists.ozlabs.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Joel Stanley <joel@jms.id.au>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Andy Gross <andy.gross@linaro.org>,
 Peter Korsgaard <jacmet@sunsite.dk>, linuxppc-dev@lists.ozlabs.org,
 Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: busses: make use of i2c_8bit_addr_from_msg
Message-ID: <20180516073351.y5avitvaj5ouu6m3@pengutronix.de>
References: <20180516071647.29277-1-peda@axentia.se>
 <20180516071647.29277-3-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180516071647.29277-3-peda@axentia.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Peter,

On Wed, May 16, 2018 at 09:16:47AM +0200, Peter Rosin wrote:
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de> [emf32 and imx]

s/emf/efm/

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
