Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18743.5311.794489.670294@cargo.ozlabs.ibm.com>
Date: Thu, 4 Dec 2008 10:22:39 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch
In-Reply-To: <18742.27860.32471.101697@cargo.ozlabs.ibm.com>
References: <18742.27860.32471.101697@cargo.ozlabs.ibm.com>
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

I wrote:

> Please pull from the 'merge' branch of
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge
> 
> to get one commit from Ben Herrenschmidt that fixes a regression since
> 2.6.27.

I have just added one more commit from Kumar's merge branch, so when
you pull the diffstat should be:

 arch/powerpc/boot/dts/mpc8349emitx.dts |   16 ++++++++--------
 arch/powerpc/kernel/dma.c              |    1 +
 2 files changed, 9 insertions(+), 8 deletions(-)

If you had already pulled, please pull again, or pull Kumar's merge
branch directly.

Thanks,
Paul.

Anton Vorontsov (1):
      powerpc/83xx: Fix MCU support merge issue in mpc8349emitx.dts

Benjamin Herrenschmidt (1):
      powerpc: Fix dma_map_sg() cache flushing on non coherent platforms
