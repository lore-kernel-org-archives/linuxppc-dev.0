Message-ID: <3A53F52A.9F49CCAD@iiic.ethz.ch>
Date: Thu, 04 Jan 2001 04:59:38 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: problems when recompiling dmasound modules
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Whenever I rebuild my linux-pmac-devel tree when the kernel version changed I
get bitten by this:

The sound modules don't get rebuilt so their version doesn't match the kernel
version and they can't be insmoded.

I can investigate to find a solution myself but I figured it should be easier
for Geert or one of the other dmasound hackers to fix it.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
