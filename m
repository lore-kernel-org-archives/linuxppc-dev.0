Message-ID: <000d01c0300d$c7228410$2cb0f8cb@LocalHost>
From: "Y.S.Kim" <emc0000@sgi21.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC860 Boot Problems..
Date: Sat, 7 Oct 2000 12:22:09 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="euc-kr"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I am using  Redhat Linux  with a custom XPC860 board.
I have a problem with my system going down after console setting.
The kernel starts and a message shown below is up, but the following step doesn't work.
I would appreciate your comment on this problem.



loaded at:       00400000 00800000
board data at: FF002008 FF002030
relocated to:   003F0100 003F0128
zimage at:      00410000 0044DEC5
initrd at:          00500000 00668000
avail ram:       00668000 00FFFFFF

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.13 (root@kimcs) (gcc version 2.95.2 19991030 (2.95.3 prerelease/franzo)) #704 Sat Oct 7 01:35:05 KST 2000
Boot arguments: root=/dev/ram
time_init: decrementer frequency = 180000000/60
 intfreq=  48000000
 Calibrating delay loop... 6.81 BogoMIPS
Memory: 14060k available (468k kernel code, 388k data, 24k init) [c0000000,c0fff000]
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
Starting kswapd v 1.5
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
