Message-ID: <B0CAE42C9EE0D311AAAD00500422FC6302CD7B@iis000.microdata.fr>
From: Patrick Lerda <Lerda@microprocess.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Linux 2.3.47 .... PCI boards... Linux beta in general
Date: Wed, 23 Feb 2000 17:36:05 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've tried linux 2.3.47 on my PowerPC 740 board, the core seems working but
a lot of drivers don't work properly.

serial:	linux see my two ISA 16C550 intel compatible, but console go only to
framebuffer

PCI boards:
	Adaptec SCSI, start and crash when HD is found. OOPS here
	IDE	idem

	Ethernet NE2000 board found, fail later.
	Tulip, found fail later.


otherwise:
	USB core seems to work


A lot of problems, probably only endian related...


If you have success with theses kernels.


Patrick LERDA


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
