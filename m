To: linuxppc-dev@lists.linuxppc.org
Subject: SA_ONSTACK problems in the libraries.
Reply-To: minyard@acm.org
From: Corey Minyard <minyard@acm.org>
Date: 16 Jan 1999 02:07:10 -0600
Message-ID: <m2zp7j4p5d.fsf@wf-rch.cirr.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



It have added SA_ONSTACK support to the kernel (support for separate
signal stacks).  Some library fixes are required.  I have
glibc-961212-1m and it has the following problems:

   the /usr/include/signal.h has the ss_flag and ss_size parameters
   reversed in the sigaltstack structure (as opposed to
   /usr/include/asm/signal.h).

   SA_ONSTACK needed to be added to /usr/include/sigaction.h

   the sigaltstack() call just returns and error and doesn't do
   the library call.

Who fixes these types of problems, since they are PowerPC specific?

-- 
Corey Minyard               Internet:  minyard@acm.org
  Work: minyard@nortel.ca       UUCP:  minyard@wf-rch.cirr.com

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
