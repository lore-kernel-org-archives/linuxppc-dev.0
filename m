Message-ID: <20030326035830.20755.qmail@web14601.mail.yahoo.com>
Date: Tue, 25 Mar 2003 19:58:30 -0800 (PST)
From: Kalpesh Jasapara <kjasapara@yahoo.com>
Subject: GDB server and threaded application 
To: gdb@sources.redhat.com
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I am having a problem with remote gdb debugging
using gdbserver to work with multi threads.
The command "info threads" shows only one thread.

I am using glibc 2.1.3, powerpc-linux-gdb 5.3,
powerpc-linux-gcc 2.9.5

Observed that qfThreadInfo packet response contains
only
one thread, not a list of all the threads in our
application.

How does the all_threads list get populated with the
other
threads?

Is this feature supported with the versions that we
are using?

-Kalpesh


Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
http://platinum.yahoo.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
