From: "Kwansuk Kim" <kskim@neowave.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Debug information for elf format
Date: Fri, 30 Jun 2000 15:17:29 +0900
Message-ID: <NEBBKFENMLEDKDHMEHPJIENDCAAA.kskim@neowave.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <00Jun4.144038est.115228@border.alcanet.com.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, everyone,

I use SMC BDM tool to load linux kernel on my custom mpu860 board.

I try to fix the source to operate on the custom board. But in case of C file it's too difficult. SMC BDM tool supports only ELF file format. But according to the GCC howto, it doesn't produce debug information for elf format but stab, DWARF or COFF.

What should I do to debug C code on BDM?

I'm debugging with data prompted on serial console (SMC2). But it's too hard because I compile the kernel on Linux and operate on win98. Reboot over twenty times a day.  :-(


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
