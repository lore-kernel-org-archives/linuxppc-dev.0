Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id BDB0CB7B8C
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 03:46:44 +1100 (EST)
Received: by gxk28 with SMTP id 28so1014888gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 09:46:43 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 15 Oct 2009 10:46:22 -0600
Message-ID: <fa686aa40910150946s70ad4013y15cbf9e29c5e50f2@mail.gmail.com>
Subject: Please pull mpc5200 and OF changes
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben.

Here are some OF and MPC5200 changes needed for 2.6.32.  Mostly
defconfig updates and a couple of new board dts files.

Cheers,
g.

The following changes since commit 161291396e76e0832c08f617eb9bd364d1648148=
:
  Linus Torvalds (1):
        Linux 2.6.32-rc4

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 merge

Grant Likely (1):
      powerpc/5200: Update defconfigs

Heiko Schocher (2):
      mpc5200: support for the MAN mpc5200 based board uc101
      mpc5200: support for the MAN mpc5200 based board mucmc52

Julia Lawall (1):
      drivers/serial/mpc52xx_uart.c: Use UPIO_MEM rather than SERIAL_IO_MEM

J=E9r=F4me Pouiller (1):
      of: Remove nested function

Wolfram Sang (1):
      powerpc/boot/dts: drop obsolete 'fsl5200-clocking'

 arch/powerpc/boot/dts/cm5200.dts              |    1 -
 arch/powerpc/boot/dts/digsy_mtc.dts           |    1 -
 arch/powerpc/boot/dts/lite5200.dts            |    2 -
 arch/powerpc/boot/dts/lite5200b.dts           |    2 -
 arch/powerpc/boot/dts/media5200.dts           |    2 -
 arch/powerpc/boot/dts/motionpro.dts           |    1 -
 arch/powerpc/boot/dts/mpc5121ads.dts          |    3 -
 arch/powerpc/boot/dts/mucmc52.dts             |  332 +++++++++++++++++++++=
++++
 arch/powerpc/boot/dts/pcm030.dts              |    2 -
 arch/powerpc/boot/dts/pcm032.dts              |    2 -
 arch/powerpc/boot/dts/tqm5200.dts             |    1 -
 arch/powerpc/boot/dts/uc101.dts               |  284 +++++++++++++++++++++
 arch/powerpc/configs/52xx/cm5200_defconfig    |  136 ++++++----
 arch/powerpc/configs/52xx/lite5200b_defconfig |  153 ++++++++----
 arch/powerpc/configs/52xx/motionpro_defconfig |  146 +++++++----
 arch/powerpc/configs/52xx/pcm030_defconfig    |  142 ++++++-----
 arch/powerpc/configs/52xx/tqm5200_defconfig   |  148 +++++++----
 arch/powerpc/configs/mpc5200_defconfig        |  192 ++++++++++-----
 arch/powerpc/platforms/52xx/mpc5200_simple.c  |    2 +
 drivers/of/of_mdio.c                          |   13 +-
 drivers/serial/mpc52xx_uart.c                 |    2 +-
 21 files changed, 1196 insertions(+), 371 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mucmc52.dts
 create mode 100644 arch/powerpc/boot/dts/uc101.dts


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
