Message-ID: <00e201c2f53f$befd20c0$0700a8c0@pc005>
Reply-To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
From: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: 8260 System clock
Date: Fri, 28 Mar 2003 16:36:05 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi to All.

We are currently working with a custom board which uses an 8260 with 33MHz
external oscillator. We have applied the clocks programming that is almost
the slower we could, and correspond to 133/100/33 MHz. In this conditions
Linux and related applications run well.

We have tried to increment the CPU clock by changing the MODCLK1÷MODCLK3
configuration pins and in both 166/100/33 and 200/100/33 the system hangs
after the hash table programming.
The CPU is an HIP3 - B.3 (6K23 mask) revision and is marked with 200/166/66.

Does anybody has an idea about such behaviour ?

many thanks

Gianfranco


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
