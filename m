Subject: Linux on PowerCore CPCI-3750
From: luca gambazzi <luca.gambazzi@epfl.ch>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1048770148.32275.11.camel@shampoo.epfl.ch>
Mime-Version: 1.0
Date: 27 Mar 2003 14:02:28 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi

i'm swiss student, i'm trying to crosscompile a linux kernel for a Force
Computers PowerCore CPCI-3750.

i've found an old image and works fine but when i try to complile myself
a new kernel image the PowerBoot (bios on the card) give me an error

Starting image at address 0x00010000...


exception occured: 0x700
SRR0 = 0x00000000
SRR1 = 0x00080000
MSR  = 0x00000030
HID0 = 0x8010008D
HID1 = 0x70000000
L2CR = 0x00000016
*** Program Exception ***

so my kernel image is wrong,... to create the kernel image (v2.5 patched
for ppc) i've used the make bzImage and then with powerpc-linux-objcopy
i've changed the ELF32bit file in a binary data file.
what's worng? can somebody tell me where fine documentation?

thanks a lot
luca gambazzi


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
