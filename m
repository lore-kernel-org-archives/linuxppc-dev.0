Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Ppc Developers" <linuxppc-dev@lists.linuxppc.org>
Subject: PowerSpan PCI / sym53c8xx SCSI
Date: Wed, 21 Aug 2002 20:47:49 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFMEAJDLAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Perhaps this will jog a couple brain cells.

I retrieved 2.4.19 final from BitKeeper and have successfully gotten PCI
working with the SYM53C8xx version 2 driver. (No modifications were made to
the PCI setup)

However it only works if you select the "normal I/O" option with the
SYM53C8xx version 2 driver. SYM53C8xx version 1 does not work. Version 2
does not work if the I/O option is not selected.

It sounds like a byte-swap issue with the memory interface. Has anyone else
run into this? I am using an 8260 not a Mac/PowerPC. Perhaps there is
something there?

TIA


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
