Date: Fri, 19 Jan 2001 10:15:11 -0500
Message-Id: <200101191515.KAA04626@hermes.usherb.ca>
From: Francois Tremblay <francois.tremblay@ieee.org>
To: linuxppc-embedded@lists.linuxppc.org
Reply-To: Francois Tremblay <francois.tremblay@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Kernel on MPC850FADS
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I try to put the linux kernel 2.2-18 on a MPC850FADS of Motorola.
In arch/ppc/mbxboot/head.S file, there a ILAP_ADDRESS that is used to
decompress the kernel at boot.

The ILAP_ADDRESS refer to NVRAM of MBX and is not exist on a FADS board.

Someone know to fix this problem?

Thanks in advance,

Francois Tremblay
francois.tremblay@ieee.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
