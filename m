Return-Path: <jsteve17@yahoo.com>
Received: from web41415.mail.yahoo.com (web41415.mail.yahoo.com [66.218.93.81])
	by ozlabs.org (Postfix) with SMTP id 13C9F2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Nov 2004 03:18:21 +1100 (EST)
Message-ID: <20041123161139.2563.qmail@web41415.mail.yahoo.com>
Date: Tue, 23 Nov 2004 08:11:39 -0800 (PST)
From: Jeff Stevens <jsteve17@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: U-Boot with DDR ECC Compilation Error
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am porting U-Boot for a custom board that is very
similar to the MPC8540ADS.  Everything compiles fine,
until I try to compile in DDR SDRAM ECC support.  I
tried compiling U-Boot for the MPC8540ADS and I get
the same error once I define 'CONFIG_DDR_ECC'.  Here
is the output:

ppc_8xx-gcc -Wa,-gstabs -D__ASSEMBLY__ -g  -Os   -fPIC
-ffixed-r14 -meabi -D__KERNEL__ -DTEXT_BASE=0xfff80000
-I/orss/gtvme/uboot/u-boot-1.1.1/include -fno-builtin
-ffreestanding -nostdinc -isystem
/usr/lib/gcc/i386-redhat-linux/3.4.2/include -pipe 
-DCONFIG_PPC -D__powerpc__ -DCONFIG_MPC85xx
-DCONFIG_E500 -ffixed-r2 -ffixed-r29 -Wa,-me500
-msoft-float -DCONFIG_MPC85xx=1 -DCONFIG_MPC8540=1
-DCONFIG_E500=1 -c -o cpu/mpc85xx/start.o
/orss/gtvme/uboot/u-boot-1.1.1/cpu/mpc85xx/start.S
/orss/gtvme/uboot/u-boot-1.1.1/include/mpc85xx.h:
Assembler messages:
/orss/gtvme/uboot/u-boot-1.1.1/include/mpc85xx.h:16:
Error: Unrecognized opcode: `void'
/orss/gtvme/uboot/u-boot-1.1.1/include/mpc85xx.h:17:
Error: Unrecognized opcode: `uint'
/orss/gtvme/uboot/u-boot-1.1.1/include/mpc85xx.h:18:
Error: Unrecognized opcode: `int'
make: *** [cpu/mpc85xx/start.o] Error 1


I am using the ppc_8xx- tools from ELDK 3.1. I would
appreciate any help!

Thanks,
   Jeff Stevens




		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - Get yours free! 
http://my.yahoo.com 
 
