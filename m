Date: Fri, 28 Mar 2003 12:19:30 +0100
From: Boris Bezlaj <boris@gajba.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.5.66 compile fails under ppc32
Message-ID: <20030328111930.GA2451@gajba.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

did anyone encounter this problem when compiling 2.5.66 under ppc32 ?

| include/linux/swapops.h: In function `pte_to_swp_entry':
| include/linux/swapops.h:54: warning: implicit declaration of function `pte_file'
| mm/fremap.c: In function `sys_remap_file_pages':
| mm/fremap.c:139: `PTE_FILE_MAX_BITS' undeclared (first use in this function)

PTE_FILE_MAX_BITS is not defined anywhere.. for ppc64 it's in:

include/asm-ppc64/pgtable.h:#define PTE_FILE_MAX_BITS   (BITS_PER_LONG - PTE_SHIFT)

but not for ppc arch.

Anyone else or is it just me?
--

  Boris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
