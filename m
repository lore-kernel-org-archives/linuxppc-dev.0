Message-ID: <A1C99F4731CAD111BA5400A024FC3B0C9FD0B4@ESBILMA01EDCGE>
From: "Billalabeitia, Jose Carlos (IndSys, GEPM)" <jc.billalabeitia@indsys.ge.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Coffboot & jffs2
Date: Wed, 1 Aug 2001 12:47:40 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	Hi everybody:

	I have a PPC860T custom board and it is working
with PPCBoot 0.7.1 and Linux 2.4.4 kernel source
from:

ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4.4-2001-05-12.tar.bz2

Everything goes fine, but right now I want to use
the flash as a hard-disk through jffs2. The problem
is that I am not able of getting a linux kernel with
coffboot and jffs2 directories, at the same time.

I also have the HardHat 2.0 Journeyman Edition that
comes with jffs2, but it doesn´t have the coffboot
directory, so I can´t create the kernel image to
be booted by PPCBoot. How can I create a kernel
image for the PPCBoot from this distribution ?
Where can I get a linux kernel with these two
features at the same time ?



Thank you


Billa


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
