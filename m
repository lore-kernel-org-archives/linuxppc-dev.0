Message-ID: <17B78BDF120BD411B70100500422FC63079F4B@IIS000>
From: Patrick Lerda <Lerda@microprocess.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: RE: linux 2.3.99-pre3 PowerPC 740 & PowerPC 823 and vmalloc, Linu
	x PPC823 Work ?
Date: Tue, 11 Apr 2000 10:00:05 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Linux 2.3.99-pre3 boots on my PowerPC 740, the network works well, adaptec
SCSI driver works, USB is detected
but the IDE driver crash my system. Probably a big endian bug in this
driver...

I try to run Linux 2.3.99-pre3 on a PowerPC 823 board, linux try to boot and
crash silently, the network works
for a short time (few seconds before the crash). Some 823 code need to be
modified to compile linux, but
I don't know if my patches are correct... And I try to start this board on
an NFS partition compiled for PowerPC 603,
I think this code is compatible with math emulation enabled, but I am not
sure.

On PowerPC 823 a vmalloc of 1MB lock the sytem....



Patrick LERDA


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
