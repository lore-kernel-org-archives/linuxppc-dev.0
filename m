Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
To: linuxppc-embedded@lists.linuxppc.org
Date: Wed, 07 Jan 2004 06:42:29 -0500
From: "manisha gautam" <manishag@lycos.com>
Message-ID: <PCIKAHFJJHIFDFAA@mailcity.com>
Mime-Version: 1.0
Reply-To: manishag@lycos.com
Subject: PowerTAP on MPC8260
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I am using PowerTAP on MPC8260.
I am facing the problem of memory corruption when
a piece of code is run with memory translations enabled.
But that doesn't happen if the memory is not translated.
The following instructions are executed:

stwu r1, 0x20(r1)
mfpsr r0, DSISR
li r0, 0

After the the second instruction is executed, r1 gets
again decremented by 0x20. The contents of (r1)+0x20+0x20 are modified.
Kindly help me. Thanks in advance.

Manisha


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
