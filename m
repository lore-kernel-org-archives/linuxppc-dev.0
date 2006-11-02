Return-Path: <rdcorle@yahoo.com>
Received: from web56305.mail.re3.yahoo.com (web56305.mail.re3.yahoo.com
	[216.252.110.229]) by ozlabs.org (Postfix) with SMTP id C277467C1F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Nov 2006 06:32:44 +1100 (EST)
Message-ID: <20061102193242.28108.qmail@web56305.mail.re3.yahoo.com>
Date: Thu, 2 Nov 2006 11:32:42 -0800 (PST)
From: robert corley <rdcorle@yahoo.com>
Subject: rebuild error for 2.6.18 plb_temac driver from EDK
To: linux linuxppc-embedded <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Can anyone help me out with this message?  It must be simple but I just am =
not familiar enough=0Awith the kernel build process to recognize the error:=
=0A=0A  CHK     include/linux/version.h=0A  CHK     include/linux/utsreleas=
e.h=0A  CHK     include/linux/compile.h=0Adnsdomainname: Unknown host=0Amak=
e[2]: *** No rule to make target `drivers/xilinx_edk/xilinx_syms.o', needed=
 by `drivers/xilinx_edk/built-in.o'.  Stop.=0Amake[1]: *** [drivers/xilinx_=
edk] Error 2=0Amake: *** [drivers] Error 2=0A=0A# Linux file to EXPORT_SYMB=
OL all of the Xilinx entries.=0Aobj-$(CONFIG_XILINX_EDK) :=3D xilinx_syms.o=
=0A#=0A# # The Xilinx OS independent code.=0Aobj-$(CONFIG_XILINX_EDK) +=3D =
xbasic_types.o \=0A                            xdmav3.o xdmav3_intr.o xdmav=
3_selftest.o xdmav3_simple.o xdmav3_sg.o \=0A                            xi=
pif_v1_23_b.o \=0A                            xpacket_fifo_l_v2_00_a.o xpac=
ket_fifo_v2_00_a.o \=0A                            xutil_memtest.c xversion=
.o=0A=0A=0A
