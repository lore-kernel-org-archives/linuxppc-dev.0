From: ajay.kunnath@exgate.tek.com
Message-ID: <21F9768AF088D211BF1C0008C71E5786014EED18@ap-bang-m02.india.tek.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Local-PCI bridge mapping
Date: Wed, 15 Nov 2000 03:43:16 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a proprietary MPC860 board which has a PLX 9054 Local-PCI
bridge. I am running the 2.4.0 version of the kernel from
montavista.

My problem is that I am not able to map the configuration registers
to any other address but 0x80000000. When I map it to 0x80000000, it
works great, any other address and it just crashes. Below is the log
of what happened when I mapped the PLX to 0xF0000000.

NIP: C0077C3C XER: 00000000 LR: C0077C00 REGS: c01fde30 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c01fc000[1] 'swapper' Last syscall: -1
last math 00000000 last altivec 00000000
GPR00: 00000000 C01FDEE0 C01FC000 F0000000 C01FDEE8 C01FDEEA 00010000
A0000000
GPR08: 40000000 C00F0000 00000024 C00E7B80 84000029 100A11AC 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 FA202D64 001801B8 00380000
000031B3
GPR24: 00000000 FA202D00 FA202D40 00200075 00200000 F0000000 00000000
00000000
Call backtrace:
001801B8 C0078E20 C00F280C C00022B0 C0007650
Kernel panic: kernel access of bad area pc c0077c3c lr c0077c00 address
F00000F0 tsk swapper/1
Rebooting in 180 seconds..


Could someone please give me some insight into what the problem could be ?

Thanks,
Ajay

_______________________________________________________

If you don't strike oil in twenty minutes, stop boring.
- Andrew Carnegie, on public speaking
________________________________________________________

Ajay Kunnath
E Mail: ajay.kunnath@tek.com
Voice : 2215535 +3313

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
