Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 31 Oct 2002 14:39:59 +1100
From: Erik Christiansen <erik@dd.nec.com.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Assembler "Error: unsupported relocation against r0"
Message-ID: <20021031033959.GA1806@dd.nec.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   powerpc-linux-as, built according to Penguinppc.org's "Cross
Development mini-howto for PPC Linux", is giving me stick about the
simplest assembler statements:

fred.s >>>
   .text
   .align 2
   li          r0,0
   addi        r0,0,0
<<<

$ powerpc-linux-as fred.s
fred.s: Assembler messages:
fred.s:3: Error: unsupported relocation against r0
fred.s:4: Error: unsupported relocation against r0

The Motorola on-line doco seems to agree that this code is kosher.

   Does anyone know of any description of what powerpc-linux-as will
swallow?  (I have the generic (g)as document from gnu.org, and it is
good for getting the directives right. Manpages, info, the archive, and
the web have not added much substance.

   Before going back to tackling the 1500 lines of board initialisation
code which assembled with Diab tools, I must discover what daft
omissions of mine are causing this to fall over.

                          --------------------
powerpc-linux-as --version
GNU assembler 2.13.90.0.4 20020814
Copyright 2002 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms
of the GNU General Public License.  This program has absolutely no
warranty.
This assembler was configured for a target of `powerpc-linux'.

Regards,
Erik


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
