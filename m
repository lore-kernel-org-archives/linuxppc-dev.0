Content-Type: text/plain;
  charset="us-ascii"
From: Brian Waite <waite@skycomputers.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Booting a Walnut board
Date: Mon, 9 Sep 2002 11:05:52 -0400
MIME-Version: 1.0
Message-Id: <200209091105.52853.waite@skycomputers.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
	I am having some strage booting issues with my Walnut board. Enerything looks
good until I try to NFS mount my root filesystem. It looks like it starts but
then reports nfsserver not responding and eventaully reports "cannot get a
request slot". On the NFS root server I see some ver strange messages in my
dmesg cosole such as:
NET: 1 messages suppressed.
UDP: short packet: 192.9.200.214:800 388/260 to 192.9.200.220:2049
UDP: short packet: 192.9.200.214:800 388/260 to 192.9.200.220:2049
UDP: short packet: 192.9.200.214:800 388/260 to 192.9.200.220:2049
UDP: short packet: 192.9.200.214:800 388/260 to 192.9.200.220:2049
UDP: short packet: 192.9.200.214:800 388/260 to 192.9.200.220:2049
UDP: short packet: 192.9.200.214:800 388/260 to 192.9.200.220:2049
UDP: short packet: 192.9.200.214:800 388/260 to 192.9.200.220:2049
UDP: short packet: 192.9.200.214:800 388/260 to 192.9.200.220:2049
UDP: short packet: 192.9.200.214:800 388/260 to 192.9.200.220:2049
UDP: short packet: 192.9.200.214:800 128/124 to 192.9.200.220:2049
UDP: short packet: 192.9.200.214:800 128/124 to 192.9.200.220:2049
UDP: short packet: 192.9.200.214:800 128/124 to 192.9.200.220:2049
UDP: short packet: 192.9.200.214:800 128/124 to 192.9.200.220:2049
UDP: short packet: 192.9.200.214:800 128/124 to 192.9.200.220:2049
UDP: short packet: 192.9.200.214:800 128/124 to 192.9.200.220:2049
UDP: short packet: 192.9.200.214:800 132/128 to 192.9.200.220:2049

Has anyone ever seen this behaviour before. I am running MVista Linux kernel
version 2.4.17 and PPC Boot 1.1.6. I have treid 3 differnet NFS utsil
versions and 2 different (but both correctly set up) NFS root servers. I have
also tried running the ethernet at 100 full duplex and 10 half duplex. Can
anyone give me any ideas of where to look. Is this a 405 Enet issue maybe?

Thanks
Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
