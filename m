Message-Id: <scbda4cd.072@mx.amx.com>
Date: Wed, 17 Apr 2002 16:37:23 -0500
From: "Chuck Partridge" <Chuck_Partridge@amx.com>
To: "<" <linuxppc-embedded@lists.linuxppc.org>
Subject: SB Interrupt problem (OT)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This may be off topic, but I am having problem with my custom 8245 board.  We migrated an x86 design to a MPC8245 and kept the ALI M1535 Southbridge.  the problem is that the 8259 interrupt controllers output always seems to be masked after a warm reset, but everything works fine from a cold boot.

When poking at the 8259 registers, they show that interrupts are ready but the INTR pin is never asserted to the  8245s EPIC, hence no interrupt.

After a cold boot, it will run fine until it resets.  Once it resets, there are no interrutps reported by the INTR line to the EPIC (but internal EPIC interrupts like the internal DUART work fine).

Any ideas?

Thanks for indulging me on the OT message but I'm stumped..

CHuck


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
