Message-ID: <000701c24a7d$4bb1b4e0$7301a8c0@zhongqx>
From: "zhongqx" <zhongqx@guoguang.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: eth1: transmit timed out
Date: Fri, 23 Aug 2002 16:15:49 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,everyone
      I want to use FEC on FADS(860T),but when booting linux,it can not config FEC ip address with dynamic ,it seems that FEC trasmit time out,like the following.Can anyone give me some advise?thank you very much!linux kernel is 2.4.18.


=>bootm 400000
## Booting image at 00400000 ...
   Image Name:   2.4.18
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    524690 Bytes = 512 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.18 (root@localhost.localdomain) (gcc version 2.95.3 20010111 (
prerelease/franzo/20010111)) #1 Fri Aug 23 11:02:49 CST 2002
On node 0 totalpages: 2048
zone(0): 2048 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ip=192.168.1.99:192.168.1.105::255.255.255.0 root=/dev/nfs
nfsroot=192.168.1.105:/linuxppc/eldk-bin/ppc_8xx rw
Decrementer Frequency = 180000000/60
Calibrating delay loop... 47.82 BogoMIPS
Memory: 6696k available (948k kernel code, 348k data, 52k init, 0k highmem)
Dentry-cache hash table entries: 1024 (order: 1, 8192 bytes)
Inode-cache hash table entries: 512 (order: 0, 4096 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
block: 64 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 2048K size 1024 blocksize
eth0: CPM ENET Version 0.2 on SCC1, 00:d0:93:00:12:34
fec.c[1371] mii_link_interrupt: unexpected Link interrupt
eth1: FEC ENET Version 0.2, FEC irq 3, MII irq 4, addr 00:d0:93:80:12:34
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 512)
Sending BOOTP and RARP requests ...... timed out!
FEC timeout on graceful transmit stop
IP-Config: Retrying forever (NFS root)...
Sending BOOTP and RARP requests ..<6>NETDEV WATCHDOG: eth1: transmit timed out
eth1: transmit timed out.
Ring data dump: cur_tx c01b4100 (full), dirty_tx c01b4100 cur_rx: c01b4000
 tx: 16 buffers
  c01b4100: 9c00 024e 001e2802
  c01b4108: 9c00 002a 0019d272
  c01b4110: 9c00 024e 001e2c02
  c01b4118: 9c00 002a 0019d2f2
  c01b4120: 9c00 024e 0019b002
  c01b4128: 9c00 002a 0019d372
  c01b4130: 9c00 024e 0019b402
  c01b4138: 9c00 002a 0019d3f2
  c01b4140: 9c00 024e 0019b802
  c01b4148: 9c00 002a 0019d472
  c01b4150: 9c00 024e 0019bc02
  c01b4158: 9c00 002a 0019d4f2
  c01b4160: 9c00 024e 0019a002
  c01b4168: 9c00 002a 0019d572
  c01b4170: 9c00 024e 0019a402
  c01b4178: bc00 002a 0019d5f2
 rx: 32 buffers
  c01b4000: 8000 ffff 001b3000
  c01b4008: 8000 ffff 001b3800
  c01b4010: 8000 ffff 001b2000
  c01b4018: 8000 fbff 001b2800
  c01b4020: 8000 ffff 001b1000
  c01b4028: 8000 ffff 001b1800
  c01b4030: 8000 feff 001b0000
  c01b4038: 8000 ffff 001b0800
  c01b4040: 8000 fbff 001af000
  c01b4048: 8000 ffff 001af800
  c01b4050: 8000 ffff 001ae000
  c01b4058: 8000 feff 001ae800
  c01b4060: 8000 ffff 001ad000
  c01b4068: 8000 ffff 001ad800
  c01b4070: 8000 ffff 001ac000
  c01b4078: 8000 ffff 001ac800
  c01b4080: 8000 ffff 001ab000
  c01b4088: 8000 ffff 001ab800
  c01b4090: 8000 ffff 001aa000
  c01b4098: 8000 ffff 001aa800
  c01b40a0: 8000 ffff 001a9000
  c01b40a8: 8000 ffff 001a9800
  c01b40b0: 8000 ffff 001a8000
  c01b40b8: 8000 ffff 001a8800
  c01b40c0: 8000 ffff 001a7000
  c01b40c8: 8000 ffff 001a7800
  c01b40d0: 8000 ffff 001a6000
  c01b40d8: 8000 ffff 001a6800
  c01b40e0: 8000 feff 001a5000
  c01b40e8: 8000 ffff 001a5800
  c01b40f0: 8000 ffff 001a4000
  c01b40f8: a000 ffff 001a4800
