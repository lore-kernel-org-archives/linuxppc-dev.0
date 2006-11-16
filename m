Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17755.51877.237558.694965@cargo.ozlabs.ibm.com>
Date: Thu, 16 Nov 2006 13:19:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: Please pull powerpc.git 'merge' branch
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

Since the mirroring on kernel.org is slow today, please do:

git pull \
master.kernel.org:/pub/scm/linux/kernel/git/paulus/powerpc.git merge

or, once the mirror catches up:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get the two commits from Stephen Rothwell listed below.

Thanks,
Paul.

 include/asm-powerpc/systbl.h   |    1 +
 include/asm-powerpc/topology.h |    8 +++++++-
 include/asm-powerpc/unistd.h   |    3 ++-
 3 files changed, 10 insertions(+), 2 deletions(-)

commit 9716a340310a383751a06589d0775fad04bd3f54
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Mon Nov 13 14:52:42 2006 +1100

    [POWERPC] Wire up sys_move_pages
    
    All the infrastructure is already in place for this, so we only need
    to allocate a syscall number and hook it up.
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 056f4faa572f64fa926491a7d42c627c9dc507a7
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Mon Nov 13 14:51:46 2006 +1100

    [POWERPC] Add the thread_siblings files to sysfs
    
    This adds the /sys/devices/system/cpu/*/topology/thread_siblings
    files on powerpc.  These files are already available on other
    architectures.
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
