Date: Fri, 24 Dec 1999 00:12:18 +0100
From: Raphael Bossek <raphael.bossek@solutions4linux.de>
To: Ruedi Hofer <ruedi.hofer@ascom.ch>
Cc: raphael.bossek@solutions4linux.de, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Loading the Kernel on a FADS
Message-ID: <19991224001218.A6891@raphael.bossek.home>
References: <3861E076.9BFCA5E8@ascom.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3861E076.9BFCA5E8@ascom.ch>; from ruedi.hofer@ascom.ch on Thu, Dec 23, 1999 at 09:42:30AM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi Ruedi,
 
> Is my procedure correct?
if you have trouble with the mksrombin program writtin by Magnus so please
contact him because i do not use it...

> How do you download the kernelcode to the board?
first i'm using 8xxROM from Magnus with patches from me. this patches alows
to use a real IDE drive connected thourght the PCMCIA interface where my
Linux kernel can be saved like with eatch other hd. Magnus use also this
solutions but he use PCMCIA FLASH-CARDS with a IDE interface.

i use the mpc8xx-2.2.13 kernel with some patches so you can also get mathemu
support from 2.3.33 and so on... take a look at http://www.s4l.de where all
the stuff you need can be found...

do NOT forget to report me your expiriences so i can make a support list of
boards + cpus, board-revisions ect.

my patches influence the 8xxROM. if you use the 8xxROM you have only to
use the hd or a rom-drive (in flash; read the source-code). i have had to
create a valid elf file because my flash utility only works with valid elf
files (SDS Debuger Flash Utility througth BDM-Interface/Wigler). i hope i
can find time after my vacation to play with the mpc8bug; i never used it!

summary: 8xxROM with PCMCIA HD + ext2 + dos fs support -> FLASH
         Linux -> 4GB HD connected to PCMCIA with ext2 fs

i hope i can find some time make pictures after my vacation of the running
system in the meantime i fight with cross-compiler creation and so on...

WHY DOES REISERFS NOT WORK WITH POWERPC !

--
Raphael Bossek <raphael.bossek@solutions4linux.de> [ICQ #40047651]
PGP fingerprint: DF 6F 2C 76 46 1E B4 1C  5B A5 2E 1B FC E0 D3 F6
PGP public key: http://www.solutions4linux.de/private/pgpkey.asc

   __ _    Debian GNU
  / /(_)_ __  _   ___  __
 / / | | '_ \| | | \ \/ /
/ /__| | | | | |_| |>  <     The Choice of a GNU Generation
\____/_|_| |_|\__,_/_/\_\

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
