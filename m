Message-ID: <64AFC0D37B2ED411BAB300508B6D90A019AB09@mail.virtual-ink.com>
From: Dan Winkler <dwinkler@virtual-ink.com>
To: "'linuxppc-embedded@lists.linuxppc.org '"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: driver memory management
Date: Sat, 6 Jan 2001 11:24:57 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am having some difficulties allocating memory larger than the memory
available in cpm_host_alloc, cpm_host_alloc seems to use part of a
predesignated 4K buffer of memory.  I need more memory than this, and am
trying to use the calls

pBuff = kmalloc(TRANSMIT_SIZE, GFP_KERNEL|GFP_DMA);

the only problem with this is when I go to copy data to this location it
fails i.e.

memcpy(__va(pBuff), pSrc, size)

Any Suggestions as to what might be going on.  From my undertaning this
should return a contiguous block of memory.

-Dan Winkler

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
