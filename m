Message-ID: <3AC9A1611DF4D211AA8E00105AA56D8A048B45@iis000.microdata.fr>
From: Patrick Lerda <Lerda@microprocess.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu,
        "'Benjamin Herrenschmidt'" <bh40@calva.net>
Subject: RE: [linux-fbdev] Retrace
Date: Wed, 9 Feb 2000 14:45:28 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The best way to handle, PCI devices base_address[] on an independant
processor way, is
to use physical memory pointers, we can do this trick on the linux pcifixup
subroutine,
some PPC architectures don't change this value and leave the pci bus
address, this address
can't be used easely... Using the physical memory works with all well
written linux drivers, because
the base_address is taken and used as an argument to ioremap to get a
virtual pointer.


Patrick LERDA


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
