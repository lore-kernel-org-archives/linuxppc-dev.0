Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17389.5168.84286.477133@cargo.ozlabs.ibm.com>
Date: Sat, 11 Feb 2006 09:31:12 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: please pull powerpc-merge.git
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do a pull from

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc-merge.git

Just 4 commits this time.  Log and diffstat follow.

Thanks,
Paul.

Becky Bruce:
      powerpc: Add FSL USB node to documentation

JANAK DESAI:
      powerpc: unshare system call registration

Kumar Gala:
      powerpc: Add CONFIG_DEFAULT_UIMAGE for embedded boards

Paul Mackerras:
      ppc: Use the system call table from arch/powerpc/kernel/systbl.S

 Documentation/powerpc/booting-without-of.txt |   60 +++++-
 arch/powerpc/Kconfig                         |    6 +
 arch/powerpc/Makefile                        |    1 
 arch/powerpc/kernel/Makefile                 |    6 -
 arch/powerpc/kernel/systbl.S                 |    3 
 arch/ppc/kernel/misc.S                       |  283 --------------------------
 include/asm-powerpc/unistd.h                 |    3 
 7 files changed, 72 insertions(+), 290 deletions(-)
