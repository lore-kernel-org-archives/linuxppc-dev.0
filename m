From: "dong in kang" <dkang@east.isi.edu>
To: "'Linux PPC Embedded mailing list'" <linuxppc-embedded@lists.linuxppc.org>
Subject: boot PPClinux on Sandpoint with Atlimus board
Date: Wed, 14 May 2003 09:53:45 -0400
Message-ID: <000401c31a20$3ddee7c0$45a97241@Minjoo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.LNX.4.44.0305140737170.30763-100000@spider.ancor.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



 Hello,

 I'm trying to boot PPClinux on Sandpoint with Altimux board (using MPC755
and MPC107 bridge chip).
I don't use DINK32. I use Codewarrior v.6.0 with BDI 2000.
I'm trying to load the zImage.initrd on the SDRAM and directly run the
kernel without using bootloader.
I use MontaVista's hardhat linux. I configured the linux to work for
Sandpoint.
I use BDI2000 to initialize the bridge chip, which are less than 10
instructions long.
After initialization, I can read/write sdram.
And then I upload zImage.initrd at 0x800000.
It successfully decompresses the kernel and jump to 0x00000000.
>From there it works fine until it enables MMU and jump to 0xC0000000.
When it jumps to 0xC0000000, it only finds garbage there. All FFs at
0xC0000000.
I checked the register MSR and BATs. They look OK. But address translation
doesn't seem to occur.
I think I need to do more initialization before I upload zImage.initrd and
run it.
Could anybody tell me what should i do?

 Thanks,

 Dong-In Kang


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
