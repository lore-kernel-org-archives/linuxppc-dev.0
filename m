Date: Thu, 20 Mar 2003 23:36:44 -0600 (CST)
From: "Milton D. Miller II" <miltonm@realtime.net>
Message-Id: <200303210536.h2L5aibc078332@sullivan.realtime.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re:  Linux console on virtual Uart?
Cc: James.Dang@gdcanada.com
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At least for the archives, I will point out the the hvc console (located
at drivers/char/hvc_console.c) is a polling mode driver for a serial style
console, that calls a function to read up to 16 bytes at a time from some
other buffer.  This might be easier to adapt (just write a pair of
hvc_{get_put}_chars functions) ...



Regarding your questions, I don't know why you aren't getting a prompt,
but the line

init: asdf: command not found

can be explained becaues the kernel calls the "init" program with argv[0] =
"init", and the shell is using this name (or the part after the last / if
present) to explain itself.

milton

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
