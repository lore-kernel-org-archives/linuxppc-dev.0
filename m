Message-ID: <393BF78C.1D3F10E1@grn.georet.net>
Date: Mon, 05 Jun 2000 14:55:07 -0400
From: Ryan Boder <rboder@grn.georet.net>
Reply-To: rboder@grn.georet.net
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: linux-pmac-stable
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am having trouble with the linux-pmac-stable source. I have a G4 AGP
400MHZ. The problem is that for every kernel I compile, it begins
booting but halfway through the process it freezes up and kgdb gives me
this...

unable to handle kernel paging request at virtual address 4446204c
(error 40000000)
NIP: C0014788   XER: 00000000   LR:C0014764   REGS: c0531bf0   TRAP:
0300
MSR: 00009032   [EEIRDRME]
TASK: c0530000[7]   'ohci-control' mm->pgd   c0155000   Last syscall: -1

GPR00: C0530000   C0531CA0   C0530000   00009032   00000000   00000000
FFFFFC18   C0157260
GPR08: C0157260   0000001B   C0530000   C015ABC8   88462022   002060A8
00000000   00000000
GPR16: 00000000   00000064   C0531D90   01000000   C0463B60   C0513000
00000000   80000000
GPR24: C0513220   C0531D88   00000000   C0170000   C0157260   00000000
44462028   C0531CA0
kgdb: entering handle-excpetion; trap[0x300]
turning serial ints off

Does anyone know how I can fix or just get around this error? If not can
anyone point me in the right direction? I just need source for a kernel
that will run on my G4. Thanks

Ryan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
