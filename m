Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18749.61556.325147.855082@cargo.ozlabs.ibm.com>
Date: Tue, 9 Dec 2008 15:13:40 +1100
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

to get two more small commits for powerpc; one is a very small
defconfig update, and the other fixes a bug that can lead to an oops
on some 440-family embedded powerpc processors.

Thanks,
Paul.

 arch/powerpc/configs/83xx/mpc834x_itx_defconfig |    2 +-
 arch/powerpc/configs/mpc83xx_defconfig          |    2 +-
 arch/powerpc/kernel/cpu_setup_44x.S             |    1 +
 arch/powerpc/kernel/cputable.c                  |    3 +++
 4 files changed, 6 insertions(+), 2 deletions(-)

Anton Vorontsov (1):
      powerpc/83xx: Enable FIXED_PHY in mpc834x_itx and mpc83xx defconfigs

Grant Likely (1):
      powerpc/virtex5: Fix Virtex5 machine check handling
