Message-ID: <20000403175413.2183.qmail@web1205.mail.yahoo.com>
Date: Mon, 3 Apr 2000 19:54:13 +0200 (CEST)
From: Indra Gunawan Harijono <indragho1@yahoo.de>
Subject: Problem: cross compiler and pthread
To: linuxppc-dev@lists.linuxppc.org
Cc: kd@flaga.is
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Did someone have the problem with the IO operation
under pthread.
I built the glibc using default libio (GNU Libio I
think) as many people wrote and discuss (as cookbook
etc.) here and It crashed, if I make printf operation.
Can someone tell me how to build glibc using stdio
(because I think, this is thread safe than GNU Libio)

Following is the configuration, I uses:
binutil 2.9.5.0.29
Glibc-2.1.3,
powerpc running under MPC860,
gcc-2.95.2,

that I cross compiled under intel PC.

Can someone point me the sites how to build the
gdb
 for the board using the cross compiler?


I will appreciate, if one can give me hints or
 infos.

thanks

indra


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
