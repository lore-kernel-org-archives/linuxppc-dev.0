From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15854.51654.206530.977151@argo.ozlabs.ibm.com>
Date: Thu, 5 Dec 2002 14:36:38 +1100
To: linuxppc-embedded@lists.linuxppc.org
Subject: ISA dma on 4xx
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is anyone using a pc-style southbridge chip in a 4xx-based system?

I am thinking that the split that we currently have in linuxppc-2.5,
where asm/dma.h includes either ppc4xx_dma.h or ppc_isa_dma.h, is not
the best way to do things, because we might want to use the ISA dma
functions on a 4xx system.

Does anyone use the 4xx dma controller with some device that is
normally connected to an ISA bus?  That is, is there a need for the
4xx dma functions to provide the same interface as the ISA dma
functions?

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
