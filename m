Message-ID: <396E95F3.66DB2A25@msoe.edu>
Date: Thu, 13 Jul 2000 23:24:19 -0500
From: ian geiser <geiseri@msoe.edu>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: What causes this error on LinuxPPC?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greetings

    I am trying to compile a program using gcc version 2.95.3 19991030 (prerelease/franzo/20000622)

    for some reason i get this error.  I do not get this error on my stock Linux Mandrake 7.1

    box though.  Any ideas?

gencode.o: In function `prcode':
gencode.o(.text+0x8bf0): undefined reference to `__va_arg_type_violation'
gencode.o(.text+0x8bf0): relocation truncated to fit: R_PPC_REL24 __va_arg_type_violation
collect2: ld returned 1 exit status

    -ian reinhart geiser

--
.---------------------------------------------------.
| Ian Reinhart Geiser - Computer Engineering Student|
| HOME:                           |
| WORK:                       |
| WEB:  http://www.msoe.edu/~geiseri                |
`---------------------------------------------------'


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
