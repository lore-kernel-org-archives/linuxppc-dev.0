Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17949.24903.413495.149252@cargo.ozlabs.ibm.com>
Date: Thu, 12 Apr 2007 08:29:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch
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

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get a bugfix from Domen Puncer (via Sylvain Munaut) that should go
in 2.6.21 if possible.

Thanks,
Paul.

 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

commit 22132178b26c907d19f661a4ae7fd265962d417e
Author: Domen Puncer <domen.puncer@telargo.com>
Date:   Wed Apr 11 00:27:49 2007 +0200

    [POWERPC] mpc52xx_pic: fix main interrupt masking
    
    The bit setting was off by one.
    Tested with RTC and GPIO_WKUP interrupts.
    
    Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
    Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
