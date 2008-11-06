Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18706.21588.724885.947504@cargo.ozlabs.ibm.com>
Date: Thu, 6 Nov 2008 13:20:04 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please pull from the 'merge' branch of

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get three small commits that fix compile errors and a warning on
powerpc.

Thanks,
Paul.

 arch/powerpc/platforms/cell/ras.c          |    1 +
 arch/powerpc/platforms/pseries/pci_dlpar.c |    1 -
 drivers/ps3/ps3-lpm.c                      |    1 +
 3 files changed, 2 insertions(+), 1 deletions(-)

Alexey Dobriyan (2):
      powerpc/ps3: Fix compile error in ps3-lpm.c
      powerpc/cell: Fix compile error in ras.c

Stephen Rothwell (1):
      powerpc: Fix "unused variable" warning in pci_dlpar.c
