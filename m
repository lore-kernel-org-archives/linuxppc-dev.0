Message-ID: <20000330135042.892.qmail@web1205.mail.yahoo.com>
Date: Thu, 30 Mar 2000 15:50:42 +0200 (CEST)
From: Indra Gunawan Harijono <indragho1@yahoo.de>
Subject: Problem: Hangs on pthread_allocate_stack during pthread_create
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Did someone have the problem, that pthread_create
hangs on function pthread_allocate_stack (exacly in
memset(new_thread,'\0'sizeof(*new_thread)) ?? this
happens without running with gdb etc, I just compiled
the programs under Examples and run them on the MPC86
board.

memset itself seems to work corrently (uses
glib-2.1.3/sysdep/powerpc/memset.S).

Unfortunately I do not have gdb on the board.

Following is the configuration, I uses:
Glibc-2.1.3,
powerpc running under MPC860,
gcc-2.95.2,

that I cross compiled under intel PC.


Can someone point me the sites how to build the gdb
for the board using the cross compiler?


I will appreciate, if one can give me hints or infos.

Thank you.


indra

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Yahoo! Mail auf Ihrem Handy? - http://mobil.yahoo.de

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
