Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com
	[209.85.161.170]) by ozlabs.org (Postfix) with ESMTP id 901F4B70CC
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 09:09:51 +1000 (EST)
Received: by gxk25 with SMTP id 25so1932715gxk.15
	for <linuxppc-dev@ozlabs.org>; Sun, 01 Aug 2010 16:09:50 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 1 Aug 2010 17:09:29 -0600
Message-ID: <AANLkTindyQmCWfRvb92bHnGR_8CviO22SrqacAKEp7Q3@mail.gmail.com>
Subject: [git pull] powerpc 5xxx and xilinx virtex changes
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>,
	Anatolij Gustschin <agust@denx.de>, Adrian Alonso <aalonso00@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Here are the mpc5xxx and Xilinx virtex changes I've collected for the
2.6.36 merge window.  Please pull.

g.

The following changes since commit b37fa16e78d6f9790462b3181602a26b5af36260=
:
  Linus Torvalds (1):
        Linux 2.6.35-rc6

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 next

Adrian Alonso (1):
      of/xilinxfb: update tft compatible versions

Albrecht Dre=DF (2):
      powerpc/5200: improve uart baud rate calculation (reach high
baud rates, better accuracy)
      powerpc/5200/i2c: improve i2c bus error recovery

Anatolij Gustschin (8):
      powerpc/512x: Group mpc512x board's selection menu
      powerpc/5121: add initial support for PDM360NG board
      powerpc/512x: add clock structure for Video-IN (VIU) unit
      powerpc/5121: fsl-diu-fb: fix issue with re-enabling DIU area descrip=
tor
      powerpc/5121: move fsl-diu-fb.h to include/linux
      powerpc/5121: shared DIU framebuffer support
      powerpc/5121: doc/dts-bindings: update doc of FSL DIU bindings
      powerpc/fsl-diu-fb: Support setting display mode using EDID

 Documentation/powerpc/dts-bindings/fsl/diu.txt |   20 +-
 Documentation/powerpc/dts-bindings/fsl/i2c.txt |    2 +
 arch/powerpc/boot/dts/pdm360ng.dts             |  410 ++++++++++++++++++++=
++++
 arch/powerpc/include/asm/mpc5121.h             |   32 ++
 arch/powerpc/platforms/512x/Kconfig            |   20 +-
 arch/powerpc/platforms/512x/Makefile           |    1 +
 arch/powerpc/platforms/512x/clock.c            |   18 +
 arch/powerpc/platforms/512x/mpc5121_ads.c      |    2 +
 arch/powerpc/platforms/512x/mpc5121_generic.c  |    2 +
 arch/powerpc/platforms/512x/mpc512x.h          |    2 +
 arch/powerpc/platforms/512x/mpc512x_shared.c   |  284 ++++++++++++++++
 arch/powerpc/platforms/512x/pdm360ng.c         |  129 ++++++++
 arch/powerpc/sysdev/fsl_soc.h                  |    1 +
 drivers/i2c/busses/i2c-mpc.c                   |   69 +++--
 drivers/serial/mpc52xx_uart.c                  |  145 +++++++--
 drivers/video/Kconfig                          |    1 +
 drivers/video/fsl-diu-fb.c                     |  137 +++++++--
 drivers/video/xilinxfb.c                       |    2 +
 {drivers/video =3D> include/linux}/fsl-diu-fb.h  |    0
 19 files changed, 1191 insertions(+), 86 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/pdm360ng.dts
 create mode 100644 arch/powerpc/platforms/512x/pdm360ng.c
 rename {drivers/video =3D> include/linux}/fsl-diu-fb.h (100%)


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
