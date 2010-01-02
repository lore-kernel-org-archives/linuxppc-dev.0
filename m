Return-Path: <wg@denx.de>
From: Wolfgang Grandegger <wg@grandegger.com>
To: Netdev@vger.kernel.org
Subject: [PATCH net-next 0/3] can: mscan-mpc5xxx: add support for the
	Freescale MPC512x
Date: Sat,  2 Jan 2010 09:17:51 +0100
Message-Id: <1262420274-16586-1-git-send-email-wg@grandegger.com>
Cc: Socketcan-core@lists.berlios.de, Devicetree-discuss@lists.ozlabs.org,
	Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series adds support for the MPC512x from Freescale to
the mpc5xxx_can MSCAN driver.

Wolfgang

Wolfgang Grandegger (3):
  can: mscan: fix improper return if dlc < 8 in start_xmit function
  can: mscan-mpc5xxx: add support for the MPC521x processor
  powerpc/mpc5xxx: add OF platform binding doc for FSL MSCAN devices

 Documentation/powerpc/dts-bindings/fsl/can.txt     |   53 +++++
 Documentation/powerpc/dts-bindings/fsl/mpc5200.txt |    9 +-
 drivers/net/can/mscan/Kconfig                      |    2 +-
 drivers/net/can/mscan/mpc5xxx_can.c                |  234 ++++++++++++++++----
 drivers/net/can/mscan/mscan.c                      |   52 ++++-
 drivers/net/can/mscan/mscan.h                      |   81 ++++----
 6 files changed, 333 insertions(+), 98 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/can.txt
