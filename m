Message-ID: <A109131318C4D1119AC20060088DECE35732DF@mail.adaptivemicro.com>
From: Cindy Peters <cinpet@adaptivemicro.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: New Linux PowerPC development
Date: Tue, 24 Jul 2001 09:56:02 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am looking for some advice on the best PowerPC processor to use for a new
embedded board design. Some features that the board needs to support is a
hard drive ( i.e. IDE), 10/100BaseT Ethernet support, and a large size of
RAM (maybe about 1GByte or more). We have previously completed a design
using the MPC823 so we have the experience and the code available as far as
the initialization of the processor, boot code, ramdisk, and Linux kernel.
The MPC823, however, does not have an IDE or PCI interface for a hard disk.
We feel we would have to design an interface into an FPGA. It doesn't
support 100BaseT either. We are also looking at using either the
MPC8260/MPC8265 or the IBM 405GP. I have been browsing through the
mailing-list archives and have seen that these processors are both widely
used. I would like some feedback from people that have experience in using
these processors with Linux and what recommendations they have.

Thank you,

C. Peters
Adaptive Micro-Ware, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
