Message-ID: <20021105175534.48038.qmail@web14506.mail.yahoo.com>
Date: Tue, 5 Nov 2002 09:55:34 -0800 (PST)
From: Robert Douglas <rdouglas15@yahoo.com>
Subject: TDM (E1) transport over ATM AAL1
To: linuxppc-embedded@lists.linuxppc.org
Cc: Philip.Lougher@zarlink.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am using a MPC850DSL @ 50Mhz. The UTOPIA interface
runs at 25Mhz but the ATM PHY transmits at (2048 + ATM
OH)k bits/sec.
We intend to use the AAL0 mode available in this model
of PowerPC.
Regarding how many interrupts/sec we excpect, I think
one interrupt per ATM cell would consume too much CPU,
but the delay would be smaller. I guess we'll only
know the exact number of interrupts after doing some
prototype testing.


PS.: the Zarlink chips would fit very well in this
application....if they had a SINGLE-CHANNEL part.

Robert.


----------  Forwarded Message  ----------

Subject: TDM (E1) transport over ATM AAL1
Date: Tue, 5 Nov 2002 15:10:05 +0000
From: Philip.Lougher@Zarlink.Com
To: linuxppc-embedded@lists.linuxppc.org

Um, it's rather difficult to say without knowing
*anything* about your
hardware.  Embedded PowerPC cores vary considerably in
performance between
models/make.  You also don't mention how many
interrupts you expect per
second - is there going to be an interrupt per ATM
cell?

Phillip


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
