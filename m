Date: Fri, 17 Dec 1999 13:42:42 -0600
From: Grant Erickson <grant@lcse.umn.edu>
To: linuxppc-dev@lists.linuxppc.org
cc: linuxppc-embedded@lists.linuxppc.org
Subject: RTNL Assertion Failures
Message-ID: <Pine.SGI.4.10.9912171333560.64420-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Has anyone else out there working with embedded boards and the 2.3.3x
kernels seen the following error message pertaining to an RTNL assertion
failure? I suspect it is NOT the cause of my Ethernet woes, but it looks
suspect just the same:

Linux version 2.3.32 (grant@brule) (gcc version 2.95.2 19991024 (release)) #56 Fri Dec 17 13:21:29 CST 1999
On node 0 totalpages: 00000400
zone(0): 1024 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Calibrating delay loop... 9.78 BogoMIPS
Memory: 2692k available (728k kernel code, 640k data, 36k init) [c0000000,c0400000]
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 1024 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (established 512 bind 1024)
Starting kswapd v1.6
loop: registered device at major 7
loop: enabling 8 loop devices
eth0: National DP83902AV at 08:00:5a:c8:02:b4, found at 0xf4000000, using IRQ 27.
RTNL: assertion failed at devinet.c(787):inetdev_event <--- ******
Sending BOOTP and RARP requests...
eth0: timeout waiting for Tx RDC, stat = 0x0 start address 0x2000, current address 0x2000, count 406
eth0: oaknet_reset_8390() didn't complete
Kernel stack overflow in process c0176000, r1=c01765c0
NIP: C0006A94 XER: 20000000 LR: C00042EC REGS: c0176510 TRAP: 0500
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0176000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: C0006A74 C01765C0 C0176000 00009030 00000000 00000000 00000006 000000D8
GPR08: C00DB418 C0144210 C00DE320 0000006C 84344322 43AA053F FFFEF168 00008068
GPR16: 0000004A FFFE2249 00000361 00000000 00001032 00176600 00000000 C0003778
GPR24: C0004380 00008035 C017B85C 0000001C 000000D8 C0176610 0000001B C0179220
Call backtrace:
00000000	???
C0004404	do_IRQ
C0003778	ret_from_syscall
00000000 	...
C0004404 C0003778 00000000 C0004404 C0003778 00000000 C0004404
C0003778 00000000 C0004404 C0003778 00000000 C0004404 C0003778
00000000 C0004404 C0003778 00000000 C0004404 C0003778 00000000
C0004404 C0003778 00000000 C0004404 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
