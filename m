Date: Fri, 29 Sep 2000 14:23:24 +0200
From: Erik Kunze <Erik.Kunze@philosys.de>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Memory used by kernel
Message-ID: <20000929142323.A22858@philos.philosys.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm running Linux 2.2.13 (from ftp.denx.de) on a TQM860L evaluation board
with 16MB of SDRAM. The final product should work with 8MB of SDRAM.

There are several papers available on how to downsize memory usage by
the applications. But how can I reduce the memory used by the kernel
(not counting drivers). Are there any tunables which I can decrese?
Buffer cache? Queues? How do I disable/remove support for swap space?


Erik
--
   Dipl.-Ing. Erik Kunze               Phone: +49 - 89 - 32 14 07 41
   PHILOSYS Software GmbH              Fax:   +49 - 89 - 32 14 07 12
   Edisonstr. 6                        Email: Erik.Kunze@philosys.de
   D-85716 Unterschleissheim           WWW:   www.philosys.de/~kunze

        PGP-Key: http://www.philosys.de/~kunze/public_key.txt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
