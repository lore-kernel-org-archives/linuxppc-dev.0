To: linuxppc-dev@lists.linuxppc.org
Subject: twi/isync/nop sequence in newer ppc linux kernels
From: Ronald Wahl <rwa@peppercon.com>
Date: Thu, 08 Jan 2004 17:39:25 +0100
Message-ID: <m37k02o0n6.fsf@gandalf.peppercon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm programming an embedded device (with PPC405GP/EP) that has to access the
pci bus and there may be cases that there is no one listening there and a
timeout occurs which results in a machine check. Until now I used a eieio
operation with an exception handler after the actual io operation and this
seems to work. Current kernels contain a twi/isync/nop sequence. What are
the reasons for this sequence instead of an eieio? Is it only needed on
some processors? Is there a document that describes this special
sequence in more detail?

Thanks in advance,
Ronald

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
