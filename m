Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17930.65420.906528.844499@cargo.ozlabs.ibm.com>
Date: Thu, 29 Mar 2007 09:51:40 +1000
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

to get the dcr_unmap fix posted by Jean-Christophe Dubois.

Thanks,
Paul.

 arch/powerpc/sysdev/dcr.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

commit 190a4408ecb577391ea5fbd1f90148a6992a5756
Author: Jean-Christophe Dubois <jdubois@mc.com>
Date:   Wed Mar 28 11:07:41 2007 +0100

    [POWERPC] Fix dcr_unmap()
    
    Fix a bug in dcr_unmap().
    
    At unmap time the DCR offset need to be added instead of substracted.
    
    Signed-off-by: Jean-Christophe Dubois <jdubois@mc.com>
    Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
