From: deepesh@india.tejasnetworks.com
Date: Thu, 15 May 2003 11:12:55 +0530 (IST)
To: linuxppc-embedded@lists.linuxppc.org
Subject: Memory used by kernel (fwd)
Message-ID: <Pine.LNX.4.21.0305151101360.12087-100000@deepesh.india.tejasnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

  I am working on a card with the MPC860T processor. We have our DIAG
terminal on SMC1 of the processor.


 Set Up: The DIAG port of the card is connected to the serial port of a
computer. And we run "minicom" to interact with the DIAG port of the card.


 Problem: Extended ascii characters come on the screen(minicom). This
problem is seen when the minicom setting for the terminal is
"VT102". There is no problem with the terminal settings as "ANSI".


 The above problem was seen only in one card. All other cards seem to work
well with both "ANSI" and "VT102". So there is definitely some problem
with the H/W. To debug this I have to know the difference between the two
terminal settings "ANSI and VT102".


 Please give me the basic differences between the two terminal settings.



Deepesh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
