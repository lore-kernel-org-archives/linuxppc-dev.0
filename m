From: Ruedi.Hofer@ascom.ch
Date: Thu, 06 Jan 2000 17:06:18 +0100 (CET)
Subject: Antwort: Re: Loading the Kernel on a FADS
To: raphael.bossek@solutions4linux.de
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <0FNX00C4U99OTE@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_f3LL66+q3gPGsf/IFhwWjQ)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



--Boundary_(ID_f3LL66+q3gPGsf/IFhwWjQ)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi Raphael

After some troubles your 8xxrom seems to work. It starts up and I can read the help...

Your homepage was a great help!

Unfortunately, I'm still waiting to get the PCMCIA Flash Disk. 

Without Flash Disk, the following changes had to be made to get it running:
- disk_init() in main.c only called if PCMCIA present. Otherwise it crashes. *)
- For being able to compile it, I had to define CONFIG_SCC1_ENET in Make.config.

The following Problem is still open (Any Ideas?)
- If I press a couple of keys and then backspace, the board crashes *)
- if I call md with parameters, the board crashes *)  (md without params is ok)
- If the first key is a <return> (and no key was printed coincidentially) the board crashes *)

Might it be a stack or memory problem?

What does this exception mean?

Best regards
                                          
Ruedi Hofer                       
                                 
----------------------------------------------------------------------


*) crash always means :

8xxROM >
Machine check in kernel mode.
Caused by (from msr): regs 003efec0 Machine check signal - probably due to mm fa
ult
with mmu off
NIP: FE008510 XER: E000FE7F LR: FE00255C REGS: 003efec0 TRAP: 0200
MSR: 00001002 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00

GPR00: 0000006D 003EFFB0 FE00408C 00000000 FE0095C4 00000002 00010000 00000000
GPR08: FF002808 00010000 00001E48 FFFFFFFF FE010000 00000000 FE010000 FE010000
GPR16: FE010000 FE010000 FE010000 FE010000 FE010000 FE010000 FE010000 FE010000
GPR24: 00010000 00010000 003F0000 00010000 FF002FD8 FF002FDC 00000000 00010304
Call backtrace:
FE0024F8 00400000
machine check


--Boundary_(ID_f3LL66+q3gPGsf/IFhwWjQ)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
