Message-ID: <41EA756DBC9FD0118CFC0020AFDB5C5A188D91@tcint1ntsrv>
From: Zehetbauer Thomas <TZ@link.topcall.co.at>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: booting HardHat on IBM 405GP
Date: Mon, 26 Mar 2001 18:12:34 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

My company is going to develop an embedded solution based on a IBM 406GP
processor.
We are in early development right now and I am trying to boot linux on a
> IBM 25 EB 405 P4 WIN WAL 00
evaluation kit (this is the information on the bill of delivery).

Attempting to debug I've found linux/arch/ppc/boot/tree/main.c:start to
be the first function executed.
At the very last step this function calls
>    (*(void (*)())sa)(&board_info,
>                      initrd_start,
>                      initrd_start + initrd_size,
>                      cmdline,
>                      cmdline + strlen(cmdline));
and I can't find where execution goes on.

Any help is greatly appreciated.

TIA
Tom

PS: Does someone know how to determine the board's revision number?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
