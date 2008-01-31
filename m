Return-Path: <lorenzo@alphagolf.com>
Received: from fallback-mx1.atl.registeredsite.com
	(fallback-mx1.atl.registeredsite.com [64.224.219.95])
	by ozlabs.org (Postfix) with ESMTP id 8ADA5DDDF7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Jan 2008 12:44:04 +1100 (EST)
Received: from mail26.atl.registeredsite.com (mail26.atl.registeredsite.com
	[216.247.37.21])
	by fallback-mx1.atl.registeredsite.com (8.12.11.20060308/8.12.11) with
	ESMTP id m0V15hfm006507
	for <linuxppc-embedded@ozlabs.org>; Wed, 30 Jan 2008 20:05:43 -0500
Received: from imta06a2.registeredsite.com (imta06a2.registeredsite.com
	[64.225.255.15])
	by mail26.atl.registeredsite.com (8.12.11.20060308/8.12.11) with ESMTP
	id m0V15Ukt016872
	for <linuxppc-embedded@ozlabs.org>; Wed, 30 Jan 2008 20:05:30 -0500
Received: from [192.168.1.118] ([71.198.169.42])
	by imta06a2.registeredsite.com with ESMTP id
	<20080131010530.WVKP23784.imta06a2.registeredsite.com@[192.168.1.118]>
	for <linuxppc-embedded@ozlabs.org>; Wed, 30 Jan 2008 20:05:30 -0500
Message-ID: <47A11DCD.208@alphagolf.com>
Date: Wed, 30 Jan 2008 17:01:01 -0800
From: "Lorenzo T. Flores" <lorenzo@alphagolf.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: compilation errors...sorry, sigh...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hey all,

I was wondering if anyone could help me figure out what to do next as 
far as some compilation errors are concerned.

I'm working with an Avnet 4vfx12ls eval board (has virtex-4 and PPC).

Now, I've generated BSP files using Xilinx XPS, and from past posts on 
this forum found the Secret Lab's virtex 2.6 git tree (not sure if I'm 
using proper terminology, feel free to correct me, please!)

Well, I copied in the BSP files into the distribution. Ran 'make 
menuconfig' then 'make bzImage'

Here's the errors I get:

---------------------------------------------------------------------
 GEN     .version
  CHK     include/linux/compile.h
dnsdomainname: Unknown host
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
kernel/built-in.o: In function `enable_all_kprobes':
kernel/kprobes.c:926: undefined reference to `arch_arm_kprobe'
kernel/built-in.o: In function `disable_all_kprobes':
kernel/kprobes.c:957: undefined reference to `arch_disarm_kprobe'
kernel/kprobes.c:956: undefined reference to `arch_trampoline_kprobe'
kernel/built-in.o: In function `init_kprobes':
kernel/kprobes.c:823: undefined reference to `arch_init_kprobes'
kernel/built-in.o: In function `report_probe':
kernel/kprobes.c:838: undefined reference to `setjmp_pre_handler'
kernel/kprobes.c:838: undefined reference to `setjmp_pre_handler'
kernel/built-in.o: In function `unregister_kprobe':
kernel/kprobes.c:610: undefined reference to `arch_disarm_kprobe'
kernel/kprobes.c:632: undefined reference to `arch_remove_kprobe'
kernel/built-in.o: In function `pre_handler_kretprobe':
kernel/kprobes.c:702: undefined reference to `arch_prepare_kretprobe'
kernel/built-in.o: In function `in_kprobes_functions':
kernel/kprobes.c:495: undefined reference to `__kprobes_text_start'
kernel/kprobes.c:495: undefined reference to `__kprobes_text_start'
kernel/kprobes.c:495: undefined reference to `__kprobes_text_end'
kernel/kprobes.c:495: undefined reference to `__kprobes_text_end'
kernel/built-in.o: In function `__register_kprobe':
kernel/kprobes.c:556: undefined reference to `arch_prepare_kprobe'
kernel/kprobes.c:565: undefined reference to `arch_arm_kprobe'
kernel/built-in.o: In function `register_jprobe':
kernel/kprobes.c:669: undefined reference to `setjmp_pre_handler'
kernel/kprobes.c:669: undefined reference to `setjmp_pre_handler'
kernel/kprobes.c:670: undefined reference to `longjmp_break_handler'
kernel/kprobes.c:670: undefined reference to `longjmp_break_handler'
kernel/built-in.o:(__ksymtab_gpl+0x398): undefined reference to 
`jprobe_return'
kernel/built-in.o:(.data+0x4a84): undefined reference to 
`kprobe_exceptions_notify'
make: *** [.tmp_vmlinux1] Error 1
---------------------------------------------------------------------

I'm using ELDK's ppc_4xx toolchain.

Any info or links to relevant posts would be so much appreciated. I 
looked through the archives and know my answers are probably in there 
somewhere...I'm just not sure if I could distill the proper information.

Thank you all for any input!

best,
Lorenzo Flores



-- 
Embedded Systems Engineer
Alpha Golf
(510) 526-7443, ext. 07
65 Franciscan Way
Kensington, CA 94707
