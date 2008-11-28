Return-Path: <arnd@arndb.de>
Message-Id: <20081128195120.869318403@arndb.de>
Date: Fri, 28 Nov 2008 20:51:20 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 0/4] Please pull merge branch of cell-2.6.git
Cc: paulus@samba.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

These are four bug fixes for the cell platform that I would
still like to see merged in 2.6.28. None of them are regressions,
but they are all nasty bugs that can easily be trigged by users.

If you agree that these are 2.6.28 material, please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/cell-2.6.git merge

Thanks,

	Arnd <><

 arch/powerpc/kernel/entry_64.S         |    2 -
 arch/powerpc/platforms/cell/axon_msi.c |   36 ++++++++++++++++++++++++++++-----
 arch/powerpc/platforms/cell/smp.c      |    9 ++++++--
 arch/powerpc/sysdev/mpic.c             |    9 ++++++--
 4 files changed, 46 insertions(+), 10 deletions(-)
