Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f174.google.com (mail-gx0-f174.google.com
	[209.85.217.174]) by ozlabs.org (Postfix) with ESMTP id 15EB9DE27E
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 03:12:30 +1100 (EST)
Received: by gxk22 with SMTP id 22so252815gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 09:12:29 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 11 Mar 2009 10:12:29 -0600
Message-ID: <fa686aa40903110912n6b4bca2w7834de69e519679d@mail.gmail.com>
Subject: Please pull mpc52xx-next
From: Grant Likely <grant.likely@secretlab.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hey Ben, here's another -next pull request.  I think this exhausts
everything in my queue.  I'm sure someone will tell me if I've missed
anything.  I'll update patchwork later today.

One commit is outside of arch/powerpc, but it is a xilinx-only change
to an SPI driver, and David has acked it.

Cheers,
g.

The following changes since commit e7eec2fc27d7dbefd5852c36b3fe6229e6302c99:
  roel kluin (1):
        powerpc/ps3: Make ps3av_set_video_mode mode ID signed

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx next

Grant Likely (2):
      powerpc/5200: remove sysfs debug file from GPT driver
      powerpc/bootwrapper: add fixed-head.o to simpleimage wrappers

John Linn (1):
      powerpc/virtex/spi: Xilinx SPI driver not releasing memory

Wolfgang Grandegger (1):
      powerpc/5200: add function to return external clock frequency

Wolfram Sang (1):
      powerpc/5200: add Phytec phyCORE-MPC5200B-IO board (pcm032)

 arch/powerpc/boot/dts/pcm032.dts             |  392 ++++++++++++++++++++++++++
 arch/powerpc/boot/wrapper                    |    4 +-
 arch/powerpc/include/asm/mpc52xx.h           |    1 +
 arch/powerpc/platforms/52xx/Kconfig          |    1 +
 arch/powerpc/platforms/52xx/mpc5200_simple.c |    3 +-
 arch/powerpc/platforms/52xx/mpc52xx_common.c |   37 +++
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c    |   39 ---
 drivers/spi/xilinx_spi.c                     |    9 +-
 8 files changed, 442 insertions(+), 44 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/pcm032.dts


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
