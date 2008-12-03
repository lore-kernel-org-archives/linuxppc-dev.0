Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18742.27860.32471.101697@cargo.ozlabs.ibm.com>
Date: Wed, 3 Dec 2008 22:26:12 +1100
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

Please pull from the 'merge' branch of

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get one commit from Ben Herrenschmidt that fixes a regression since
2.6.27.

Thanks,
Paul.

 arch/powerpc/kernel/dma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

commit 2434bbb30e79468c49cff3cff6005236f55ed188
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Sun Nov 30 18:53:40 2008 +0000

    powerpc: Fix dma_map_sg() cache flushing on non coherent platforms
    
    On PowerPC 4xx or other non cache-coherent platforms, we lost the
    appropriate cache flushing in dma_map_sg() when merging the 32 and
    64-bit DMA code (commit 4fc665b88a79a45bae8bbf3a05563c27c7337c3d,
    "powerpc: Merge 32 and 64-bit dma code").  This restores it.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Acked-by: Becky Bruce <beckyb@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
