Message-ID: <E62DBC698514D511A1AC0003470C1314EE2B88@EXCHANGE>
From: Keith Outwater <Keith_Outwater@mvis.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Problems building ppc cross compiler under RH7.2 x86 - SOLVED
Date: Thu, 15 Nov 2001 08:42:59 -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings all -

My thanks to Kevin Williams and Evandro Borracini for their suggestions on
fixing my cross compiler build problem.

The problem was solved by doing two things:
1. Edit the file <path where you put glibc>/lib/libc.so  as follows:

from:
GROUP ( /lib/libc.so.6.1 /lib/libc_nonshared.a )
to:
GROUP ( <path where you put glibc>/lib/libc.so.6.1 <path where you put
glibc>/lib/libc_nonshared.a ) (Evandro)

That fixed the c cross compiler build.


2. Apply a patch tp gcc from http://gcc.gnu.org/install/glibc-2.2.patch
(Kevin)
That fixed the c++ cross compiler build.


I will forward this information to the maintainer of the cross compiler
mini-howto.


Thanks!
Keith

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
