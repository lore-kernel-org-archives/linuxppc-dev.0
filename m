From: "Christian" <evil@www.housecafe.de>
To: Tom Rini <trini@kernel.crashing.org>,
	Christian Kujau <evil@g-house.de>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Reply-To: evil@g-house.de
Subject: Re: still unable to compile with kgdb enabled
Date: Sat, 10 Apr 2004 16:15:59 +0100
Message-Id: <20040410141017.M46998@www.housecafe.de>
In-Reply-To: <20040409220646.GB1787@smtp.west.cox.net>
References: <40771841.8040001@g-house.de> <20040409220646.GB1787@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 9 Apr 2004 15:06:46 -0700, Tom Rini wrote
> The CVS version of the patch is against 2.6.5, and if you only

the CVS version of kgdb.sourceforge.net? i fetched it, but it still does
not apply:

------------
evil@sheep:/usr/src/linux-2.6-build$ head -n3 Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 5
evil@sheep:/usr/src/linux-2.6-build$ cat \
/usr/local/src/kgdb/kgdb-2/core.patch | patch -p1 --dry-run
patching file include/linux/sched.h
patching file include/linux/module.h
can't find file to patch at input line 66
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|--- linux-2.6.5.orig/include/linux/kgdb.h      2004-04-08
09:40:25.496959430 -0700
|+++ linux-2.6.5/include/linux/kgdb.h   2004-04-08 16:14:12.662858861 -0700
--------------------------
File to patch:
------------

....and so on.
hm, i'll go then with the "-lite" patches, they apply cleanly.

> pass in 'kgdbwait', it should work w/o mods (otherwise it
> breaks in very early, and requires some additional work).
> I've tested this out on a few machines locally, but not
> PPC_MULTIARCH, so there might be a few incidental things
> required to be fixed.  I've been using the KGDB_8250, and not
> PPC_SIMPLE_SERIAL, but I plan on testing that sometime in the future.

hm, i'll see what it gives with the lite-patches now.

> FWIW, I'm about to go off for 2 weeks vacation, so I probably
> won't be able to help you, if it doesn't work right away.

happy holidays!

Thank you,
Christian.
 --
BOFH excuse #95:

Pentium FDIV bug


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
