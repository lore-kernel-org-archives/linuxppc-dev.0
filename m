Message-ID: <39DD0B81.1B174A4C@email.mot.com>
Date: Thu, 05 Oct 2000 18:15:13 -0500
From: Robert Rati <arr060@email.mot.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Packing structures with gcc
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all

I am trying to read a byte stream into a structure and padding shifts
the members of the structure. How do I turn on packing of the structures
to ensure no padding. I am working with gcc version 2.95.3 on a Linux
ppc distribution with 2.2.13 kernel and glibc 2.1.3.  I have tried using
the -fpack-struct option with no luck.  Are there options to the
standard binary distributions of gcc for struct packing, or do I need to
compile gcc from source?  I have tried compiling gcc 2.95.3 with compile
version 2.95.3 and I get an internal compiler error.  Upon looking at
the gcc source, it appears that HANDLE_SYSV_PRAGMA needs to be defined
(according to c-pragma.h), but how would I configure the makefiles in
the gcc source to enable this option correctly?  Would appreciate any
help with this.

Thanks
Rob

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
