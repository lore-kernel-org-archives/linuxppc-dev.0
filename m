Message-ID: <20000405171941.8277.qmail@web1202.mail.yahoo.com>
Date: Wed, 5 Apr 2000 19:19:41 +0200 (CEST)
From: Indra Gunawan Harijono <indragho1@yahoo.de>
Subject: problem: glibc-2.1.3 libio not thread safe ?
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I built cross development and find out
that printf crashed if I built glibc (2.1.3) and
pthread using GNU libio (default). If I built glibc
using stdio, the program runs correctly, but
unfortunately this glibc library work only with gcc
compiler (2.95.2) and does not work together with the
cross compiler g++ in building the iostream or
libstdc++. Building gcc-2.95.2 seems to force to use
libio in the libc.
Does someone have such experience ??
Any comments and hints are highly appreciated.

thanks

indra


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
