Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3E8875B4.B41693B7@tataelxsi.co.in>
Date: Mon, 31 Mar 2003 22:37:00 +0530
From: "Kamalesh B" <kamal@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem porting ppcboot on custom board
References: <37D0F88E70D96C428C19EEB865701A38016C25F2@buda902a.siemens.hu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello,

We have developed a custom board for network application. Its serial
communication port is SCC1 and has same design as ADS board (pins). Only
difference is custom board is running at cpu-266Mhz, cpm-166Mhz,
bus-66Mhz.

Problem:
Serial port is not printing any character on the hyperterminal. I used
CRO to see any activity on the transmit pin (TXD pin) but there is
nothing happening.

Control will enter the serial_init function called from cpu_init_f
function. So i checked my SCC1 parallel port pin configuration by
writing a piece of code which will dump the registers value to DPRAM
starting addresses. It is being set properly. Then i also checked the
processor configuation parameter. Everything is supposed to be OK with
exact core, cpm and bus frequency calculated.

Iam using BDI2000 emulator just to load the ppcboot code and see the
dump.

Can u please suggest possible place where something might have gone
wrong?

with rgds,
kamal


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
