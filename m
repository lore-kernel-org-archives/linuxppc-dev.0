Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 82CA0DE074
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 02:01:50 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull next branch of cell.git
Date: Wed, 13 May 2009 18:01:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200905131801.38243.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

I have three small fixes for Cell that I'd like you to
add to your powerpc tree.

git pull git.kernel.org:/pub/scm/linux/kernel/git/arnd/cell-2.6.git next

The first two patches might still be good to have in 2.6.30,
the patch from Jan is just a cleanup for 2.6.31.

Thanks,

	Arnd <><
---

commit 2de7d2f19196445eecc89e161a6ae0a3e3f272b9
Author: Jan Blunck <jblunck@suse.de>

    powerpc/spufs: remove double check for non-negative dentry

 arch/powerpc/platforms/cell/spufs/inode.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

commit f1eaf5e7b1b0c5140e4b730d81b966cd37ff2245
Author: Benjamin Krill <ben@codiert.org>

    serial/nwpserial: fix wrong register read address and add interrupt acknowledge.

 drivers/serial/nwpserial.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

commit f0cbc66cf73524e0c97957bc909d263810c4f339
Author: Gerhard Stenzel <stenzel@de.ibm.com>

    powerpc/cell: make ptcal more reliable

 arch/powerpc/platforms/cell/ras.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)
