From: Ruedi.Hofer@ascom.ch
Date: Tue, 11 Jan 2000 10:47:50 +0100 (CET)
Subject: RE: Antwort: Re: Loading the Kernel on a FADS
To: mika.lepisto@mitron.fi
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <0FO6005190KNBJ@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_wFQfvDdsBZH1uEXlRfmisw)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



--Boundary_(ID_wFQfvDdsBZH1uEXlRfmisw)
Content-type: TEXT/PLAIN; CHARSET=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi Mika

How did your mkrombin work on the zImage. Here it always failed ....

Therefore I bought an ATA Flash disk.
I copied the zImage to the flash disk and plugged it into the board.

My problem is that the board doesn't recognise the Flash disk.

First it says that 'pcmcia: card not present'
Then It prints an error message like: "Boot device list: Card not ready, 0xf0"
and exits with an 'Software emulation interrupt'

Please keep me updated!


Ruedi






mika.lepisto@mitron.fi on 11.01.2000 10:14:21
An: Ruedi.Hofer@ascom.ch @ MailGate
Kopie:  
Thema: RE: Antwort: Re: Loading the Kernel on a FADS

Hi Ruedi

I'm have FADS823 also and I like to get Linux booting from the flash of
my FADS board. I downloaded all stuff from Raphael's site. I have some
troubles and this is what I have made (I'm using crosscompiler so I had
to update my binutils) . Please send feedback to me, so I can start
digging whats wrong. 
 
1.defines to 8xxrom-0.3.0 config.h
        #define CONFIG_DISK_ROM 1
        #define CONFIG_SCC1_ENET 1
 and to main.c
        change PGSZ from 10000 to 4096
2.compiled  8xxrom with 'make s19' 
3.downloaded 8xxrom.bin.s19 to the FADS823 board with 'LOADF
8xxrom.bin.s19 100000'     
and when the board boots it gives me this kind of output: 

8xxROM 0.3.0

compiletime options:
board: FADS DRAM_50MHZ SDRAM_50MHZ
disk: DISK_ROM

cpu:  at 48 MHz: 2Kbyte icache 1Kbyte dcache

<warning: cpu core has silicon bugs, check the errata>

board: FADS with db MPC823 rev ENG or PILOT
flash: unknown flashdelay(0x4) - defaulting to 150 ns2 Mbytes, delay 150
ns
sdram: 4 Mbyte, OK
dram: 4 Mbyte, 60 ns, OK
pcmcia: No card present.

Boot device list:
 rom: rom_disk


rom:0:ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
ÿÿÿÿÿÿÿÿ
ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
ÿÿÿÿÿÿÿÿ
ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
ÿÿÿÿÿÿÿÿ
ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
ÿÿÿÿÿÿÿÿ
ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
ÿÿÿÿÿÿÿÿ
ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
ÿÿÿÿÿÿÿÿ
ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
ÿÿÿÿÿÿÿÿ
ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
ÿÿÿÿÿÿÿÿ
ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
ÿÿÿÿÿÿÿÿ
ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
ÿÿÿÿÿÿÿÿ
ÿÿÿÿÿÿÿÿÿÿ> Machine check in kernel mode.
Caused by (from msr): regs 007efec0 Machine check signal - probably due
to mm fa
ult
with mmu off
NIP: FFFFFFFC XER: E0007D7D LR: FFFFFFFF REGS: 007efec0 TRAP: 0200
MSR: 40001002 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00

GPR00: FFFFFFFF 007EFFB0 FE0040AC 00000020 FFFFFCDA 0000000A FFFFFFFF
00000000
GPR08: FF002808 00000001 00001E48 FF0009C0 00000000 FFF7FFFF FE010000
FE010000
GPR16: FE010000 FE010000 FE010000 FE010000 FE010000 FE010000 FE010000
FE010000
GPR24: 00010000 00010000 FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF
FFFFFFFF
Call backtrace:
machine check

4. I think my problem in 3. is that 8xxrom can't find zImage,right? So I
tried to compile my zImage with 'mkrombin zImage' and I have output
'something wrong with file zImage'. Can you use mkrombin to that, if so
how did you do that? Can you download your zImage to flash and how? 

TIA
Mika Lepistö
mika.lepistö@mitron.fi

> -----Original Message-----
> From: Ruedi.Hofer@ascom.ch [SMTP:Ruedi.Hofer@ascom.ch]
> Sent: Thursday, January 06, 2000 6:06 PM
> To:   raphael.bossek@solutions4linux.de
> Cc:   linuxppc-embedded@lists.linuxppc.org
> Subject:      Antwort: Re: Loading the Kernel on a FADS
> 
> Hi Raphael
> 
> After some troubles your 8xxrom seems to work. It starts up and I can
> read the help...
> 
> Your homepage was a great help!
> 
> Unfortunately, I'm still waiting to get the PCMCIA Flash Disk. 
> 
> Without Flash Disk, the following changes had to be made to get it
> running:
> - disk_init() in main.c only called if PCMCIA present. Otherwise it
> crashes. *)
> - For being able to compile it, I had to define CONFIG_SCC1_ENET in
> Make.config.
> 
> The following Problem is still open (Any Ideas?)
> - If I press a couple of keys and then backspace, the board crashes *)
> - if I call md with parameters, the board crashes *)  (md without
> params is ok)
> - If the first key is a <return> (and no key was printed
> coincidentially) the board crashes *)
> 
> Might it be a stack or memory problem?
> 
> What does this exception mean?
> 
> Best regards
>                                           
> Ruedi Hofer                       
>                                  
> ----------------------------------------------------------------------
> 
> 
> *) crash always means :
> 
> 8xxROM >
> Machine check in kernel mode.
> Caused by (from msr): regs 003efec0 Machine check signal - probably
> due to mm fa
> ult
> with mmu off
> NIP: FE008510 XER: E000FE7F LR: FE00255C REGS: 003efec0 TRAP: 0200
> MSR: 00001002 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
> 
> GPR00: 0000006D 003EFFB0 FE00408C 00000000 FE0095C4 00000002 00010000
> 00000000
> GPR08: FF002808 00010000 00001E48 FFFFFFFF FE010000 00000000 FE010000
> FE010000
> GPR16: FE010000 FE010000 FE010000 FE010000 FE010000 FE010000 FE010000
> FE010000
> GPR24: 00010000 00010000 003F0000 00010000 FF002FD8 FF002FDC 00000000
> 00010304
> Call backtrace:
> FE0024F8 00400000
> machine check
> 



--Boundary_(ID_wFQfvDdsBZH1uEXlRfmisw)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
