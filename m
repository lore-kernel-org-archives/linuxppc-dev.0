Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 31 Jul 2001 14:28:18 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Compiling and using hhl's glibc
Message-ID: <Pine.LNX.4.33.0107311414190.1947-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am getting ready, at long last, to start using glibc on our 603e based
embedded board. Hitherto, I have not used and of the HHL tools. It does,
however, look like their glibc has the best patches, so I'd like to give
it a try.

I have downloaded the rpm and extracted it into a directory:
~/embedded/glibc$ rpm2cpio hhl-target-glibc-2.2.3-hhl2.0.8.src.rpm | \
                  cpio -i --make-directories

This gives me a whole bunch of stuff in that directory, including
glibc-2.2.3pre1.tar.gz. I assume that I need to untar that (along with the
linuxthreads archive) and do a make in there.

My first big question is whether or not all of the needed patched are
already applied? There are 10 obvious patch files in the directory created
from the rpm.

I should be able to handle the actual compile well enough- heaven knows
I've built glibc enough times (sigh...) But, does anyone have
recommendations for things to or not to do?

Once I've built glibc, what is the best way to compile against it? I have
the cross compiler right now installed in ~/embedded/gnu-tools (the
compiler &c are ~/embedded/gnu-tools/host/i386-linux/bun/powerpc-linux-*).
I plan on putting the installed glibc files in that directory as well
(with --prefix given to configure). What modifications would need be made
to the specs file to compile against this installed library.

Thanks in advance,
--Gus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
