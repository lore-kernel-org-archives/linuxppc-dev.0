Subject: Curious high_memory difference between platforms
Date: Mon, 23 Jul 2001 19:19:24 -0700
Message-ID: <8A098FDFC6EED94B872CA2033711F86F033AA1@orion.ariodata.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
From: "David C. Chiu" <dchiu@ariodata.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We are currently developing a module to service DMA-able buffer for our
PPC 405GP custom board and are using Monta Vista's 2.4.2 Kernel. We are
"rolling" our own allocation by using mem=xyz boot arguments followed by
a module implementing scheme similar to allocator module by Rubini
(Linux Device Drivers, O'Reilly.)

As with the allocator module, our module ioremap() the high_memory
pointer and does a write-verify to determine if valid memory exists.
Under x86 the high_memory reflects the memory size specified by mem=xyz,
but under PPC high_memory always reflect the total physical memory
installed. Is this normal?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
