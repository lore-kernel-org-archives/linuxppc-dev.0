Message-ID: <20030618052659.73166.qmail@web10506.mail.yahoo.com>
Date: Wed, 18 Jun 2003 06:26:59 +0100 (BST)
From: =?iso-8859-1?q?jayan=20jacob?= <jayanjacob@yahoo.com>
Subject: kgdb for ppc8260 linux-2.4.2
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
  I am trying to get the kgdb working for linux-2.4.2
on a ppc8260 board. I got the error "undefined
reference to functions putDebugChar, getDebugChar and
kgdb_interruptible" while compiling the kernel.

  In the case of 8xx, these functions are defined in
the file 8xx_io/uart.c. I suppose it is not ported for
8260. Where can I get the ported uart.c code for 8260?

 The changes needed looks simple, but I don't want to
waste time if it is already available elsewhere.
 If I have to port it, I would appreciate some
pointers or cautions for possible pitfalls?

Thanks,
Jayan Jacob



________________________________________________________________________
Want to chat instantly with your online friends?  Get the FREE Yahoo!
Messenger http://uk.messenger.yahoo.com/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
