Message-ID: <A3E34B558F5CD211B4980008C7A4A99003163E46@sparrow.eng.gilbarco.com>
From: "Williams, Kevin M." <kevin.m.williams@marconi.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Linux stand-alone boot & mtd info
Date: Tue, 10 Apr 2001 09:00:26 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Claire,

Go here:

ftp://ftp.uk.linux.org/pub/people/dwmw2/mtd/cvs/

Grab the latest snapshot of the mtd code and read mtd-jffs-HOWTO.txt in the
root directory.  It describes the procedure at the end of the document, but
it's not entirely complete.

As the name implies, the HOWTO has (up to date!) info on jffs.  It even
spells out what options to set in the 2.4 kernel to get mtd to work.  That
might answer a couple other questions asked recently.

If anyone else out there is working with jffs and has executable versions of
the jffs utilities (namely 'erase' and 'mkfs.jffs') for an PPC860 I'd REALLY
appreciate a copy.  We've hacked up makefiles enough to get CygWin to cross
compile and build a kernel, but I'm not having much luck building the jffs
utilities...

Kevin Williams

-----Original Message-----
From: Claire Troussier [mailto:troussier@digigram.com]
Sent: Tuesday, April 10, 2001 5:46 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux stand-alone boot



I would like to know if documentation exits describing how to configure
and build Linux kernel to boot a target in stand alone mode. The target
is based on a PowerPC MPC8240.

Thank you for your interest

Claire


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
