Message-ID: <373CB7DA.F76ABA46@sei.co.kr>
Date: Sat, 15 May 1999 08:55:07 +0900
From: "KiPyo Ryu" <kpryu@sei.co.kr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: MBX (MPC860) Question
Content-Type: text/plain; charset=EUC-KR
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I am useing the MPC860 MBX Board (have only 4MB on-board memory) with
FDD and IBM 4GB HDD (2.5").

I will work 'mbxroot.full.tgz' file at
'ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded'.

I plan to boot from NFS after compile at PowerPC 603 machine.

I have some question following:

(1) Can I boot from floppy of the MBX system?
if, yes. what is the method?

(2) I would like to know configuration for network booting, and
after network booting, can I install linux to the HDD of MBX system?
if, yes. what is the method?

(3) Can I use the MBX system for self-hosted development system?

(4) I compiled linux 2.2.6 for MBX system at PowerPC 603, then I tried
to
network booting, but didn't booting. what is the problem.

following is the console display message.

==================================================================
EPPC-Bug>pl 20 0
Network Booting from: MPC860, Controller 20, Device 0
Loading: /sys/mbxroot/zImage

Client IP Address      = 210.96.178.73
Server IP Address      = 210.96.178.72
Gateway IP Address     = 0.0.0.0
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = /sys/mbxroot/zImage
Argument File Name     =

Bytes Received =&512723, Bytes Loaded =&512723
Bytes/Second   =&256361, Elapsed Time =2 Second(s)
loaded at:     00210000 0030E42C
relocated to:  00100000 001FE42C
board data at: 003F4558 003F4580
relocated to:  00200100 00200128
zimage at:     00216000 0027BCB3
avail ram:     0030E42C 00400000

Linux/PPC load: root=/dev/nfs nfsaddrs=210.96.178.73:210.96.178.72
nfsroot=210.9
6.178.72:/sys/mbxroot
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.5 (root@linuxppc.sei.co.kr) (gcc version egcs-2.90.25
980302 (
egcs-1.0.2 prerelease)) #1 Wed Apr 28 19:18:22 KST 1999
Boot arguments: root=/dev/nfs nfsaddrs=210.96.178.73:210.96.178.72
nfsroot=210.9
6.178.72:/sys/mbxroot root=/dev/nfs nfsroot=/sys/mbxroot
time_init: decrementer frequency = 150000000/60
Calibrating delay loop... 39.63 BogoMIPS
Memory: 2968k available (748k kernel code, 336k data, 44k init)
[c0000000,c04000
00]
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
Starting kswapd v 1.5
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
ttyS02 at 0x0100 is a SCC
ttyS03 at 0x0200 is a SCC
W82C105: IDE controller on PCI bus 00 dev 19
W82C105: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000020-0x1000027, BIOS settings: hda:pio, hdb:pio

SL82C105 command word: 5
IDE timing: 00000909, resetting to PIO0 timing
    ide1: BM-DMA at 0x1000028-0x100002f, BIOS settings: hdc:pio, hdd:pio

SL82C105 command word: 5
IDE timing: 000003e4, resetting to PIO0 timing
hda: IBM-DKLA-24320, ATA DISK drive
hda: IRQ probe failed (0)
hdb: IRQ probe failed (0)
hdb: IRQ probe failed (0)
hdf: no response (status = 0xff), resetting drive
hdf: no response (status = 0xff)
hdg: probing with STATUS(0xc1) instead of ALTSTATUS(0xff)
hdg: probing with STATUS(0xc1) instead of ALTSTATUS(0xff)
hdg: no response (status = 0xa1), resetting drive
hdg: probing with STATUS(0xc1) instead of ALTSTATUS(0xff)
hdg: no response (status = 0xa1)
hdh: probing with STATUS(0xc1) instead of ALTSTATUS(0xff)
hdh: probing with STATUS(0xc1) instead of ALTSTATUS(0xff)
hdh: no response (status = 0xa1), resetting drive
hdh: probing with STATUS(0xc1) instead of ALTSTATUS(0xff)
hdh: no response (status = 0xa1)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: IBM-DKLA-24320, 4126MB w/460kB Cache, CHS=8944/15/63, (U)DMA
NIP: C00EB4B4 XER: 20000000 LR: C00EB4A0 REGS: c011dd90 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c011c000[1] 'swapper' mm->pgd c00cf000 Last syscall: 120
last math 00000000
GPR00: 00028004 C011DE80 C011C000 C00DE7B4 FFFFFFFF 00000002 C00DE819
C005FF30
GPR08: C00B8E4C C00B8E9C C005FD94 C005FC88 C011DE40 00000000 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 003F4558 FA200A20
00000000
GPR24: 00000000 C03DF6E0 02200000 FA2009C0 00200000 00000000 C00E0000
C00E0000
Call backtrace:
C00EB4A0 C00EB448 C00E5724 C00E7B40 C00E2794 C00028E0 C0006A50
Instruction DUMP: 3f400220  54000732  901b0060 <a01a0952> 7c781b78
60000003  b0
1a0952  a01a0950  38600040
Kernel panic: kernel access of bad area pc c00eb4b4 lr c00eb4a0 address
2200952
tsk swapper/1
Rebooting in 180 seconds..
=======================================================================

Thanks.







[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
