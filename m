Message-ID: <36C8C151.E78C881E@pixo.com>
Date: Mon, 15 Feb 1999 19:52:33 -0500
From: Mike Lockwood <lockwood@pixo.com>
MIME-Version: 1.0
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: debugging pthreads on R5?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I am trying to debug a multithreaded program on LinuxPPC preR5 (the Feb
7 RPMS with the 2.2.0pre2 kernel).  As soon as my program calls
pthread_create, gdb reports "Program received signal ?, Unknown
signal".  This is with gdb 4.17.0.6-1.  gdb 4.17 should be able to
handle threads - atleast it does on Intel.  My glibc is 2.0.112.1.  I
was able to reproduce this with a trivial program that does absolutely
nothing but call pthread_create.

On Intel, pthreads library uses SIGUSR1 and SIGUSR2 internally.  My
guess is that on PowerPC some other signals are being used, but gdb does
not know about this.  Is this correct?  Is this a known problem
(hopefully with a known fix?)  I was hoping that pthreads would be
working in R5 but it looks like there is a little bit of work left to
do...

TIA,
Mike

-- 
Mike Lockwood
lockwood@pixo.com

You learn something new every day.
Today I learned that gerbils love tea bags.
--

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
