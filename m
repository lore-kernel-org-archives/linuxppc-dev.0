Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <406B9D084FAFD4118C980008C79FADB901B57FF7@ALBMAIL>
From: "Yang, Bo" <bo.yang@transcore.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Kernel Debugging
Date: Mon, 14 Apr 2003 15:38:32 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Everyone,

I am trying to debug the linux kernel using remote GDB via serial port on
MPC8xxFADS board. I built the kernel (2.4.4 from denx) with "kernel
hacking-->Include kgdb kernel debugger" turned on. (I am not sure that
turning on this flag is enough to support kernel debugging).

I got a bunch of ????? marks on serial console once the kernel gets run from
"ppcboot", and then I start GDB with cmd "target remote /dev/ttyS0" on the
host. The GDB got messages like "Ignoring packet error, continuing..." and
then timeed out to close connection.

Who can tell me what I am missing? Is it possible to debug linux kernel
without any BDM/JTAG debugger?

Any useful feedbacks are appreciated.

Bo Yang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
