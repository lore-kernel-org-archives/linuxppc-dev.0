Message-ID: <B25E2E5A003CD311B61E00902778AF2A0148B611@server1.skystream.com>
From: Subodh Nijsure <SNijsure@SkyStream.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Connecting to powerpc target via wiggler.
Date: Sat, 9 Dec 2000 20:30:38 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anybody been successful in connecting to the powerpc board
using the BDM wiggler from MACRAIGOR system?

I have gdb-5.0 which I have compiled with OCD and BDM4GDB targets.

I am unable to connect to the ocd using command like

	target ocd wiggler /dev/parport0

I have also tried building the BDM4GDB and connecting using
that target, without any luck.


/Subodh Nijsure


./powerpc-linux-gdb -x MPCBDM/mpc.init /root/ppcboot/ppcboot
GNU gdb 5.0
Copyright 2000 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "--host=i686-pc-linux-gnu
--target=powerpc-linux"...
(no debugging symbols found)...
MPCBDM version 1.2 / 2000.11.05
got access rights for printer port 0x378..0x37A
disabled power at port
Port status: DATA=0x00 STAT=0x47 CTRL=0xC0
Port active lines: 'VDD1 '
unknown STAT
------------------>>>>> I turned on the power here for the board.
Port status: DATA=0x00 STAT=0x17 CTRL=0xC0
Port active lines: 'VDD2 '
found adapter version 1 at port, powered from mpc, turn on power at target
adapter version 1 initialized
please turn on power at target

^C
Couldn't establish connection to remote target
Quit
MPCBDM/mpc.init:264: Error in sourced command file:
Failed to connect to target 'mpcbdm'
(gdb) help target
Connect to a target machine or process.
The first argument is the type or protocol of the target machine.
Remaining arguments are interpreted by the target protocol.  For more
information on the arguments for a particular protocol, type
`help target ' followed by the protocol name.

List of target subcommands:

target async -- Use a remote computer via a serial line
target cisco -- Use a remote machine via TCP
target exec -- Use an executable file as a target
target extended-async -- Use a remote computer via a serial line
target extended-remote -- Use a remote computer via a serial line
target mpcbdm -- Use On-Chip Debugging on MPC's via parallel port BDM
interface
target ocd -- Use a remote target with On-Chip Debugging
target remote -- Use a remote computer via a serial line


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
