Return-Path: <wg@denx.de>
From: Wolfgang Grandegger <wg@grandegger.com>
To: Linux-i2c@vger.kernel.org
Subject: [PATCH v4 0/3] i2c-mpc: add support for the Freescale MPC512x and
	other fixes
Date: Thu, 28 Jan 2010 14:25:38 +0100
Message-Id: <1264685141-26391-1-git-send-email-wg@grandegger.com>
Cc: Devicetree-discuss@lists.ozlabs.org, Linuxppc-dev@lists.ozlabs.org,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series adds support for the MPC512x from Freescale to the
i2c-mpc driver. At that occasion, issues with  __devinit[data] have
been fixed and the doc of the FSL I2C dts bindings updated. It has
been tested on a MPC5121ADS, TQM5200 and TQM8560 board

Changes since v1:

- use macro MPC_I2C_CLOCK_PRESERVE/SAFE for the special clock settings.
- document the special DTS node "fsl,mpc5121-i2c-ctrl".
- update and correct the Kconfig help.
- some other minor fixes as suggested by Wolfram.

Changes since v2:

- use __init[data] instead of __devinit[data] for this driver.

Changes since v3:

- switch back to __devinit[data] as pointed out by Ben.

Wolfgang

Wolfgang Grandegger (3):
  i2c-mpc: use __devinit[data] for initialization functions and data
  i2c-mpc: add support for the MPC512x processors from Freescale
  powerpc: doc/dts-bindings: update doc of FSL I2C bindings

 Documentation/powerpc/dts-bindings/fsl/i2c.txt |   30 +++-
 drivers/i2c/busses/Kconfig                     |    7 +-
 drivers/i2c/busses/i2c-mpc.c                   |  194 +++++++++++++++---------
 3 files changed, 148 insertions(+), 83 deletions(-)
