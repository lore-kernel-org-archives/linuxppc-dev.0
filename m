Message-ID: <000d01bfe25e$e76c7070$5a01a8c0@blue>
From: "sungyeon" <sungyeon@cosmo.etri.re.kr>
To: "Kwansuk Kim" <kskim@neowave.co.kr>,
        <linuxppc-embedded@lists.linuxppc.org>
References: <NEBBKFENMLEDKDHMEHPJIENDCAAA.kskim@neowave.co.kr>
Subject: Re: Debug information for elf format
Date: Fri, 30 Jun 2000 15:46:20 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.
you can crate DWARF using  "-gdwarf" option.

----- Original Message -----
From: "Kwansuk Kim" <kskim@neowave.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, June 30, 2000 3:17 PM
Subject: Debug information for elf format


>
> Hi, everyone,
>
> I use SMC BDM tool to load linux kernel on my custom mpu860 board.
>
> I try to fix the source to operate on the custom board. But in case of C file it's too difficult. SMC BDM tool supports only ELF file format. But according to the GCC howto, it doesn't produce debug information for elf format but stab, DWARF or COFF.
>
> What should I do to debug C code on BDM?
>
> I'm debugging with data prompted on serial console (SMC2). But it's too hard because I compile the kernel on Linux and operate on win98. Reboot over twenty times a day.  :-(
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
