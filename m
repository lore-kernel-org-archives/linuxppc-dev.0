Subject: Using the Linux kgdb-kernel with the Walnut.
To: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <OF89113F6E.86CEDB29-ON87256D17.00567A5E-86256D51.00767452@us.ibm.com>
From: Andrew H Pham <apham@us.ibm.com>
Date: Thu, 26 Jun 2003 16:32:03 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am trying to boot up the Linux kgdb-kernel.2.4.18 on a Walnut board, but
it just freezes after it uncompressed the kernel.  Here is a screen shot:
"..
EMAC0 Ethernet Test OK.
ENET Speed is 100 Mbs...
FULL duplex connection
Booting from [ENET] Ethernet     ...
Sending bootp request ...


Loading file "//zImage" ...
Sending tftp boot request ...
Transfer Complete ...
Loaded successfully ...
Entry point at 0x500000 ...

loaded at:     00500000 005A9238
relocated to:  00400000 004A9238
board data at: 004A6168 004A61A8
relocated to:  004A6128 004A6168
zimage at:     004059DC 004A54DA
avail ram:     004AA000 02000000

Linux/PPC load: root=/dev/nfs
              ip=192.003.1.5:192.003.1.1::255.255.255.0:walnut:eth0:off
              nfsroot=192.168.1.1:/home/nfs/walnut
Uncompressing Linux...done.
Now booting the kernel
..."

And it just hangs.  I think this when it's waiting for input from the
              serial port 2 from the debugger then proceeds.  I hooked up
              an other session
of minicom to the second serial port on the Walnut, but only see garbages,
              "$S04#b7,..." .  I tried all the baudrates available and got
              different outputs or blank, all of which are
incomprehensible.

Has anyone got the Linux kgdb-kernel.2.4.18 to work with the Walnut board?

Any help would be appreciated,
Andy

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
