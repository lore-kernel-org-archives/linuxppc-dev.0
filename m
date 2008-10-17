Return-Path: <pbadari@us.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 459D3DE0E7
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 04:46:44 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id m9HHhaDN007853
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 13:43:36 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9HHkce9045028
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 13:46:39 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9HHkc4S026689
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 13:46:38 -0400
Subject: 2.6.27-git7 compile error (ppc)
From: Badari Pulavarty <pbadari@us.ibm.com>
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 17 Oct 2008 10:47:14 -0700
Message-Id: <1224265634.15582.3.camel@badari-desktop>
Mime-Version: 1.0
Cc: linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I get this following compile error on my ppc box.

Let me know if its a known issue. Otherwise, I can figure out
whats happening.

Thanks,
Badari

  CC      arch/powerpc/mm/slb.o
In file included from /usr/src/linux-2.6.27/arch/powerpc/include/asm/mmu-hash64.h:16,
                 from /usr/src/linux-2.6.27/arch/powerpc/include/asm/mmu.h:7,
                 from /usr/src/linux-2.6.27/arch/powerpc/include/asm/pgtable.h:7,
                 from arch/powerpc/mm/slb.c:19:
/usr/src/linux-2.6.27/arch/powerpc/include/asm/page.h:76: error: parse error before "memstart_addr"
/usr/src/linux-2.6.27/arch/powerpc/include/asm/page.h:76: warning: type defaults to `int' in declaration of `memstart_addr'
/usr/src/linux-2.6.27/arch/powerpc/include/asm/page.h:76: warning: data definition has no type or storage class
/usr/src/linux-2.6.27/arch/powerpc/include/asm/page.h:77: error: parse error before "kernstart_addr"
/usr/src/linux-2.6.27/arch/powerpc/include/asm/page.h:77: warning: type defaults to `int' in declaration of `kernstart_addr'
/usr/src/linux-2.6.27/arch/powerpc/include/asm/page.h:77: warning: data definition has no type or storage class
  AS      arch/powerpc/lib/string.o
  CC      arch/powerpc/lib/alloc.o
  CALL    arch/powerpc/kernel/systbl_chk.sh
  CC      arch/powerpc/kernel/sysfs.o
make[1]: *** [arch/powerpc/mm/slb.o] Error 1
make: *** [arch/powerpc/mm] Error 2
make: *** Waiting for unfinished jobs....
