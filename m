Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain;
  charset="iso-8859-15"
From: Rakesh jagota <j.rakesh@gdatech.co.in>
Reply-To: j.rakesh@gdatech.co.in
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux booting problem
Date: Sat, 14 Jun 2003 18:44:05 +0530
MIME-Version: 1.0
Message-ID: <2f6qkz3a8wsqzda.140620031834@gda-server>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
I am working on custom design board based on IBM405ppc, I am getting the
error message, " oops... out of memory".

Can anyone suggest me where can I find the the SDRAM size defination in the
kernel. And where are they doing the memory mapping. I have modified the
partitons in  drivers/mtd/maps/redwood.c file  as per our board. but couldnt
loacte anything relted to SDRAM.

In arch/ppc/boot/simple/Makefile, I could not undersatnd one thing:

whats the meaning of this line:

LD_ARGS				= -T ../ld.script -Ttext 0x00800000 -Bstatic
ifeq ($(CONFIG_8260)$(CONFIG_4xx)$(CONFIG_8xx),y)
LD_ARGS				:= -T ../ld.script -Ttext 0x00400000 -Bstatic
endif


can anyone help me out to make it work.

Thanks & Regards,

Rakesh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
