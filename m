Return-Path: <grant.likely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH 0/5] dt: Device creation infrastructure
To: Nicolas Pitre <nicolas.pitre@linaro.org>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 21 Jun 2011 12:44:47 -0600
Message-ID: <20110621181127.18176.1384.stgit@ponder>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds infrastructure for generating platform and amba
devices based on device tree data.  I intend to queue up this series
for the v3.1 merge window.  I had already posted these patches earlier
in the "Full device tree support for ARM Versatile" RFC series.  They
haven't changed since I posted that.

Unless I hear otherwise, I'll put the first 4 patches into
devicetree/next later this week.  The fifth patch can either go via
devicetree/next or benh's powerpc tree (your choice Ben).

g.

---

Grant Likely (5):
      dt: Add default match table for bus ids
      dt: add of_platform_populate() for creating device from the device tree
      drivers/amba: create devices from device tree
      dt/platform: allow device name to be overridden
      powerpc/5200: convert mpc5200 to use of_platform_populate()


 .../devicetree/bindings/arm/primecell.txt          |   21 ++
 arch/powerpc/platforms/52xx/mpc52xx_common.c       |   10 -
 drivers/of/platform.c                              |  196 +++++++++++++++++++-
 include/linux/of_platform.h                        |   40 ++++
 4 files changed, 252 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/primecell.txt
