From: "Kwansuk Kim" <kskim@neowave.co.kr>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: network tools don't work
Date: Tue, 11 Jul 2000 20:47:56 +0900
Message-ID: <NEBBKFENMLEDKDHMEHPJIEOOCAAA.kskim@neowave.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


After getting bash prompt, I determined wheather network is working, but it doesn't.
It tells there is no protocol.

----------

init-2.00# ./ifconfig lo 127.0.0.1
127.0.0.1: Resolver Error 0 (no error)
Usage: ifconfig [-a] [-i] [-v] interface
                [inet address]
                [hw] [ax25 address]
                [metric NN] [mtu NN]
                [trailers] [-trailers]
                [arp] [-arp]
                [netmask aa.bb.cc.dd]
                [dstaddr aa.bb.cc.dd]
                [mem_start NN] [io_addr NN] [irq NN]
                [[-] broadcast [aa.bb.cc.dd]]
                [[-]pointopoint [aa.bb.cc.dd]]
                [up] [down] ...
init-2.00# ping 210.105.51.96
ping: unknown protocol icmp.
init-2.00#

----------

But I set configure file to support TCP/IP protocol.
It's startup message.

---------------

POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 32768 bhash 32768)
Starting kswapd v 1.5
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16450
ttyS01 at 0x02f8 (irq = 3) is a 16450
ttyS02 at 0x03e8 (irq = 4) is a 16450
CPM UART driver version 0.02

ttyS00 at 0x0380 is a SMC
ttyS01 at 0x0100 is a SCC
ttyS02 at 0x0200 is a SCC
pty: 256 Unix98 ptys configured

.....

Is something wrong?

I used ramdisk root file system, and ramdisk image was obtained from linuxppc.org. (about 4Meg, library version is 1.99)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
