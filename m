Message-ID: <389CDEAE.FC4EAEB1@flashcom.net>
Date: Sat, 05 Feb 2000 18:38:38 -0800
From: Robert Kavaler <kavaler@flashcom.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Why does the PPC kernel architecture not use the builtin
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


functions such as memcpy?  Are these broken?  I notice that the user
level code uses the builtin, but the kernel specifies -fno-builtin.
This seems like a big hit to efficiency.

In the same vein, the code (.h) to do byte swapping has a comment that
the ppc byteswap instruction should not be used, so instead a less
effecient code sequence is used.  This is supposed to be a problem with
a specific rev. of the compiler.  Does anyone know if this has been
fixed in the newest gcc or egcs (soon to be merged) compilers?

Thank you,

Robert Kavaler


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
