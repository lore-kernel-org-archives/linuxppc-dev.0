Return-Path: <palazzinaro@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.196])
	by ozlabs.org (Postfix) with ESMTP id 9F03167B1D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 23:58:18 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 55so435426wri
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 06:58:16 -0700 (PDT)
Message-ID: <74499824050616065835741324@mail.gmail.com>
Date: Thu, 16 Jun 2005 15:58:16 +0200
From: eagle keeper <palazzinaro@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [newbie]: mpc8260 kernel opps sig 7 and 11 please help!
Reply-To: eagle keeper <palazzinaro@gmail.com>
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
since i'm hanged with this problem since 2 weeks ago... and i can't
solve it, i wonder if anyone
of you have any idea to suggest me.
I'm working on an mpc8260 and used ELDK to develop u-boot and kernel.
Actually I'm using ads8260_defoconfig configuration file to make the
kernel image.
I am absolutely a newbie and don't know where to start from. Any hael
would be appreciated.
This is the output I have:

--------------

## Booting image at 00100000 ...
  Image Name:   mercurio ---  10001  -  Thu Jun
  Image Type:   PowerPC Linux Kernel Image (gzip compressed)
  Data Size:    490783 Bytes =3D 479.3 kB
  Load Address: 00200000
  Entry Point:  00200000
  Verifying Checksum ... OK
  Uncompressing Kernel Image ... OK
Memory BAT mapping: BAT2=3D16Mb, BAT3=3D0Mb, residual: 0Mb
Linux version 2.4.25 (root@mercurio) (gcc version 3.3.3 (DENX ELDK 3.1.1 3.=
3.3-9
)) #2 Thu Jun 16 11:49:57 CEST 2005
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=3D/dev/nfs rw nfsroot=3D141.137.67.254:/provaFS i=
p=3D141.137
.67.253:141.137.67.254:141.137.67.100:255.255.255.0:priscilla::off
Warning: real time clock seems stuck!
Calibrating delay loop... 79.87 BogoMIPS
Memory: 15012k available (848k kernel code, 280k data, 40k init, 0k highmem=
)
Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
CPM UART driver version 0.01
ttyS0 on SCC1 at 0x8000, BRG7
ttyS1 on SCC2 at 0x8100, BRG1
Serial driver version 5.05c (2001-07-08) with no serial options enabled
Oops: kernel access of bad area, sig: 11
NIP: C007150C XER: 00000000 LR: C0075CAC SP: C0173E90 REGS: c0173de0 TRAP: =
0300
  Not tainted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 000003F9, DSISR: 20000000
TASK =3D c0172000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000000 C0173E90 C0172000 C0173EA0 00000001 00000008 C00D622C 00000=
3F8
GPR08: 00000000 000003F8 00000000 10000000 0000000D 7FFFFFFF 00FF5000 007FF=
F7D
GPR16: 00200000 007FFF00 00FF8A30 00000000 003FF000 00000001 00BC3588 00FFF=
25C
GPR24: 00000000 00123238 C0100000 C0173EA0 00000001 C01137C4 00000000 C00EF=
414
Call backtrace:
00123238 C00FD5F8 C00F75CC C00039D0 C0007FD8
Kernel panic: Attempted to kill init!
<0>Rebooting in 180 seconds..Machine check in kernel mode.
sCaubed fy ( rom1SRR0=3D41:00)

-------------

did you ever verified somewhat like this?
Specially about "sig 11" what is caused by?

Since I believed it was caused by serial driver, when I tried to
disable it I got a very similar error:

Initializing RT netlink socket
...
Machine check in kernel mode.
Caused by (from SRR1=3D49030): Transfer error ack signal
Oops: machine check, sig: 7
...

Thanks in advance, and sorry for wasting your time

Lele
