Date: Mon, 16 Sep 2002 18:38:15 -0400
From: wahmad <wahmad@snowshore.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: problem with pci_alloc_consistent
Message-ID: <3D808EAA@webmail.snowshore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am using pci_alloc_consistent() for obtaining contiguous memory that is
cache safe. Here is how I am calling the routine

pci_alloc_consistent(NULL,size,&dummy).
Note I am throwing away the bus address.

The memory that I get does not seem to be cache safe. My device doesn't see
the data  untill I add flush_dcache_range(..). It is very undesirable for me
to add flushes and invalidates. I will appreciate any help in this matter.

I am using kernel version 2.4.20-pre5 for IBM PPC405GP and using version
2.95.3 for gcc on an x86 as a cross compiler.

I also have CONFIG_NOT_COHERENT_CACHE defined.

Thanks

Waqar


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
