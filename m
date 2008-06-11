Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: please pull merge branch of cell-2.6.git
Date: Wed, 11 Jun 2008 18:34:26 +0200
References: <200806111828.59043.arnd@arndb.de>
In-Reply-To: <200806111828.59043.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806111834.26811.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please pull the fix I just sent from

  master.kernel.org/pub/scm/linux/kernel/git/arnd/cell-2.6.git merge

Jeremy might want to look at it as well, since he wrote the
code originally.

Thanks,

	Arnd <><

---
Arnd Bergmann <arnd@arndb.de>:
     powerpc/cell: disable ptcal in case of kdump reboot

 arch/powerpc/platforms/cell/ras.c      |    6 ++++++
 arch/powerpc/platforms/cell/ras.h      |    1 +
 arch/powerpc/platforms/cell/setup.c    |    2 +-
 arch/powerpc/platforms/pseries/kexec.c |    2 +-
 4 files changed, 9 insertions(+), 2 deletions(-)
