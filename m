Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15607.mail.cnb.yahoo.com (web15607.mail.cnb.yahoo.com
	[202.165.102.61]) by ozlabs.org (Postfix) with SMTP id 3993D2BDDE
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 20:35:09 +1000 (EST)
Message-ID: <20040921103503.54102.qmail@web15607.mail.cnb.yahoo.com>
Date: Tue, 21 Sep 2004 18:35:03 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
To: Pantelis Antoniou <panto@intracom.gr>
In-Reply-To: <414FC633.3090707@intracom.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Linux 2.6.x on 8xx status
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Pantelis Antoniou <panto@intracom.gr> wrote：
> Well it works OK until it gets to start init.
> 
> Then it crashes the way it is supposed to :).
> 
> Tom I think it's the problem we are talking about.
> 
> Song please try this...

Guess what? It WORKED!!! Just one more line make it.
Could you pls tell us the theory in it if not too
complicated? :-)

Well Done!

----------------------------------------------------

u-boot>run net_nfs
Using SCC ETHERNET device
TFTP from server 172.16.115.33; our IP address is
172.16.115.7
Filename 'uImage.rpx26scc2pa'.
Load address: 0x200000
Loading:
#################################################################
        
#################################################################
         ##############
done
Bytes transferred = 735596 (b396c hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.9-rc2
   Image Type:   PowerPC Linux Kernel Image (gzip
compressed)
   Data Size:    735532 Bytes = 718.3 kB
   Load Address: 00000000
   Entry Point:  00000000
   Uncompressing Kernel Image ... OK
Linux version 2.6.9-rc2 (root@shu.edu.net) (gcc
version 3.2.2 20030217 (Yellow Dog Linux 3.0
3.2.2-2a_1)) #1 Tue Sep 21 15:10:34 CST 2004
Built 1 zonelists
Kernel command line: root=/dev/nfs rw
nfsroot=172.16.115.33:/opt/eldk/ppc_8xx
ip=172.16.115.7:172.16.115.33:172.16.115.254:255.255.255.0::eth0:off
panic=1
PID hash table entries: 512 (order: 9, 8192 bytes)
Decrementer Frequency = 180000000/60
Dentry cache hash table entries: 16384 (order: 4,
65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768
bytes)
Memory: 63104k available (1292k kernel code, 292k
data, 72k init, 0k highmem)
Mount-cache hash table entries: 512 (order: 0, 4096
bytes)
NET: Registered protocol family 16
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xfa200a80 (irq = 20) is a CPM UART
ttyCPM1 at MMIO 0xfa200a00 (irq = 46) is a CPM UART
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
loop: loaded (max 8 devices)
eth0: CPM ENET Version 0.2 on SCC2, 00:10:ec:00:37:5b
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind
8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
IP-Config: Complete:
      device=eth0, addr=172.16.115.7,
mask=255.255.255.0, gw=172.16.115.254,
     host=172.16.115.7, domain=, nis-domain=(none),
     bootserver=172.16.115.33,
rootserver=172.16.115.33, rootpath=
Looking up port of RPC 100003/2 on 172.16.115.33
Looking up port of RPC 100005/1 on 172.16.115.33
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 72k init齆??: version
2.84 booting
                Welcome to DENX Embedded Linux
Environment
                Press 'I' to enter interactive
startup.
Building the cache [  OK  ]
Mounting proc filesystem:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our
search for an access method.
Setting clock : Wed Dec 31 19:44:24 EST 1969 [  OK  ]
Setting hostname 172.16.115.7:  [  OK  ]
modprobe: Can't open dependencies file
/lib/modules/2.6.9-rc2/modules.dep (No such file or
directory)
Activating swap partitions:  [  OK  ]
Checking filesystems
[  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling swap space:  [  OK  ]
modprobe: Can't open dependencies file
/lib/modules/2.6.9-rc2/modules.dep (No such file or
directory)
Entering non-interactive startup
Setting network parameters:  [  OK  ]
Bringing up loopback interface:  [  OK  ]
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Initializing random number generator:  [  OK  ]
Starting portmapper: [  OK  ]
Mounting NFS filesystems:  [  OK  ]
Mounting other filesystems:  [  OK  ]
Starting xinetd: [  OK  ]

172 login: root
bash-2.05b# cd /
bash-2.05b# ls
bin  boot  dev  etc  images  lib  mnt  proc  root 
sbin  tmp  usr  var
bash-2.05b# reboot
INIT: Switching to runlevel: 6
bash-2.05b#
INIT: Sending processes the TERM signal
Starting killall:  [  OK  ]
Sending all processes the TERM signal...
Sending all processes the KILL signal...
Syncing hardware clock to system time Cannot access
the Hardware Clock via any known method.
Use the --debug option to see the details of our
search for an access method.

mount: directory to mount not in host:dir format
Please stand by while rebooting the system...
Restarting syst

U-Boot 1.1.2 (Aug 31 2004 - 09:47:03)

CPU:   PPC823EZTnnB2 at 48 MHz: 16 kB I-Cache 8 kB
D-Cache
Board: RPXlite_DW
DRAM:  64 MB
FLASH: 16 MB
Hit any key to stop autoboot:  0
u-boot>

--------------------------------------------------

Best regards,

Sam

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
