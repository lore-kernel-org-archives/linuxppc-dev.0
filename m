From: clark@esteem.com
Message-Id: <1.5.4.32.20001006222031.006b6ab0@pop.esteem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 06 Oct 2000 15:20:31 -0700
To: Matthew Locke <mlocke@mvista.com>
Subject: Re: Re: Ethernet Trouble
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 10:18 AM 10/6/00 -0700, you wrote:
>clark@esteem.com wrote:
>> Sending BOOTP and RARP requests............. timed out!
>> IP-Config: Auto-configuration of network failed.
>> dev_close: bug eth0 still running
>> Looking up port of RPC 100003/2 on 100.100.100.14
>> RPC: sendmsg returned error 101
>> RPC: sendmsg returned error 101
>>
>
>looks like a config problem.  trying turning off RARP in the kernel.
>
>

        I found the problem, It was a hardware problem (the nasty analog
type). Sorry for the trouble . However now it does the following.


## Booting Linux kernel at 40020000 ...
   Image Name:   2.2.14 for EST192E
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    413162 Bytes = 403 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.2.14 (root@pokey.esteem.com) (gcc version 2.95.2 19991030 (2.9
5.3 prerelease/franzo)) #14 Thu Oct 5 13:24:22 PDT 2000
Boot arguments: root=/dev/nfs rw ip=100.100.100.21:100.100.100.11:100.100.100.
1:255.0.0.0:esteem192e.com:eth0 nfsroot=100.100.100.11:/home/brent/dk80211b/ro
otfs.nfs
time_init: decrementer frequency = 183750000/60
Calibrating delay loop... 48.03 BogoMIPS
Memory: 15120k available (748k kernel code, 476k data, 40k init) [c0000000,c10
00000]
Dentry hash table entries: 2048 (order 2, 16k)
Buffer cache hash table entries: 16384 (order 4, 64k)
Page cache hash table entries: 4096 (order 2, 16k)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 16384 bhash 16384)
Starting kswapd v 1.5
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
NET4: Ethernet Bridge 007 for NET4.0
early initialization of device brg0 is deferred
eth0: CPM ENET Version 0.2, 00:10:ec:00:1b:ba
PPP: version 2.3.7 (demand dialling)
TCP compression code copyright 1989 Regents of the University of California
PPP line discipline registered.
brg0: network interface for Ethernet Bridge 007/NET4.0
brg0: generated MAC address FE:FD:00:30:16:76
brg0: attached to bridge instance 0
Looking up port of RPC 100003/2 on 100.100.100.11
Looking up port of RPC 100005/1 on 100.100.100.11
VFS: Mounted root (NFS filesystem).
Freeing unused kernel memory: 40k init

It hangs here.

Do not pass go.
Do not collect $200.

It seems like it is not running init and/or loading inittab.

Whats up with this?????

Any and all help appreciated.

        Conn Clark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
