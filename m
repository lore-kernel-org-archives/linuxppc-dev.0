Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <sb781c1a.090@mail.scires.com>
Date: Mon, 13 Aug 2001 18:27:28 -0400
From: "Doug Hubbard" <dhubbard@scires.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Downloading and Debugging linux / programs via BDM
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am fairly new to embedded Linux.

I am attempting to load Linux and the compiled program to an MBX board via the BDM port.  The host machine is an x86 running RH Linux 7.0 and I am using the tools provided with the RH EDK along with the BDM dongle and software from Macraigor Systems.

I have cross compiled a kernel and a test program that was successfully downloaded and run via the serial port; however, it is more desirable to run and debug programs from the BDM as our user interface uses the serial port.  The primary program will not require kernel debugging, but there are some device drivers that may need to be debugged.

What is the procedure for getting Linux downloaded to the board (via BDM) and started, then getting my program(s) downloaded and started and attaching the debugger (ddd/gdb) to the desired program?

The initial target is a Motorola MBX board with an MPC860 ppc processor,
the ultimate target is a custom board utilizing the same processor.

The system will be run out of FLASH ultimately, there is no hard disc, keyboard, or monitor.

TIA, Doug

Doug Hubbard
Software Engineer
Scientific Research Corporation
2300 Windy Ridge Parkway
Suite 400, South
Atlanta, GA 30339


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
