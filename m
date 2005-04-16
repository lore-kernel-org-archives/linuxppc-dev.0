Return-Path: <shawnxjin@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.195])
	by ozlabs.org (Postfix) with ESMTP id F33BA67A67
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Apr 2005 10:16:33 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id 40so391545rnz
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Apr 2005 17:16:32 -0700 (PDT)
Message-ID: <c3d0340b05041517167c0cfa5c@mail.gmail.com>
Date: Fri, 15 Apr 2005 17:16:32 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Question on fixup_bigphys_addr() in syslib/ibm44x_common.c
Reply-To: Shawn Jin <shawnxjin@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

When looking into ppc440 support, I'm confused on the functionality of
fixup_bigphys_addr() in syslib/ibm44x_common.c. It's called by
ioremap() in arch/ppc/mm/pgtable.c. The prototype is as follows.
     phys_addr_t fixup_bigphys_addr(phys_addr_t addr, phys_addr_t size)

Why do we need this fixup? ioremap() takes a physical address as an
argument and maps the physical address space to virtual address space
with the specified size. Since it's already a physical address, which
is 36-bit address in the case of 440, why do we need to fix up the
ERPN? I must be missing something here.

Thanks,
-Shawn.
