From: mschmid@ascona.de
Subject: nested interrupts with MPC8240 EPIC
To: linuxppc-embedded@lists.linuxppc.org
Cc: 
Message-ID: <OFEBA00801.C9541590-ONC1256A7F.00519BC0@ascona.de>
Date: Wed, 4 Jul 2001 19:31:35 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

I use a board with a MPC8240 cpu.
The board is designed to use the serial interrupt feature of the MPC8240
EPIC, for which i have added arch-specific functions.
Now i need to allow nested interrupts.
Is there anyone who has working code for using nested interrupts in serial
mode with the MPC8240 ?

Regards
Mathias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
