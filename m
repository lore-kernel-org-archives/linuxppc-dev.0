Message-ID: <01C06555.A2E02D00@NB2>
From: torsten.rissel@t-online.de (Torsten Rissel)
To: "Linuxppc-Embedded (E-Mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: MVME 5100
Date: Wed, 13 Dec 2000 22:39:59 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Everybody !

I am trying to run Linux on an MVME5100 board. I am using PReP-style booting and
got the boot process and some of the kernel initialization running. But I am missing any
knowledge of other PowerPC boards or machines, so that it is relativly hard to find out
what exactly to change. So I have a question: The MVME5100 is missing all ISA stuff.
Is the IRQ mapping (first 16 for the 8259 and the other 16 for the MPIC) still valid ?

Also I run in a problem: the indirect mechanism for generating PCI config cycles is set
up correctly, but the board seems to hang when reading from the CONFIG_DATA address !!!???

I would more then appreciate any hints.

Torsten

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
