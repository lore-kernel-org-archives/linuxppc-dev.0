Message-ID: <3C0CD3C6.ECB0E61B@laposte.net>
Date: Tue, 04 Dec 2001 14:46:46 +0100
From: Phil <ibm405.linux@laposte.net>
MIME-Version: 1.0
To: Matt Porter <mporter@mvista.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Simon Winwood <sjw@cse.unsw.edu.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: More walnut boottime "fun"
References: <20011127103042.A11612@cse.unsw.edu.au> <20011126221728.D13091@cpe-24-221-152-185.az.sprintbbd.net> <20011127050754.B15728@cx258813-a.chnd1.az.home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'am trying to boot the latest linuxppc_2_4_devel kernel version
(2.4.27-pre2).
I got it with the rsync access from Montavista.
I build the kernel for my Walnut board using HHL2.0 toolchain
(ppc-405-xxx) and i try to load it
with the original bootloader (from ibm)
Nothing appened after "Now booting the kernel".
It seems it's a known problem.
Thanks.
-Phil

Here is my boot console:
--------------------------------
ENET Speed is 10
Mbs...
HALF duplex
connection
Booting from [ENET] Ethernet
...
Sending bootp request
...


Loading file "pvillet/kernel/vmlinuz-target"
...
Sending tftp boot request
...
Transfer Complete
...
Loaded successfully
...
Entry point at 0x500000
...

loaded at:     00500000
0058388C
relocated to:  00400000
0048388C
board data at: 004807BC
004807FC
relocated to:  0048077C
004807BC
zimage at:     00405400
0047FF59
avail ram:     00484000
02000000

Linux/PPC load: root=/dev/nfs rw
ip=auto
Uncompressing
Linux...done.
Now booting the kernel

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
