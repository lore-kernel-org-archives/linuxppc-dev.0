Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org,
 linux-mtd@lists.infradead.org
Subject: [PATCH 0/4 v2] mtd: physmap_of: Add multiple regions and
	concatenation support
Date: Tue, 7 Apr 2009 10:36:10 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200904071036.11184.sr@denx.de>
Cc: devicetree-discuss <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patchset adds support to handle multiple non-identical chips in one
flash device tree node. It also adds concat support to physmap_of. This
makes it possible to support e.g. the Intel P30 48F4400 chip which
internally consists of 2 non-identical NOR chips on one die. Additionally
partitions now can span over multiple chips:

    mtd: physmap_of: Add multiple regions and concatenation support
    mtd/powerpc: Factor out MTD physmap bindings into mtd-physmap.txt
    mtd/powerpc: Remove unused "device-width" property
    mtd/powerpc: Describe multiple "reg" tuples usage

v2 addresses all comments from Grant Likely, including factoring out the
MTD dts bindings documentation into a separate file.

Thanks,
Stefan
