From: ipv6@263.net
Message-ID: <008601becb11$9b48e1c0$57c809c0@nt4srv87>
Reply-To: <ipv6@263.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: whats wrong with ifconfig?
Date: Sun, 11 Jul 1999 04:20:02 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello,

my custom 860 board boot ok,
but in bash prompt
I got these:

init-2.00# /sbin/ifconfig eth0 192.9.200.81
192.9.200.81: Resolver Error 0 (no error)
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
init-2.00#

and these:

init-2.00# /sbin/ifconfig eth0
eth0      Link encap:10Mbps Ethernet  HWaddr 0A:0B:0C:0D:0E:0F
          unspec addr:[NONE SET]  Bcast:[NONE SET]  Mask:[NONE SET]
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0
          TX packets:0 errors:0 dropped:0 overruns:0
          Base address:0x3c00

init-2.00#

some thing wrong with my kernel?
or just shell command lines


Hope someone can help.

thank you

Regards.
john zhan.
hacking time.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
