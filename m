Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: David Jander <david.jander@protonic.nl>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Memory map with "holes"...
Date: Tue, 12 Aug 2003 14:32:09 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200308121432.09782.david.jander@protonic.nl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

We are designing a board based on the MPC852T (MPC866 serivate), and
I want to make sure there is the possibility to mount different-size
SDRAM chips on it, so I just connect the two bank-select pins to some
higher address lines, leaving some out in between, in order to acomodate
for bigger chips in the future. The bottom line is that I will get the
memory map split up into 4 segments with vast holes between each segment
that are undefined. What do I need to keep in mind regarding linux
about this? I suppose it isn't an issue, but I want to be sure I don't
get any trouble later. Any experience with memory holes? I suppose the
boot-loader should tell the kernel about the memory-map, in a way just
like lilo on an x86 machine, am I right? Does this work the same way on
linux-ppc ?

Greetings,

--
David Jander
Protonic Holland.
tel.: +31 (0) 229 212928
fax.: +31 (0) 229 210930
Factorij 36 / 1628 AL Zwaag

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
