Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 063C1DDF9E
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 03:08:51 +1100 (EST)
Message-Id: <01F4DF20-2DCF-48EE-8405-ABD71E7BA925@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: wael showair <showair2003@yahoo.com>
In-Reply-To: <21479519.post@talk.nabble.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Internal assembler error for instruction icbt
Date: Thu, 15 Jan 2009 10:08:46 -0600
References: <21479519.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 15, 2009, at 9:05 AM, wael showair wrote:

>
> hi All,
> i have LTIB version 6.2.2 with which i have built linux kernel  
> 2.6.19-rc5
> for my board where its processor is MPC8555.i built the kernel Image
> successfuly without any problems
> But Now i want to upgrade the linux kernel to 2.6.27 but  
> unfortunately i got
> the following error:
>
>
> ************************************************************************
> Using /home/test/ltib-6.2.2-sv/rpm/BUILD/linux-2.6.27 as source for  
> kernel
>  GEN     /home/test/ltib-6.2.2-sv/rpm/BUILD/kbuild/mpc8555amc/Makefile
>  CHK     include/linux/version.h
>  CHK     include/linux/utsrelease.h
>  CALL
> /home/test/ltib-6.2.2-sv/rpm/BUILD/linux-2.6.27/scripts/ 
> checksyscalls.sh
>  CHK     include/linux/compile.h
>  CALL
> /home/test/ltib-6.2.2-sv/rpm/BUILD/linux-2.6.27/arch/powerpc/kernel/ 
> systbl_chk.sh
>  CC      arch/powerpc/kernel/prom_init.o
>  CALL
> /home/test/ltib-6.2.2-sv/rpm/BUILD/linux-2.6.27/arch/powerpc/kernel/ 
> prom_init_check.sh
>  BOOTCC  arch/powerpc/boot/4xx.o
> Assembler messages:
> Error: Internal assembler error for instruction icbt
> Internal error, aborting at
> /usr/src/RPM/BUILD/crosstool/source/binutils-2.15/gas/config/tc- 
> ppc.c line
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
>    Bad exit status from /home/test/ltib-6.2.2-sv/tmp/rpm-tmp.81042  
> (%build)
> Failed building kernel-2.6.27-mpc8555amc
> ************************************************************************
>
> i think that i have to upgrade the cross toolchain that i m using,  
> actually
> it is version 3.4.3?
> is there a certain version of toolchain that i have to use to build  
> linux
> kernel 2.6.27?
>
> My last question is how can i upgrade the toolchain i m using?

Newer ltib versions have newer toolchains (like gcc 4.2.x)

- k
