Message-ID: <20010215175433.8317.qmail@dag.newtech.fi>
To: linuxppc-embedded@lists.linuxppc.org
Subject: PCI confusion
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 15 Feb 2001 19:54:33 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I just got a 2.2.17 port working OK and started
with the 2.4.1 (from www.kernel.org).
I used the same BAT mapping and replaced my
old PCI mapping code with the one in arch/ppc/kernel/pci.c.

Now I am confused.....
The BAT maps PCI MEM space from 0xc0000000 to 0xe0000000 in
mm/init.c.
The PCI devices can bee seen fine when printing ie. the first one
in pci.c, after the fixup of the addresses. (with address 0xexxxxxxx).

But later when the driver tries to access the PCI devices memory space
the kernel oops:es with a memory access error (11).

What could I have overlooked?
What changed from 2.2.17 to 2.4.1 on the PCI side ?

BRGDS


--
Dag Nygren                               email: dag@newtech.fi
Oy NewTech Ab                            phone: +358 9 8024910
Trasktorpet 3                              fax: +358 9 8024916
02360 ESBO                                 GSM: 0400-426312
FINLAND


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
