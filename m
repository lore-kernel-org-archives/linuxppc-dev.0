Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18539.30579.62610.116128@cargo.ozlabs.ibm.com>
Date: Wed, 2 Jul 2008 22:41:23 +1000
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

 arch/powerpc/boot/Makefile          |    3 ++-
 arch/powerpc/kernel/legacy_serial.c |    5 +++++
 2 files changed, 7 insertions(+), 1 deletions(-)

John Linn (2):
      powerpc/bootwrapper: update for initrd with simpleImage
      powerpc/legacy_serial: Bail if reg-offset/shift properties are present
