Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: mschmid@ascona.de
Subject: spurious interrupts
To: linuxppc-embedded@lists.linuxppc.org
Cc: 
Message-ID: <OF5EDCB1AF.1E3CDD66-ONC1256B3A.0057ED74@ascona.de>
Date: Mon, 7 Jan 2002 17:30:20 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all.

I started porting the linux kernel 2.2.12 on our MPC8240 based board (own
board design).
The MPC8240 EPIC is used as interrupt controller.
After external interrupts are enabled in start_kernel() the CPU loops
endless within the interrupt handler, because of spurious interrupts.
I reduced the initialization of OpenPic to a minimum to find the source
generating the spurious interrupts, but nothing changed.
I searched for this problem in the archiv of the mailing list but i did not
find any solution.
With kernel 2.4.2 i recognized the same problem so i think there is
something wrong within my port.

Have anyone had this probleme before ?

Mathias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
