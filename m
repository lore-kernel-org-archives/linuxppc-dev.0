Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04e.nortel.com (zcars04e.nortel.com [47.129.242.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 878FCDE1A3
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 06:33:14 +1100 (EST)
Message-ID: <48F8E86B.702@nortel.com>
Date: Fri, 17 Oct 2008 13:32:59 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, Linux kernel <linux-kernel@vger.kernel.org>
Subject: build failure on powerpc with current -git
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current -git fails to build on 64-bit powerpc (failure log below) . 
  Initially I tried using my older toolchain, when I first saw the 
problem I built a new toolchain with crosstool (gcc 4.1.2 and binutils 
2.16.1) and tried again but got the same problem.

2.6.27 doesn't show this problem.

Any ideas what's going on and how I can fix it?

Thanks,

Chris


   LD      vmlinux.o
   MODPOST vmlinux.o
WARNING: modpost: Found 4 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'
   GEN     .version
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
/opt/crosstool/gcc-4.1.2-glibc-2.3.6/powerpc64-unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-ld: 
BFD 2.16.1 internal error, aborting at 
/home/cfriesen/crosstool-0.43/build/powerpc64-unknown-linux-gnu/gcc-4.1.2-glibc-2.3.6/binutils-2.16.1/bfd/elflink.c 
line 6419 in elf_link_output_extsym

/opt/crosstool/gcc-4.1.2-glibc-2.3.6/powerpc64-unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-ld: 
Please report this bug.

make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [sub-make] Error 2
