Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18521.2804.318527.293516@cargo.ozlabs.ibm.com>
Date: Wed, 18 Jun 2008 23:17:40 +1000
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

to get two more small bug-fixes for powerpc, as listed below.

Thanks,
Paul.

 arch/powerpc/kernel/head_44x.S |    7 ++++++-
 arch/powerpc/mm/hash_low_64.S  |    4 ++++
 2 files changed, 10 insertions(+), 1 deletions(-)

Josh Boyer (1):
      [POWERPC] 4xx: Clear new TLB cache attribute bits in Data Storage vector

Paul Mackerras (1):
      [POWERPC] Clear sub-page HPTE present bits when demoting page size
