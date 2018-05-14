Return-Path: <peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Brendan Higgins <brendanhiggins@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Peter Korsgaard <jacmet@sunsite.dk>, Andy Gross <andy.gross@linaro.org>,
 David Brown <david.brown@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [PATCH 00/21] i2c: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:09 +0200
Message-Id: <20180514145330.4857-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

The nice little inline i2c_8bit_addr_from_msg is not getting
enough use. This series improves the situation and drops a
bunch of lines in the process.

I have only compile-tested (that part fine, at least over here).

Cheers,
Peter

Peter Rosin (21):
  i2c: algo: bit: make use of i2c_8bit_addr_from_msg
  i2c: algo: pca: make use of i2c_8bit_addr_from_msg
  i2c: algo: pcf: make use of i2c_8bit_addr_from_msg
  i2c: aspeed: make use of i2c_8bit_addr_from_msg
  i2c: axxia: make use of i2c_8bit_addr_from_msg
  i2c: diolan: make use of i2c_8bit_addr_from_msg
  i2c: efm32: make use of i2c_8bit_addr_from_msg
  i2c: eg20t: make use of i2c_8bit_addr_from_msg
  i2c: emev2: make use of i2c_8bit_addr_from_msg
  i2c: hix5hd2: make use of i2c_8bit_addr_from_msg
  i2c: imx-lpi2c: make use of i2c_8bit_addr_from_msg
  i2c: imx: make use of i2c_8bit_addr_from_msg
  i2c: kempld: make use of i2c_8bit_addr_from_msg
  i2c: mxs: make use of i2c_8bit_addr_from_msg
  i2c: ocores: make use of i2c_8bit_addr_from_msg
  i2c: pasemi: make use of i2c_8bit_addr_from_msg
  i2c: qup: make use of i2c_8bit_addr_from_msg
  i2c: rcar: make use of i2c_8bit_addr_from_msg
  i2c: riic: make use of i2c_8bit_addr_from_msg
  i2c: stu300: make use of i2c_8bit_addr_from_msg
  i2c: xiic: make use of i2c_8bit_addr_from_msg

 drivers/i2c/algos/i2c-algo-bit.c    |  4 +---
 drivers/i2c/algos/i2c-algo-pca.c    |  5 +----
 drivers/i2c/algos/i2c-algo-pcf.c    |  5 +----
 drivers/i2c/busses/i2c-aspeed.c     |  3 +--
 drivers/i2c/busses/i2c-axxia.c      |  5 +++--
 drivers/i2c/busses/i2c-diolan-u2c.c | 11 ++++-------
 drivers/i2c/busses/i2c-efm32.c      |  3 +--
 drivers/i2c/busses/i2c-eg20t.c      |  5 ++---
 drivers/i2c/busses/i2c-emev2.c      |  2 +-
 drivers/i2c/busses/i2c-hix5hd2.c    |  9 ++-------
 drivers/i2c/busses/i2c-imx-lpi2c.c  |  4 +---
 drivers/i2c/busses/i2c-imx.c        | 10 +++++-----
 drivers/i2c/busses/i2c-kempld.c     |  7 +++----
 drivers/i2c/busses/i2c-mxs.c        |  9 +++------
 drivers/i2c/busses/i2c-ocores.c     |  5 +----
 drivers/i2c/busses/i2c-pasemi.c     |  2 +-
 drivers/i2c/busses/i2c-qup.c        |  2 +-
 drivers/i2c/busses/i2c-rcar.c       |  2 +-
 drivers/i2c/busses/i2c-riic.c       |  5 ++---
 drivers/i2c/busses/i2c-stu300.c     | 22 +++++++++++++---------
 drivers/i2c/busses/i2c-xiic.c       | 11 ++---------
 21 files changed, 50 insertions(+), 81 deletions(-)

-- 
2.11.0
