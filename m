Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3ACF73E8.24CAACE4@ixiacom.com>
Date: Sat, 07 Apr 2001 13:09:12 -0700
From: Bryan Rittmeyer <bryan@ixiacom.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: bootloader for deeply embedded 405CR
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello linuxppc-embedded,

I am attempting to boot Montavista's PPC405 Linux port on
a very minimal 405CR Rev C target: essentially, there's 64MB
of SDRAM and a minicom on UART0. I have a 405GP kernel
loading great on the Walnut board using the IBM serial
monitor and treeboot, but I'm unsure what I need to do
on the CR before I can begin successfully running Linux on it.
I am using an Abatron BDI2000 along with GDB to load code and
tweak registers on the target.

Right now, I am configuring the SDRAM controller and UART0,
but apparently that is not sufficient to fully boot Linux,
since I never get any output on the serial port except for
the 'a' debug printout I enabled in head_4xx.S

Does anyone have a minimal 405GP/CR bootloader that I
could use as an example? Or perhaps a FAQ on how to bring
up a deeply embedded 405 using the Abatron box?

Thanks,

Bryan Rittmeyer

--
Bryan Rittmeyer
mailto:bryan@ixiacom.com
Ixia Communications
26601 W. Agoura Rd.
Calabasas, CA 91302

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
