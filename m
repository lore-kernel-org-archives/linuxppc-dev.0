Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <001301c1fbed$0efb5da0$6801a8c0@guoguangacer>
From: "gao xiaoguo" <gaoxg@guoguang.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: tftp on ppcboot 1.1.5
Date: Wed, 15 May 2002 16:46:48 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I want to use tftp to download file into target machine,but always failed.
The tftp server on linux has already been setup and tested, I tftp a file successfully
by using other tftp client on windows.

Following is my environment and operation log, and I found the ip/udp datagram on network
really is 0.0.0.69->192.168.1.105,so nobody will answer to the tftp request. Why the
ip address of server is changed from 192.168.1.105 to 0.0.0.69 ? Are there something
I leave.

CPU:   XPC860xxZPnnD3 at 48 MHz: 4 kB I-Cache 4 kB D-Cache FEC present
Board: FADS with db MPC821, MPC860 / MPC860SAR / MPC860T rev ENG or PILOT
DRAM:  (4 MB SDRAM)  8 MB
FLASH:  2 MB

=>printenv

bootargs=
bootcmd=bootm 2800100
baudrate=115200
loads_echo=1
clocks_in_mhz=1
ethaddr=00:00:00:01:02:03
serverip=192.168.1.105
ipaddr=192.168.1.99
netmask=255.255.255.0

=>tftpt boot 100000 testfile

ARP broadcast 1

Retry count exceeded; starting again
ARP broadcast 1
TFTP from server 192.168.1.105; our IP address is 192.168.1.99
Filename 'testfile'.
Load address: 0x100000
Loading: *T T T T
Retry count exceeded; starting again

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
