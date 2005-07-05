Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15803.mail.cnb.yahoo.com (web15803.mail.cnb.yahoo.com
	[202.165.102.83]) by ozlabs.org (Postfix) with SMTP id AA49267C80
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Jul 2005 23:55:18 +1000 (EST)
Message-ID: <20050705135513.94638.qmail@web15803.mail.cnb.yahoo.com>
Date: Tue, 5 Jul 2005 21:55:13 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: 2.6.12-rc2 netconsole problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I tried netconsole on a 8241 board with RealTek 8110S 
Gb Ethernet.It seemed nice so far but still one step 
to make it. Did I miss sth or what?

Linux version 2.6.12-rc2 (root@sam.shu.org) (gcc
version 3.2.2 20030217 (Yellow Dog Linux 3.0
3.2.2-2a_1)) #3 Mon Jul 4 12:33:23 CST 2005
......
Kernel command line:
netconsole=@192.168.57.243/eth0,@192.168.57.200/ 
root=/dev/ram0 rw
ip=192.168.57.243:192.168.57.200:::TOPAZ:eth0:off 
panic=1
netconsole: local port 6665
netconsole: local IP 192.168.57.243
netconsole: interface eth0
netconsole: remote port 6666
netconsole: remote IP 192.168.57.200
netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
......
RAMDISK driver initialized: 16 RAM disks of 200000K 
size 1024 blocksize
eth0: RTL8169s/8110s Gigabit Ethernet driver 2.2 at 
0xfe00, 00:d0:b8:00:c3:52, IRQ 0
eth0: Auto-negotiation Enabled.
eth0: 100Mbps Full-duplex operation.
netconsole: device eth0 not up yet, forcing it
netconsole: carrier detect appears untrustworthy,
waiting 4 seconds
netconsole: network logging started
Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
......
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 4096 (order: 3,
32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384
bytes)
TCP: Hash tables configured (established 4096 bind
4096)
NET: Registered protocol family 1
NET: Registered protocol family 17
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
      device=eth0, addr=192.168.57.243,
mask=255.255.255.0, gw=255.255.255.255,
     host=192, domain=, nis-domain=(none),
     bootserver=192.168.57.200,
rootserver=192.168.57.200, rootpath=
RAMDISK: Compressed image found at block 0
EXT2-fs warning: mounting unchecked fs, running e2fsck
is recommended
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 120k init

OK, it just stoped before init process. Is there any
necessary to fix sth on RAMDISK like add netconsole
device node?

Thanks in advance,

Sam


	

	
		
___________________________________________________________ 
—≈ª¢√‚∑—G” œ‰£≠÷–π˙µ⁄“ªæ¯Œﬁ¿¨ª¯” º˛…ß»≈≥¨¥Û” œ‰
http://cn.mail.yahoo.com/?id=77071
