Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <03ee01c0b206$c4878ea0$3000a8c0@primag>
From: "Mark Powell" <medp@primagraphics.co.uk>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Compiling/debugging 405GP and RISCWatch
Date: Wed, 21 Mar 2001 12:59:30 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I'm at the beginning of a project using the 405GP. I have HardHat linux
(01.03.03 kernel) up and running on a Walnut eval card. That bit is fine.

However, for one very deeply embedded part of the hardware I can't use linux
(not enough RAM and ROM), I just want a bootstrap to run a single program.
I'm trying to decide on a debugging strategy and I am considering RISCWatch
with the JTAG adaptor. I have experimented with RISCWatch using a network
connection to the Walnut ROM Monitor, but have so far been unable to produce
an executable with the HardHat/GNU tool chain from which RISCWatch can read
debugging symbols. The RISCWatch manual says it can read ELF/DWARF files,
and indeed it seems to download my executable, but gives an error
"DwarfCompilationUnit: invalid FORM = 0"

I would be grateful for any info on these points...

Is it possible to use RISCWatch with the GNU toolchain?
Is it possible to use the RISCWatch/JTAG interface as a backend to gdb?
Any other suggestions for debugging (with no network connection on the
target)?
Any pointers to more info.

TIA
--
Mark Powell, Senior Software Engineer, Primagraphics Limited
New Cambridge House, Litlington, nr.Royston, Herts, SG8 0SS, UK
Tel. +44 1763 852222, Fax. 853324, http://www.primagraphics.co.uk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
