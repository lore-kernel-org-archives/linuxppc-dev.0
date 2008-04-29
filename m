Return-Path: <glikely@secretlab.ca>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.234])
	by ozlabs.org (Postfix) with ESMTP id 48443DE132
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 23:34:52 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 67so7121wri.3
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 06:34:51 -0700 (PDT)
Message-ID: <fa686aa40804290634j3ee81b1dxc83ea3230af0f163@mail.gmail.com>
Date: Tue, 29 Apr 2008 07:34:50 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Mackerras" <paulus@samba.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Please pull linux-2.6-mpc52xx.git
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following changes since commit 6c39103ce5192bdb2195f3daab7323dfa44fb52e:
  Zhang Wei (1):
        [RAPIDIO] Change RapidIO doorbell source and target ID field to 16-bit

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx.git for-2.6.26

Bartlomiej Sieka (1):
      [POWERPC] mpc5200: defconfigs for CM5200, Lite5200B, Motion-PRO
and TQM5200

Grant Likely (2):
      [POWERPC] mpc5200: Fix unterminated of_device_id table
      [POWERPC] mpc5200: Switch mpc5200 dts files to dts-v1 format

Sascha Hauer (2):
      [POWERPC] mpc5200: add interrupt type function
      [POWERPC] mpc5200: Fix FEC error handling on FIFO errors

s.hauer@pengutronix.de (2):
      [POWERPC] mpc5200: add gpiolib support for mpc5200
      [POWERPC] mpc5200: add Phytec pcm030 board support

 .../powerpc/mpc52xx-device-tree-bindings.txt       |   12 +
 arch/powerpc/boot/dts/cm5200.dts                   |   98 +-
 arch/powerpc/boot/dts/lite5200.dts                 |  132 ++--
 arch/powerpc/boot/dts/lite5200b.dts                |  146 ++--
 arch/powerpc/boot/dts/motionpro.dts                |  118 +-
 arch/powerpc/boot/dts/pcm030.dts                   |  363 ++++++
 arch/powerpc/boot/dts/tqm5200.dts                  |   80 +-
 arch/powerpc/configs/52xx/cm5200_defconfig         | 1099 ++++++++++++++++++
 arch/powerpc/configs/52xx/lite5200b_defconfig      | 1049 +++++++++++++++++
 arch/powerpc/configs/52xx/motionpro_defconfig      | 1107 ++++++++++++++++++
 arch/powerpc/configs/52xx/pcm030_defconfig         | 1115 ++++++++++++++++++
 arch/powerpc/configs/52xx/tqm5200_defconfig        | 1214 ++++++++++++++++++++
 arch/powerpc/platforms/52xx/Kconfig                |    6 +
 arch/powerpc/platforms/52xx/Makefile               |    2 +
 arch/powerpc/platforms/52xx/mpc5200_simple.c       |    1 +
 arch/powerpc/platforms/52xx/mpc52xx_gpio.c         |  465 ++++++++
 arch/powerpc/platforms/52xx/mpc52xx_pic.c          |   38 +
 drivers/net/fec_mpc52xx.c                          |   23 +-
 drivers/serial/mpc52xx_uart.c                      |    2 +-
 19 files changed, 6771 insertions(+), 299 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/pcm030.dts
 create mode 100644 arch/powerpc/configs/52xx/cm5200_defconfig
 create mode 100644 arch/powerpc/configs/52xx/lite5200b_defconfig
 create mode 100644 arch/powerpc/configs/52xx/motionpro_defconfig
 create mode 100644 arch/powerpc/configs/52xx/pcm030_defconfig
 create mode 100644 arch/powerpc/configs/52xx/tqm5200_defconfig
 create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_gpio.c


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
