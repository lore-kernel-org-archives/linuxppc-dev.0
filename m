MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Linux boot issues
Date: Fri, 8 Feb 2002 13:17:17 -0600
Message-ID: <D3A72C5007329A4F991C0DD87202259F096A5D@sekhmet.ad.newisys.com>
From: "Navin Boppuri" <navin.boppuri@newisys.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello again,

I have PPCBOOT 1.1.2 running on my hardware with an MPC855T processor running at 64MHZ (both core and bus). I have SDRAM interfaced on this hardware and I think the burst accesses are working fine since PPCBOOT is executing well with burst accesses turned on. I have a 2.4.2 Linux kernel programmed in flash and I am trying to boot this kernel on the hardware.

I have a BDI hooked up to this hardware.

The problem is when I start booting the kernel, PPCBOOT calculates the checksum and says it is OK. It then uncompresses the kernel and even that is successful. The processor then goes into the debug state and halts at instruction 0xc000fa0c with a Software Emulation exception. When I do a disassemble of the Linux kernel, I see that this instruction is the start of the "printk" routine. No matter how many times I do this, I break at exactly the same instruction.

I tried defining CONFIG_CLOCKS_IN_MHZ but that did not change anything. I also tried running the processor at 64Mhz/32Mhz (core/memory bus) and 32Mhz/32Mhz but it did not make a difference.

I was hoping that the kernel would come up atleast with burst accesses turned off, but I see the same exact behaviour even then.

I am not sure what to look for now.

Thank you for all the help and putting up with my weird queries.

Navin Boppuri.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
