Message-ID: <E8F83D6D2A6AD3118E0300902786A20502371419@NTEX>
From: "David Marqvar (DAM)" <DAM@tt.dk>
To: "Embedded Linux PPC List (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Cc: "Laurits Lassen Petersen (LLP)" <LLP@tt.dk>
Subject: target=powerpc-linux, powerpc-eabi, powerpc-elf
Date: Wed, 13 Feb 2002 15:12:35 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


What is the difference between the 3 (?) types og targets for powerpc?
ELF = Extended Linker Format
EABI = Embedded Application Binary Interface
Linux = ?

Is it 3 different layouts for the binary file?


The machine-type in GCC is stated as:
i386-redhat-linux
powerpc-elf
powerpc-unknown-linux
powerpc-unknown-linux-gnu

What does these parts define (*-*-* = processor-binaryformat-system, or?) ?


Which target will you suggest using when working with a MPC823 using PPCBoot
?


We want to build our own kernel for the MPC823 - can we use Newlib for that?
- from the documentation to Newlib it seems as if there is missing some
hardware-specific parts in newlib which is needed by Linux...?
We will only be running normal/simple apps with the kernel and don't need
some "almost-never-user" functions from the libary.

If we can use newlib (hope so since it is smaller) - should we compile the
cross-gcc with the option --with-newlib ?


Maybe stupid questions (hope not)....
Thanks in avance!

Regards,
David Marqvar

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
