Message-ID: <F9102D41F595D311ACA7009027DE2C840527B4D7@c3po.heurikon.com>
From: "Johnson, Stephen" <stevebj@artesyncp.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: kmalloc vs pci_alloc_consistent
Date: Fri, 18 Jul 2003 09:56:35 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I found a nice thread of conversation that allowed me to see some of the
history behind pci_alloc_consistent().

I read one thing noted on a man page for kmalloc that should be highlighted.
"the GFP_DMA flag may be set to indicate the memory must be suitable for
DMA. ***This can mean different things on different platforms.*** For
example, on x86, it means that the memory must come from the first 16MB."

For ppc arch, how about
#define kmalloc  pci_alloc_unconsistent  /* just joking */




-----Original Message-----
From: Johnson, Stephen
Sent: Friday, July 18, 2003 8:34 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: kmalloc vs pci_alloc_consistent



I don't know the history behind pci_alloc and wanted to throw this out there
to get some clarification.

What's the benefit of pci_alloc over using kmalloc with flags for a
cache-safe buffer?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
