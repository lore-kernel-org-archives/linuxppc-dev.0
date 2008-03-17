Return-Path: <bunk@kernel.org>
Received: from smtp5.pp.htv.fi (smtp5.pp.htv.fi [213.243.153.39])
	by ozlabs.org (Postfix) with ESMTP id 3BA56DDF53
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 06:37:13 +1100 (EST)
Date: Mon, 17 Mar 2008 21:36:52 +0200
From: Adrian Bunk <bunk@kernel.org>
To: Kumar Gala <galak@kernel.crashing.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Paul Mackerras <paulus@samba.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: powerpc: cuImage.* creation error
Message-ID: <20080317193652.GA9550@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When building all powerpc defconfigs in 2.6.25-rc6 exactly three of 
them fail to build, and all with similar problems:


mpc85xx_defconfig:

<--  snip  -->

...
  WRAP    arch/powerpc/boot/cuImage.tqm8540
DTC: dts->dtb  on file "/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/powerpc/boot/dts/tqm8540.dts"
powerpc64-linux-ld: arch/powerpc/boot/cuboot-tqm8540.o: No such file: No such file or directory
make[2]: *** [arch/powerpc/boot/cuImage.tqm8540] Error 1

<--  snip  -->


sbc8548_defconfig:

<--  snip  -->

...
Entry Point:  0x00000000
make[2]: *** No rule to make target `arch/powerpc/boot/cuImage.tqm8548', needed by `arch/powerpc/boot/zImage'.  Stop.

<--  snip  -->


tqm8540_defconfig:

<--  snip  -->

...
  WRAP    arch/powerpc/boot/cuImage.tqm8540
DTC: dts->dtb  on file "/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/powerpc/boot/dts/tqm8540.dts"
powerpc64-linux-ld: arch/powerpc/boot/cuboot-tqm8540.o: No such file: No such file or directory
make[2]: *** [arch/powerpc/boot/cuImage.tqm8540] Error 1

<--  snip  -->


Is this a problem on my side or is there a bug that should be fixed?


TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
