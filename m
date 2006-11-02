Return-Path: <rdcorle@yahoo.com>
Received: from web56308.mail.re3.yahoo.com (web56308.mail.re3.yahoo.com
	[216.252.110.232]) by ozlabs.org (Postfix) with SMTP id A58A167D04
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Nov 2006 08:04:59 +1100 (EST)
Message-ID: <20061102210457.38535.qmail@web56308.mail.re3.yahoo.com>
Date: Thu, 2 Nov 2006 13:04:57 -0800 (PST)
From: robert corley <rdcorle@yahoo.com>
Subject: RE: rebuild error for 2.6.18 plb_temac driver from EDK
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

To answer my own question:=0A=0AMakefile (drivers/xilinx_edk/Makefile) inco=
rrect.  This one works=0A=0A-----------------------------------------------=
---------------------------------------=0A# Linux file to EXPORT_SYMBOL all=
 of the Xilinx entries.=0Aobj-$(CONFIG_XILINX_EDK) +=3D xilinx_syms.o=0A#=
=0A# # The Xilinx OS independent code.=0Axilinx_syms-objs :=3D xbasic_types=
.o \=0A                    xdmav3.o xdmav3_intr.o xdmav3_selftest.o xdmav3_=
simple.o xdmav3_sg.o \=0A                    xipif_v1_23_b.o \=0A          =
          xpacket_fifo_l_v2_00_a.o xpacket_fifo_v2_00_a.o \=0A             =
       xversion.o=0A-------------------------------------------------------=
-------------------------------=0A=0A=0A!! Thank goodness for Documentation=
/kbuild/makefiles.txt  !!=0A=0A-cy=0A=0A
