Message-ID: <013101c3e03d$19623800$7101a8c0@JMANBY>
From: "John Manby" <jmanby@tnex.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: PCI resource conflicts
Date: Wed, 21 Jan 2004 10:39:11 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I looked into the archives and found where several others have asked this
question, but I couldn't find where anyone had received a sufficient
solution. I am running a Debian 2.4 kernel with RTAI extensions on an IBM
405GP PowerPC. Initially, U-boot was failing to locate PCI devices behind
bridges other than the first bridge it finds. I believe that this is not an
issue at this time and that the Linux kernel reconfigures the PCI bus on
boot up. Now when booting Linux, I receive these messages when I plug
multiple PCI cards into the chassis.

PCI: Probing PCI hardware
Scanning bus 00
Found 00:80 [1011/0024] 000604 01
Found 00:98 [1011/0024] 000604 01
Fixups for bus 00
Scanning behind PCI bridge 00:10.0, config 010100, pass 0
Scanning bus 01
Found 01:00 [8086/b555] 000b40 00
Fixups for bus 01
Bus scan for 01 returning with max=01
Scanning behind PCI bridge 00:13.0, config 020200, pass 0
Scanning bus 02
Found 02:00 [104c/a106] 000000 00
Fixups for bus 02
Bus scan for 02 returning with max=02
Scanning behind PCI bridge 00:10.0, config 010100, pass 1
Scanning behind PCI bridge 00:13.0, config 020200, pass 1
Bus scan for 00 returning with max=02
PCI: Cannot allocate resource region 2 of PCI bridge 1
PCI: bridge 1 resource 2 moved to bff00000..bfffffff
PCI: Cannot allocate resource region 1 of PCI bridge 2
PCI: bridge 2 resource 1 moved to bf000000..bfefffff
PCI: Cannot allocate resource region 2 of PCI bridge 2
PCI: bridge 2 resource 2 moved to bef00000..beffffff
PCI: Cannot allocate resource region 0 of device 01:00.0
PCI: Cannot allocate resource region 1 of device 01:00.0
PCI: Cannot allocate resource region 0 of device 02:00.0
PCI: Cannot allocate resource region 1 of device 02:00.0
PCI: Failed to allocate resource 0(0-fff) for 01:00.0
PCI: moved device 01:00.0 resource 1 (101) to f000
PCI: Failed to allocate resource 3(c0000000-bfffffff) for 01:00.0
PCI: Failed to allocate resource 4(0-7fffff) for 01:00.0


Can anybody explain what is causing this or point me in the right direction?
I'm currently trying to follow through the PCI code, but I am new to Linux
and a hierachical PCI design so it is slow going.

Thanks!!
-John


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
