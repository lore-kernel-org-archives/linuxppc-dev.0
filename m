Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 1B1DBDDEF1
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 00:09:21 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LTyY9-00074l-BN
	for linuxppc-dev@ozlabs.org; Mon, 02 Feb 2009 05:09:17 -0800
Message-ID: <21789373.post@talk.nabble.com>
Date: Mon, 2 Feb 2009 05:09:17 -0800 (PST)
From: martin1234 <mvdeventer_ase@telkomsa.net>
To: linuxppc-dev@ozlabs.org
Subject: Re: Internal assembler error for instruction icbt
In-Reply-To: <21479519.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <21479519.post@talk.nabble.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>




wael showair wrote:
> 
> hi All,
> i have LTIB version 6.2.2 with which i have built linux kernel 2.6.19-rc5
> for my board where its processor is MPC8555.i built the kernel Image
> successfuly without any problems
> But Now i want to upgrade the linux kernel to 2.6.27 but unfortunately i
> got the following error:
> 
> 
> ************************************************************************
>  Using /home/test/ltib-6.2.2-sv/rpm/BUILD/linux-2.6.27 as source for
> kernel
>   GEN     /home/test/ltib-6.2.2-sv/rpm/BUILD/kbuild/mpc8555amc/Makefile
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CALL   
> /home/test/ltib-6.2.2-sv/rpm/BUILD/linux-2.6.27/scripts/checksyscalls.sh
>   CHK     include/linux/compile.h
>   CALL   
> /home/test/ltib-6.2.2-sv/rpm/BUILD/linux-2.6.27/arch/powerpc/kernel/systbl_chk.sh
>   CC      arch/powerpc/kernel/prom_init.o
>   CALL   
> /home/test/ltib-6.2.2-sv/rpm/BUILD/linux-2.6.27/arch/powerpc/kernel/prom_init_check.sh
>   BOOTCC  arch/powerpc/boot/4xx.o
> Assembler messages:
> Error: Internal assembler error for instruction icbt
> Internal error, aborting at
> /usr/src/RPM/BUILD/crosstool/source/binutils-2.15/gas/config/tc-ppc.c line
> 1300 in ppc_setup_opcodes
> Please report this bug.
> make[2]: *** [arch/powerpc/boot/4xx.o] Error 2
> make[1]: *** [zImage] Error 2
> make: *** [sub-make] Error 2
> error: Bad exit status from /home/test/ltib-6.2.2-sv/tmp/rpm-tmp.81042
> (%build)
> 
> 
> RPM build errors:
>     Bad exit status from /home/test/ltib-6.2.2-sv/tmp/rpm-tmp.81042
> (%build)
> Failed building kernel-2.6.27-mpc8555amc
> ************************************************************************
> 
> i think that i have to upgrade the cross toolchain that i m using,
> actually it is version 3.4.3?
> is there a certain version of toolchain that i have to use to build linux
> kernel 2.6.27?
> 
> My last question is how can i upgrade the toolchain i m using?
> 
> thanks in advance for ur help
> 


HI there

Did you ever find out how to update the toolchain that you are using

I'm trying to crosscompile for the powerpc and get the same error, I also
need to update to an newer toolchain,
I'm currently using Suse11.1. Any advise will be wellcome, thanks...
-- 
View this message in context: http://www.nabble.com/Internal-assembler-error-for-instruction-icbt-tp21479519p21789373.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
