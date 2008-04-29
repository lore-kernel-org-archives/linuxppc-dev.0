Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <18455.1713.268188.906051@cargo.ozlabs.ibm.com>
Date: Tue, 29 Apr 2008 21:29:53 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: [git pull] Please pull powerpc.git master branch
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

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git master=


There are 14 commits there that Andrew Morton sent to me to merge,
from Badari Pulavarty (memory hot-remove stuff) and Zhang Wei (RapidIO
patches).  Plus there are 5 other powerpc-related patches: a patch
from me adding a fast endian-switch system call, a patch from Kumar
Gala that lets 32-bit use separate stacks for hard and soft IRQs like
64-bit already does, a build fix from Tony Breeds, a patch from me to
make powerpc build OK if inline doesn't mean __always_inline, and a
thermal driver for one of the last G5 powermac models.

Thanks,
Paul.

Badari Pulavarty (3):
      [POWERPC] Hotplug memory remove notifications for powerpc
      [POWERPC] Update lmb data structures for hotplug memory add/remov=
e
      [POWERPC] Provide walk_memory_resource() for powerpc

Kumar Gala (1):
      [POWERPC] Add IRQSTACKS support on ppc32

Paul Mackerras (2):
      [POWERPC] Add fast little-endian switch system call
      [POWERPC] Use __always_inline for xchg* and cmpxchg*

Tony Breeds (1):
      [POWERPC] Fix building of pmac32 when CONFIG_NVRAM=3Dm

Zhang Wei (11):
      [RAPIDIO] Change RIO function mpc85xx_ to fsl_
      [RAPIDIO] Add RapidIO option to kernel configuration
      [RAPIDIO] Move include/asm-ppc/rio.h to asm-powerpc
      [RAPIDIO] Add RapidIO multi mport support
      [RAPIDIO] Add OF-tree support to RapidIO controller driver
      [RAPIDIO] Auto-probe the RapidIO system size
      [RAPIDIO] Add RapidIO node into MPC8641HPCN dts file
      [RAPIDIO] Add RapidIO node probing into MPC86xx_HPCN board id tab=
le
      [RAPIDIO] Add serial RapidIO controller support, which includes M=
PC8548, MPC8641
      [RAPIDIO] Add RapidIO connection info print out and re-training f=
or broken connections
      [RAPIDIO] Change RapidIO doorbell source and target ID field to 1=
6-bit

=C9tienne Bersac (1):
      [POWERPC] windfarm: Add PowerMac 12,1 support
