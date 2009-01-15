Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 1E7E2DE146
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 02:05:49 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LNTmy-0006az-Ts
	for linuxppc-dev@ozlabs.org; Thu, 15 Jan 2009 07:05:44 -0800
Message-ID: <21479519.post@talk.nabble.com>
Date: Thu, 15 Jan 2009 07:05:44 -0800 (PST)
From: wael showair <showair2003@yahoo.com>
To: linuxppc-dev@ozlabs.org
Subject: Internal assembler error for instruction icbt
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


hi All,
i have LTIB version 6.2.2 with which i have built linux kernel 2.6.19-rc5
for my board where its processor is MPC8555.i built the kernel Image
successfuly without any problems
But Now i want to upgrade the linux kernel to 2.6.27 but unfortunately i got
the following error:


************************************************************************
 Using /home/test/ltib-6.2.2-sv/rpm/BUILD/linux-2.6.27 as source for kernel
  GEN     /home/test/ltib-6.2.2-sv/rpm/BUILD/kbuild/mpc8555amc/Makefile
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL   
/home/test/ltib-6.2.2-sv/rpm/BUILD/linux-2.6.27/scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  CALL   
/home/test/ltib-6.2.2-sv/rpm/BUILD/linux-2.6.27/arch/powerpc/kernel/systbl_chk.sh
  CC      arch/powerpc/kernel/prom_init.o
  CALL   
/home/test/ltib-6.2.2-sv/rpm/BUILD/linux-2.6.27/arch/powerpc/kernel/prom_init_check.sh
  BOOTCC  arch/powerpc/boot/4xx.o
Assembler messages:
Error: Internal assembler error for instruction icbt
Internal error, aborting at
/usr/src/RPM/BUILD/crosstool/source/binutils-2.15/gas/config/tc-ppc.c line
1300 in ppc_setup_opcodes
Please report this bug.
make[2]: *** [arch/powerpc/boot/4xx.o] Error 2
make[1]: *** [zImage] Error 2
make: *** [sub-make] Error 2
error: Bad exit status from /home/test/ltib-6.2.2-sv/tmp/rpm-tmp.81042
(%build)


RPM build errors:
    Bad exit status from /home/test/ltib-6.2.2-sv/tmp/rpm-tmp.81042 (%build)
Failed building kernel-2.6.27-mpc8555amc
************************************************************************

i think that i have to upgrade the cross toolchain that i m using, actually
it is version 3.4.3?
is there a certain version of toolchain that i have to use to build linux
kernel 2.6.27?

My last question is how can i upgrade the toolchain i m using?

thanks in advance for ur help
-- 
View this message in context: http://www.nabble.com/Internal-assembler-error-for-instruction-icbt-tp21479519p21479519.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
