Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C88CB3D.4752A3E1@imc-berlin.de>
Date: Fri, 08 Mar 2002 15:31:25 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: HHL setserial and MPC8xx SCC/SMC
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

i tried to use setserial (version 2.17, 27-Jan-2000) that comes with HHL
2.0 on my custom board (MPC855T).

The Linux kernel is Wolfgangs's linux-2.4.4-2002-02-14 from ftp.denx.de.
During boot up it tells me
...
CPM UART driver version 0.03
ttyS0 on SMC1 at 0x0280, BRG1
ttyS1 on SCC1 at 0x0000, BRG2
pty: 256 Unix98 ptys configured
...

When I call setserial I get

root@idif3:~# setserial -abv /dev/ttyS0
Cannot get serial info: Invalid argument
root@idif3:~# setserial -abv /dev/ttyS1
Cannot get serial info: Invalid argument
root@idif3:~#

Does anyone know which argument is considered invalid?
Is there no support for setserial and SCC/SMC in that kernel?

Thanks,

Steven

PS: Actually I was just looking for an easy way to test my serial
ports...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
