MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Problems getting linux working on MPC8260ADS 
Date: Wed, 6 Aug 2003 08:24:30 +0200
Message-ID: <742AC4678EF8464697DDDFE3B40F6ECD06125B@srv-mailrnd.azisa.co.za>
From: "Wouter van Wyk" <Wouter.vanWyk@za.flextronics.com>
To: "linuxppc-embedded@lists.linuxppc.org" <'linuxppc-embedded@lists.linuxppc.org'>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All

I have a problem booting linux 2.4.20 on the MPC8260ADS board. The
kernel comes up without problems, but I can not seem to get sh or init
working properly.  As sh starts, I do not see any output on the console.
If I type something (like ls), it is echoed back to the console, but no
result comes back. I am using a NFS file system. If I do something like

echo "hallo" > file

the file is created on the NFS file system with the right entry.
However, after some time the system seems to stop responding.

If I run init, it get stuck somewhere while executing rc.sysinit (see
trace).

Any help will be appreciated.

Regards
Wouter van Wyk

Output of the boot process.
----------------------------------------

Memory BAT mapping: BAT2=16Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.20 (wvwyk@gladiator) (gcc version 2.95.4 20010319
(prerelease/
franzo/20011204)) #46 Tue Aug 5 14:33:12 SAST 2003
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw
nfsroot=10.189.3.17:/home/wvwyk/eldk/ppc_82xx/
ip=10.189.1.246:10.189.3.17
Warning: real time clock seems stuck!
Calibrating delay loop... 88.67 BogoMIPS
Memory: 14960k available (888k kernel code, 284k data, 48k init, 0k
highmem)
Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
CPM UART driver version 0.01
ttyS0 on SCC1 at 0x8000, BRG1
ttyS1 on SCC2 at 0x8100, BRG2
eth0: FCC ENET Version 0.3, 00:00:00:00:00:02
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
IP-Config: Guessing netmask 255.0.0.0
IP-Config: Complete:
      device=eth0, addr=10.189.1.246, mask=255.0.0.0,
gw=255.255.255.255,
     host=10.189.1.246, domain=, nis-domain=(none),
     bootserver=10.189.3.17, rootserver=10.189.3.17, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.189.3.17
Looking up port of RPC 100005/1 on 10.189.3.17
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 48k init



Output of init:
-------------------

INIT: version 2.78 booting
                Welcome to DENX Embedded Linux Environment
                Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access
method.
Setting clock : Wed Dec 31 19:00:05 EST 1969 [  OK  ]
Activating swap partitions:  [  OK  ]
Setting hostname 10.189.1.246:  [  OK  ]
modprobe: Can't open dependencies file /lib/modules/2.4.20/modules.dep
(No such file or directory)
Checking filesystems
[  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling swap space:  [  OK  ]


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
