Message-ID: <3A4E1112.B3A090B0@denise.shiny.it>
Date: Sat, 30 Dec 2000 11:45:06 -0500
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: panic loading 3c509.o
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I tried to use a 3com eth card on my G3 without success. Kernel
panics when I load the modules with this error:

Machine check, Unknown value srr1
...
Task "modprobe" mm->pgd  Last syscall: 128
...

Some time ago I had no problems to make linux see and configure
the same card (a 3com 595) with a 2.2.x kernel (I don't remember
the version, sorry).

(Linux 2.2.18, gcc 2.95.3, bw-G3)

Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
