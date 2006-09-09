Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s32.bay0.hotmail.com (bay0-omc3-s32.bay0.hotmail.com
	[65.54.246.232]) by ozlabs.org (Postfix) with ESMTP id B0C8667B9D
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 10 Sep 2006 01:05:32 +1000 (EST)
Message-ID: <BAY110-F23B67F808589990B24A5CDB2340@phx.gbl>
From: "Ming Liu" <eemingliu@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: asm/*.h files missing for ppc arch.
Date: Sat, 09 Sep 2006 15:05:27 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear all,
Now I am trying to compile a driver module for my linux 2.6.16 kernel in 
ML403 with CPU arch Powerpc 405. But when I include linux/module.h, and 
then in module.h it includes linux/sched.h, and then in sched.h it includes 
asm/param.h and asm/semaphore.h and asm/mmu.h......, the compiling errors 
of "no such file or directory" appear. I found that there are NOT such 
files in asm/ at all.(the asm/ is linked to asm-ppc/ for PPC405 arch) Where 
are they then? I think when compiling modules, we must include 
linux/module.h and then these asm/*.h files, right? Any implies are 
appreciated. Thanks a lot for your telling.

Regards
Ming

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
