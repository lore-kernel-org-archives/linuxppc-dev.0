From: "Mouloud Ameni " <mameni@caramail.com>
To: wd@denx.de
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <1092047877004966@lycos-europe.com>
Mime-Version: 1.0
Subject: kernel panics
Date: Mon, 09 Aug 2004 10:37:57 GMT 
Content-Type: multipart/mixed; boundary="=_NextPart_Lycos_0049661092047877_ID"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--=_NextPart_Lycos_0049661092047877_ID
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit

hi,
thanx very much for your help. After long working hours, i succeeded in loading the kernel "2.4.18" to an
sbc8260. i have tried mounting the filesystem following karim's boot. i have written a boot script (p270  & P275)
but for some reasons the kernel  hangs after "Starting kswapd". this is what i get.

Hit any key to stop autoboot:  0
## Booting image at 00400000 ...
   Image Name:   Linux 2.4.18 09/08/04
   Created:      2004-08-09   9:11:37 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    490664 Bytes = 479.2 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory BAT mapping: BAT2=16Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.18 (ltss001@linux) (gcc version 2.95.3 20010315 (release)) #1
Fri Aug 6 12:25:32 BST 2004
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw nfsroot=192.168.0.1:/home/mnml001/EmbLinux
/rootfs ip=192.168.0.2:192.168.0.1:::::off panic=1 init=/dev/nfs/bin/sh
Warning: real time clock seems stuck!
Calibrating delay loop... 6.91 BogoMIPS
Memory: 14792k available (916k kernel code, 340k data, 52k init, 0k highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
CPM UART driver version 0.01_

and then hangs. Any suggestions please.
thanx in advance

Plus simple, plus fiable, plus rapide : découvrez le nouveau Caramail - http://www.caramail.lycos.fr


--=_NextPart_Lycos_0049661092047877_ID--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
