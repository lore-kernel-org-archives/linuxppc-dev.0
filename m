Return-Path: <arnd@arndb.de>
Message-Id: <20070822170124.764128591@arndb.de>
Date: Wed, 22 Aug 2007 19:01:24 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [patch 0/5] (hopefully) final 2.6.23 fixes for cell platform
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

A few bugs came up on the cell platform when testing on the lastest
prototype version of a future hardware. The first three patches are
all meant to track changes required for the fixes that have gone
into the firmware. Patch 4 is for a bug that showed up during testing,
and the final patch is the defconfig update that you probably want
to do for the other platforms as well.

Please forward for inclusion in 2.6.23!

	Arnd <><

diffstat:

 platforms/cell/cbe_regs.h    |    8 +
 platforms/cell/cbe_thermal.c |    6 -
 platforms/cell/pervasive.c   |   26 +++++
 platforms/cell/spu_manage.c  |    2
 sysdev/axonram.c             |   46 ++------
 configs/cell_defconfig       |  220 ++++++++++++------------------------
 6 files changed, 121 insertions(+), 187 deletions(-)


--