.<6>NETDEV WATCHDOG: eth1: transmit timed out
eth1: transmit timed out.
Ring data dump: cur_tx c01b4100 (full), dirty_tx c01b4100 cur_rx: c01b4000
 tx: 16 buffers
  c01b4100: 9c00 024e 001e2802
  c01b4108: 9c00 002a 0019d272
  c01b4110: 9c00 024e 001e2c02
  c01b4118: 9c00 002a 0019d2f2
  c01b4120: 9c00 024e 0019b002
  c01b4128: 9c00 002a 0019d372
  c01b4130: 9c00 024e 0019b402
  c01b4138: 9c00 002a 0019d3f2
  c01b4140: 9c00 024e 0019b802
  c01b4148: 9c00 002a 0019d472
  c01b4150: 9c00 024e 0019bc02
  c01b4158: 9c00 002a 0019d4f2
  c01b4160: 9c00 024e 0019a002
  c01b4168: 9c00 002a 0019d572
  c01b4170: 9c00 024e 0019a402
  c01b4178: bc00 002a 0019d5f2
 rx: 32 buffers
  c01b4000: 8000 ffff 001b3000
  c01b4008: 8000 ffff 001b3800
  c01b4010: 8000 ffff 001b2000
  c01b4018: 8000 fbff 001b2800
  c01b4020: 8000 ffff 001b1000
  c01b4028: 8000 ffff 001b1800
  c01b4030: 8000 feff 001b0000
  c01b4038: 8000 ffff 001b0800
  c01b4040: 8000 fbff 001af000
  c01b4048: 8000 ffff 001af800
  c01b4050: 8000 ffff 001ae000
  c01b4058: 8000 feff 001ae800
  c01b4060: 8000 ffff 001ad000
  c01b4068: 8000 ffff 001ad800
  c01b4070: 8000 ffff 001ac000
  c01b4078: 8000 ffff 001ac800
  c01b4080: 8000 ffff 001ab000
  c01b4088: 8000 ffff 001ab800
  c01b4090: 8000 ffff 001aa000
  c01b4098: 8000 ffff 001aa800
  c01b40a0: 8000 ffff 001a9000
  c01b40a8: 8000 ffff 001a9800
  c01b40b0: 8000 ffff 001a8000
  c01b40b8: 8000 ffff 001a8800
  c01b40c0: 8000 ffff 001a7000
  c01b40c8: 8000 ffff 001a7800
  c01b40d0: 8000 ffff 001a6000
  c01b40d8: 8000 ffff 001a6800
  c01b40e0: 8000 feff 001a5000
  c01b40e8: 8000 ffff 001a5800
  c01b40f0: 8000 ffff 001a4000
  c01b40f8: a000 ffff 001a4800
NETDEV WATCHDOG: eth1: transmit timed out
eth1: transmit timed out.
Ring data dump: cur_tx c01b4100 (full), dirty_tx c01b4100 cur_rx: c01b4000
 tx: 16 buffers
  c01b4100: 9c00 024e 001e2802
  c01b4108: 9c00 002a 0019d272
  c01b4110: 9c00 024e 001e2c02
  c01b4118: 9c00 002a 0019d2f2
  c01b4120: 9c00 024e 0019b002
  c01b4128: 9c00 002a 0019d372
  c01b4130: 9c00 024e 0019b402
  c01b4138: 9c00 002a 0019d3f2
  c01b4140: 9c00 024e 0019b802
  c01b4148: 9c00 002a 0019d472
  c01b4150: 9c00 024e 0019bc02
  c01b4158: 9c00 002a 0019d4f2
  c01b4160: 9c00 024e 0019a002
  c01b4168: 9c00 002a 0019d572
  c01b4170: 9c00 024e 0019a402
  c01b4178: bc00 002a 0019d5f2
 rx: 32 buffers
  c01b4000: 8000 ffff 001b3000
  c01b4008: 8000 ffff 001b3800

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
