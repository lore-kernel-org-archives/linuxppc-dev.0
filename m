Date: Thu, 26 Jul 2001 20:07:59 -0400
From: Armando Di Cianno <diciaa@rpi.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: aty128fb.c missing from rync'd benh sources...
Message-ID: <20010726200759.A19851@garmonbozia.productivitynet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I did an rsync to penguinppc.org::linux-2.4-benh at approx 7/26/01 8 PM
EST.

'make vmlinux' fails in the video directory complaing it is not able to
find aty128fb.o.  I checked in drivers/video and there is no aty128fb.c
file anymore; I re-rsynced to make sure it wasn't my incompetence.

Since the benh kernel tends to be my 'favorite', I'd like to get my TiBook
re-rsynced whenever possible.  Is there any reason this file was removed,
or was it a mistake?

Thanks for any info.

__armando di cianno
diciaa@rpi.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
