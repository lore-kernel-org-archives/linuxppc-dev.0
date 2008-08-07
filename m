Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 709A3DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Aug 2008 19:57:23 +1000 (EST)
Message-ID: <489AC777.80305@coritel.it>
Date: Thu, 07 Aug 2008 11:59:19 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Fabien Oriede <fabien.oriede@yahoo.fr>
Subject: Re: kernel 2.6.26 & gcc 4.0.0
References: <75390.18655.qm@web27403.mail.ukl.yahoo.com>
In-Reply-To: <75390.18655.qm@web27403.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fabien Oriede ha scritto:
> Hello all,
> I'm trying to put a cramfs image on my custom board, and for this, I have followed this topic : http://www.denx.de/wiki/view/DULG/RootFileSystemOnACramfsFileSystem
> Now I have my cramfs image, but I have seen that I need to download my cramfs image in a mtdblock and for that, I need to set some MTD options in the kernel. (http://www.denx.de/wiki/view/DULG/FlashFilesystemsMTD)
> But when I make the command "make uImage", I have this problem :
> [root@xxxx linux-2.6.26]# make uImage
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CHK     include/linux/compile.h
>   CALL    arch/powerpc/kernel/systbl_chk.sh
>   CC      arch/ppc/syslib/m8xx_setup.o
> arch/ppc/syslib/m8xx_setup.c:68: error: array type has incomplete element type
> arch/ppc/syslib/m8xx_setup.c:70: error: field name not in record or union initializer
> arch/ppc/syslib/m8xx_setup.c:70: error: (near initialization for 'mpc8xxads_partitions')
> arch/ppc/syslib/m8xx_setup.c:71: error: field name not in record or union initializer
> arch/ppc/syslib/m8xx_setup.c:71: error: (near initialization for 'mpc8xxads_partitions')
> arch/ppc/syslib/m8xx_setup.c:72: error: field name not in record or union initializer
> arch/ppc/syslib/m8xx_setup.c:72: error: (near initialization for 'mpc8xxads_partitions')
> arch/ppc/syslib/m8xx_setup.c:73: error: field name not in record or union initializer
> arch/ppc/syslib/m8xx_setup.c:73: error: (near initialization for 'mpc8xxads_partitions')
> arch/ppc/syslib/m8xx_setup.c:73: error: 'MTD_WRITEABLE' undeclared here (not in a function)
> arch/ppc/syslib/m8xx_setup.c:75: error: field name not in record or union initializer
> arch/ppc/syslib/m8xx_setup.c:75: error: (near initialization for 'mpc8xxads_partitions')
> arch/ppc/syslib/m8xx_setup.c:76: error: field name not in record or union initializer
> arch/ppc/syslib/m8xx_setup.c:76: error: (near initialization for 'mpc8xxads_partitions')
> arch/ppc/syslib/m8xx_setup.c: In function 'm8xx_show_percpuinfo':
> arch/ppc/syslib/m8xx_setup.c:312: warning: format '%u' expects type 'unsigned int', but argument 3 has type 'long unsigned int'
> arch/ppc/syslib/m8xx_setup.c:312: warning: format '%u' expects type 'unsigned int', but argument 4 has type 'long unsigned int'
> arch/ppc/syslib/m8xx_setup.c: In function 'platform_init':
> arch/ppc/syslib/m8xx_setup.c:451: warning: assignment from incompatible pointer type
> make[1]: *** [arch/ppc/syslib/m8xx_setup.o] Erreur 1
> make: *** [arch/ppc/syslib] Erreur 2
> 
> [root@xxxx linux-2.6.26]# powerpc-linux-gcc --version
> powerpc-linux-gcc (GCC) 4.0.0 (DENX ELDK 4.1 4.0.0)
> Copyright (C) 2005 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE
> It seems that this is a problem with the version 4 of the gcc, and I would like to know if I need to change for an old version of gcc ? like 3.0. Or may be a patch exists to bring down this problem ?
> Thanks in advance.
> Regards,
> Fabien.
> 
> 
>       _____________________________________________________________________________ 
> Envoyez avec Yahoo! Mail. Une boite mail plus intelligente http://mail.yahoo.fr
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

Have you modified that file?

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
