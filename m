From: bob@kunk.jriver.com
Message-ID: <20000627221948.10637.qmail@kunk.jriver.com>
Subject: 2.2.17pre7 Ramdisk compile failure
To: linuxppc-dev@lists.linuxppc.com
Date: Tue, 27 Jun 2000 17:18:23 -0500 (CDT)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


rd.c:115: `CONFIG_BLK_DEV_RAM_SIZE' undeclared here (not in a function)

BTW, I got this from a fresh rsync from Pauls stable tree. I've been noticing
odd behavior with these rsync images ocassionally. It seems like
older files are not always replaced and I ran into a missing autoconf.h this
afternoon.

Are there known issues with rsync?

rsync version 2.4.1 Copyright Andrew Tridgell and Paul Mackerras

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
