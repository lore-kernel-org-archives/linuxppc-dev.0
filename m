Message-ID: <5D2136DF3DD5D311AE89009027C67FB001D8F288@fmsmsx96.fm.intel.com>
From: "Zheng, Haifei" <haifei.zheng@intel.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: FADS board and bootp
Date: Tue, 16 Jan 2001 14:52:34 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

After having shelved the FADS board for a couple of weeks, we dug it out
again and tried to install ppcboot (ver 0.7.1). We used the cross compiler
that comes with hardhat and set the makefile appropriately. The build went
smoothly, with the odd warning popping up. As noted in the doc, downloading
the image is another story. We used the Motorola ADI port to upload the
kernel and to start execution.... unfortunately it doesn't get far ;-D

Here is the dump of attempt number 2 (this time using the ELF binary)

f860TBug> loadf PPCBOOT 3000
loadf: Loading ELF file . . .
Loading flash mapped sections to ram memory buffer:
Loading section 1 (.text) : 00013370 bytes at 00003000
Loading section 2 (.reloc) : 00000c80 bytes at 00017000
Loading section 3 (.data) : 00004488 bytes at 00017c80
Loading section 4 (.bss) : 000026a8 bytes at 0001d000 (not loaded)
Programming flash :0001c6a8 bytes  at 02800000-0281c6a7
Flash programming completed

Loading ram mapped sections to ram memory:
Entry point set to 02800000
Heap start address set to 00000001
Loaded 00000222 symbols into the symbol table
Duplicated symbols (38) expanded with enumerated suffixes
f860TBug> go
  Use Ctrl-C to abort execution !
exception: SOFTWARE EMULATION
0x02800000      27051956 unknown primary opcode 9
f860TBug>

I know others are using the 860T FADS board, so rather struggle.... Some
questions:

What methods are you using to upload binaries?
Have you experienced similar problems?
  Or  have we just done something silly?

Thanks for the help

Cheers
    Caleb.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
