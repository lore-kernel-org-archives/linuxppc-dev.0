From: Ruedi.Hofer@ascom.ch
Date: Wed, 05 Apr 2000 17:21:20 +0100 (CED)
Subject: Re: PCMCIA support for 860
To: linuxppc-embedded@lists.linuxppc.org
Cc: erammsu@kieraypc01.p.y.ki.era.ericsson.se, kernel@linux01.hasler.ascom.ch
Message-id: <0FSJ00F9FUON1E@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_LzjW/+wstah39CcoP4AHFg)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_LzjW/+wstah39CcoP4AHFg)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi

Thanx for all the support. I've added now Marcus' patchfiles.
Compiling works fine now.

Unfortunately, when I enable the IDE stuff in the kernel config
(Block devices -> Enhanced IDE support)
it won't boot anymore!

Why?

Is there something else necessary in the kernel config?

(As mentioned in the patch, I've disabled
MPC8xx CPM options -> Configure IDE driver for ATA on PCMCIA....

The kernel output:

entry 0x100000, phoff 0x34, shoff 0x829fc
phnum 0x1, shnum 0x9
p_offset 0x10000, p_vaddr 0x100000, p_paddr 0x100000
p_filesz 0x530c, p_memsz 0xb1cc
Loading at 0x10c000
Starting 0x11c000
loaded at:     0011C000 001271CC
relocated to:  00100000 0010B1CC
board data at: 01FF0000 01FF001C
relocated to:  0010C100 0010C11C
zimage at:     00122000 0018E9C0
avail ram:     0018F000 02000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
<crash><crash><crash><crash><crash>

Ruedi


--Boundary_(ID_LzjW/+wstah39CcoP4AHFg)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
