Message-ID: <3AE4872E.23982DD0@allot.com>
Date: Mon, 23 Apr 2001 22:49:02 +0300
From: Felix Radensky <felix@allot.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Compilation failures 
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm trying to compile a 2.4.3 kernel for 405GP using cross compiler from
Hard Hat
Linux 1.2. I've enabled 4xx as Processor type and Walnut as machine
type.

The compilation fails on main.c with the following errors:

In file included from
/home/felix/src/kernel/linux-2.4.3/include/linux/raid/md.h:38,
                 from init/main.c:24:
/home/felix/src/kernel/linux-2.4.3/include/asm/io.h: In function
`virt_to_bus':
/home/felix/src/kernel/linux-2.4.3/include/asm/io.h:207:
`PCI_DRAM_OFFSET' undeclared (first use in this function)
/home/felix/src/kernel/linux-2.4.3/include/asm/io.h:207: (Each
undeclared identifier is reported only once
/home/felix/src/kernel/linux-2.4.3/include/asm/io.h:207: for each
function it appears in.)
/home/felix/src/kernel/linux-2.4.3/include/asm/io.h:211: warning:
control reaches end of non-void function
/home/felix/src/kernel/linux-2.4.3/include/asm/io.h: In function
`bus_to_virt':
/home/felix/src/kernel/linux-2.4.3/include/asm/io.h:218:
`PCI_DRAM_OFFSET' undeclared (first use in this function)
/home/felix/src/kernel/linux-2.4.3/include/asm/io.h:222: warning:
control reaches end of non-void function
In file included from
/home/felix/src/kernel/linux-2.4.3/include/linux/bootmem.h:8,
                 from init/main.c:29:
/home/felix/src/kernel/linux-2.4.3/include/asm/dma.h: In function
`enable_dma':
/home/felix/src/kernel/linux-2.4.3/include/asm/dma.h:208: `_IO_BASE'
undeclared (first use in this function)
/home/felix/src/kernel/linux-2.4.3/include/asm/dma.h: In function
`disable_dma':
/home/felix/src/kernel/linux-2.4.3/include/asm/dma.h:224: `_IO_BASE'
undeclared (first use in this function)
/home/felix/src/kernel/linux-2.4.3/include/asm/dma.h: In function
`clear_dma_ff':
/home/felix/src/kernel/linux-2.4.3/include/asm/dma.h:239: `_IO_BASE'
undeclared (first use in this function)
/home/felix/src/kernel/linux-2.4.3/include/asm/dma.h: In function
`set_dma_mode':
/home/felix/src/kernel/linux-2.4.3/include/asm/dma.h:248: `_IO_BASE'
undeclared (first use in this function)
/home/felix/src/kernel/linux-2.4.3/include/asm/dma.h: In function
`set_dma_page':
/home/felix/src/kernel/linux-2.4.3/include/asm/dma.h:262: `_IO_BASE'
undeclared (first use in this function)
/home/felix/src/kernel/linux-2.4.3/include/asm/dma.h: In function
`set_dma_addr':
/home/felix/src/kernel/linux-2.4.3/include/asm/dma.h:308: `_IO_BASE'
undeclared (first use in this function)
/home/felix/src/kernel/linux-2.4.3/include/asm/dma.h: In function
`set_dma_count':
/home/felix/src/kernel/linux-2.4.3/include/asm/dma.h:336: `_IO_BASE'
undeclared (first use in this function)
/home/felix/src/kernel/linux-2.4.3/include/asm/dma.h: In function
`get_dma_residue':
/home/felix/src/kernel/linux-2.4.3/include/asm/dma.h:366: `_IO_BASE'
undeclared (first use in this function)

The same happens with 2.4.4-pre4 with latest patches from Cort Dougan.

What am I doing wrong ?

Thank you very much in advance.

Felix.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
