Message-ID: <3904673C.2FF192C5@enib.fr>
Date: Mon, 24 Apr 2000 17:24:45 +0200
From: Valéry Raulet <Valery.Raulet@enib.fr>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Boot failed with new 2.3.99 kernel !
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hi,

I'm currently using the 2.2.15pre19 kernel but I wanted to test the
lastest 2.3 kernel (2.3.99pre6-5) because I need specific features in
it.  I've got a lot of trouble in booting, could someone explain ?

The system is a 604e Motorola motherboard with 512Mo RAM with PreP arch.
The system is working fine with 2.2 kernels but not with 2.3.99 kernels.

Residual-Data Located at: $1FF78000
loaded at:     00005400 0001A220
relocated to:  00800000 00814E20
board data at: 1FF78000 1FF7EA0C
relocated to:  0080E314 00814D20
zimage at:     00010400 000C124E
relocated to:  00815000 008C5E4E
avail ram:     00400000 00800000

Linux/PPC load: root=/dev/nfs nfsroot=192.168.20.2:/ANTARA/Systems/%s
ip=::::::bootp console=ttyS0,9600
Uncompressing Linux...done.
Now booting the kernel
PReP architecture
Total memory = 512MB; using 2048kB for hash table (at c0400000)
Linux version 2.3.99-pre6 (root@antara36) (gcc version 2.95.2 10
kmem_alloc: NULL ptr (name=unknown)
Boot arguments:
kmem_alloc: NULL ptr (name=unknown)
kmem_alloc: NULL ptr (name=unknown)
kmem_alloc: NULL ptr (name=unknown)
kmem_alloc: NULL ptr (name=unknown)
kmem_alloc: NULL ptr (name=unknown)
kmem_alloc: NULL ptr (name=unknown)
On node 0 totalpages: 131072
zone(0): 131072 pages.
zone(1): 0 pages.
zone(2): 0 pages.
time_init: decrementer frequency = 1000010880/60 (15MHz)
Calibrating delay loop... 209.31 BogoMIPS
Memory: 510304k available (1160k kernel code, 840k data, 164k init)
[c0000000,e]
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
NIP: C0184DA8 XER: 20000000 LR: C01850DC REGS: c0f05de0 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0f04000[1] 'swapper' Last syscall: -1
last math 00000000 last altivec 00000000
GPR00: 00000080 C0F05E90 C0F04000 000000E0 000000F8 00000000 FFFFFFFF
0000000E
GPR08: C0166B7C 00000080 00000150 C0166A24 00000002 00000000 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
GPR24: 00000000 00000000 40000000 00814D77 00814D20 00000000 80800860
80800840
Call backtrace:
00000000 C01850DC C017FA88 C0195868 C017E7A8 C00039FC C0008E30
Kernel panic: kernel access of bad area pc c0184da8 lr c01850dc address
0 tsk s1
Rebooting in 180 seconds..


--
Valéry RAULET

Ecole Nationale d'Ingénieurs de Brest
Parvis Blaise Pascal
Technopôle Brest-Iroise
29280 PLOUZANE
Site Web : http://www.enib.fr/~raulet


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
