Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17905.52447.829667.16759@cargo.ozlabs.ibm.com>
Date: Sat, 10 Mar 2007 08:08:47 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Re: Please pull powerpc.git merge branch
In-Reply-To: <17903.35471.818872.293459@cargo.ozlabs.ibm.com>
References: <17903.35471.818872.293459@cargo.ozlabs.ibm.com>
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

I wrote:

> Please do:
> 
> git pull \
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge
> 
> There are 6 commits there.  Three of them fix compile warnings, one is
> a bug fix, one works around a problem on rev 1.0 PPC970MP processors,
> and one adds a missing newline in some help text.

I have pulled 3 more commits from Kumar Gala and pushed them out, so
when you do the pull you'll see the commits below in addition to the
ones I listed previously.

Thanks,
Paul.

 arch/powerpc/platforms/83xx/mpc834x_mds.c  |    8 ++++----
 arch/powerpc/platforms/85xx/Kconfig        |    1 +
 arch/powerpc/platforms/embedded6xx/Kconfig |    1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

commit f194bda4ce7e71cc95535f494a4a5515cd91ed85
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Wed Mar 7 23:14:57 2007 -0600

    [POWERPC] 85xx: Enable CONFIG_SERIAL_8250_SHARE_IRQ
    
    On chip 8250 UARTs share an interrupts on existing 85xx processors.
    
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 49fdf3f078f8f5d84ecd10d62624c9158e755ec7
Author: Segher Boessenkool <segher@kernel.crashing.org>
Date:   Thu Feb 22 23:52:02 2007 +0100

    [POWERPC] Select u-image as default image for Linkstation
    
    Fixes image build error:
    
    ln: accessing `arch/powerpc/boot/zImage': No such file or directory
    make[1]: *** [arch/powerpc/boot/zImage] Error 1
    make: *** [zImage] Error 2
    
    Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
    Acked-by: G. Liakhovetski <g.liakhovetski@gmx.de>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit aea12b75480c0842028bd1bfe0146d9148db2298
Author: Li Yang <leoli@freescale.com>
Date:   Tue Mar 6 17:11:06 2007 +0800

    [POWERPC] 83xx: Minor fixes for 834x_mds USB setup code
    
    Fix broken node manipulating code, and clarify inaccurate comment.
    
    Signed-off-by: Li Yang <leoli@freescale.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
