Date: Wed, 13 Sep 2000 10:16:22 +0200
From: Erik Kunze <Erik.Kunze@philosys.de>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Access PCMCIA control registers
Message-ID: <20000913101622.J10108@philos.philosys.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm running Linux 2.2.13 on a MPC860L based PPC-board from TQ-Systems
(http://www.tqc.de/HTM_Files/TQM8xx_Serie.htm).

I must access the PCMCIA control space within the internal memorty map.
The values I read from are not valid according to the docs and it doesn't
recognise any write access.

I've put a trace in the m8xx_setup.c and it always shows the following
values (bits):

Sep  1 15:16:51 193 kernel: m8xx_pcmcia: PIPR  1111 1111 0000 0000 1111 1111 0000 00000
Sep  1 15:16:51 193 kernel: m8xx_pcmcia: PSCR  1111 1100 0111 0000 0000 0000 0100 00000
Sep  1 15:16:51 193 kernel: m8xx_pcmcia: PER   0000 0000 0000 0000 0001 1000 0000 00000
Sep  1 15:16:51 193 kernel: m8xx_pcmcia: PGCRA 0000 0000 0000 0000 0000 0000 0000 00000

How do I switch power on the PCMCIA-Slot.

Can you help please.

Thanx,
--
   Dipl.-Ing. Erik Kunze               Phone: +49 - 89 - 32 14 07 41
   PHILOSYS Software GmbH              Fax:   +49 - 89 - 32 14 07 12
   Edisonstr. 6                        Email: Erik.Kunze@philosys.de
   D-85716 Unterschleissheim           WWW:   www.philosys.de/~kunze

        PGP-Key: http://www.philosys.de/~kunze/public_key.txt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
