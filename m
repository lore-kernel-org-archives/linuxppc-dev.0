Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id D5EB5DDE9F
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Feb 2008 14:24:41 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so357236anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 01 Feb 2008 19:24:40 -0800 (PST)
Date: Fri, 1 Feb 2008 21:24:08 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
Subject: Re: build is broken
Message-ID: <20080201212408.1bdf4acd@zod.rchland.ibm.com>
In-Reply-To: <F795765B112E7344AF36AA911279641502D1AA28@xmb-sjc-212.amer.cisco.com>
References: <F795765B112E7344AF36AA911279641502D1AA28@xmb-sjc-212.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 1 Feb 2008 15:23:21 -0800
"Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com> wrote:

> Hi 
> I just downloaded the latest source tree from :
> git://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
> 
> I am using gnu cross compiler version 3.4.3. I get the an "awk" and
> "assmbeler" error.
> 
> Please help me out. Thanks
> 
> $ <mailto:bizhan@PPC]$>  make ARCH=powerpc
> CROSS_COMPILE=powerpc-linux-gnu- uImage
> awk: cmd. line:1: (FILENAME=- FNR=2) fatal: attempt to access field -1
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CHK     include/linux/compile.h
>   CALL    arch/powerpc/kernel/systbl_chk.sh
>   LD      vmlinux.o
>   MODPOST vmlinux.o
> WARNING: vmlinux.o(.meminit.text+0x9f8): Section mismatch in reference
> from the function free_area_init_node() to the function
> .init.text:__alloc_bootmem_node()
> The function __meminit free_area_init_node() references
> a function __init __alloc_bootmem_node().
> If free_area_init_node is only used by __alloc_bootmem_node then
> annotate free_area_init_node with a matching annotation.
>  
>   AS      .tmp_kallsyms2.o
>   LD      vmlinux
>   SYSMAP  System.map
>   SYSMAP  .tmp_System.map
>   BOOTCC  arch/powerpc/boot/treeboot-walnut.o
> Assembler messages:
> Error: Internal assembler error for instruction icbt
> Internal error, aborting at
> /usr/src/RPM/BUILD/crosstool/source/binutils-2.15/gas/config/tc-ppc.c
> line 1300 in ppc_setup_opcodes
> Please report this bug.
> make[1]: *** [arch/powerpc/boot/treeboot-walnut.o] Error 2
> make: *** [uImage] Error 2

I have no idea why you would get that if you have a properly built
toolchain.  Can you do a fresh compile with V=1 set?

josh
