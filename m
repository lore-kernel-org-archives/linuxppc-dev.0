Message-ID: <3A1E770D.6AF3C802@fideltronik.com>
Date: Fri, 24 Nov 2000 15:11:25 +0100
From: Pawel Zawora <pzawora@fideltronik.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: filesystem reading problem
Content-Type: text/plain; charset=iso-8859-2
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I was using kernel 2.2.13 and both libraries: glibc 1.99 and glibc 2.1
and I didn't have any problems with reading files. Now I'm upgrading to
2.4.0-test2 kernel (from mvista for ppc823) and user program (like cat,
more, route) can't read any file. Kernel can execute programs, it means
that kernel can read files. 'ls' shows right size of file.
Any ideas?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
