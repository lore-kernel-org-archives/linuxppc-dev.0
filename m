Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain;
  charset="us-ascii"
From: Arun Dharankar <ADharankar@attbi.com>
Reply-To: ADharankar@attbi.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Relocating PPCBoot into SRAM
Date: Sun, 16 Feb 2003 12:54:35 -0500
MIME-Version: 1.0
Message-Id: <200302161254.35753.ADharankar@ATTBI.Com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings!

- On MPC75x and MPC7410 boards with MPC8260 in companion
  mode, SRAM on 1M and 2M respectively are available.

- Is it possible to relocate PPCBoot to this SRAM mapped
  as private memory? Note that, this is a second relocation;
  the first would already have occured when it is relocated
  from Flash to SDRAM.

- And if this possible, a re-relocation from SRAM back to
  SDRAM?


If this is possible, what needs to be done? The idea I
would like to explore is to do a full memory test (walking
bit, aligned/non-aligned access, refresh, alternating
pattern, random pattern test - basically extensive testing)
without executing PPCBoot in SDRAM.

And that these tests are part of PPCBoot commands (or
applications, perhaps).



Best regards,
-Arun.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
