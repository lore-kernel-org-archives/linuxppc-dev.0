Message-Id: <39AD48FD.9D649CCF@uni-giessen.de>
Date: Wed, 30 Aug 2000 19:48:45 +0200
From: Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: asm statement in include/asm not ansi conform
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just compiled XFree from dri.sourceforge.net, which uses the "-ansi"
option for compiling. Problem is, that this fails on some "asm"
instructions in e.g. include/asm-ppc/processor.h. I'm not very firm with
C but is it posible to replace this with __asm__ ? I compiled X without
-ansi and it seems to work. Just for the case other applications also
fail on this.

Greetings

Marc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
