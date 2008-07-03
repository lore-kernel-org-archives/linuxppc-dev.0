Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18540.6326.714792.742146@cargo.ozlabs.ibm.com>
Date: Thu, 3 Jul 2008 10:09:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch
In-Reply-To: <18539.30579.62610.116128@cargo.ozlabs.ibm.com>
References: <18539.30579.62610.116128@cargo.ozlabs.ibm.com>
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

Grant Likely sent me one more bug-fix for 2.6.26, which I have merged
into my merge branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

So when you do the pull from there, you'll get 3 commits as listed
below.

Thanks,
Paul.

 arch/powerpc/boot/Makefile                |    3 ++-
 arch/powerpc/kernel/legacy_serial.c       |    5 +++++
 arch/powerpc/platforms/52xx/lite5200_pm.c |   14 +++++++++++++-
 3 files changed, 20 insertions(+), 2 deletions(-)

John Linn (2):
      powerpc/bootwrapper: update for initrd with simpleImage
      powerpc/legacy_serial: Bail if reg-offset/shift properties are present

Tim Yamin (1):
      powerpc/mpc5200: Fix lite5200b suspend/resume
