To: linuxppc-dev@lists.linuxppc.org
Subject: Time on the MVME2700
Reply-To: minyard@acm.org
From: Corey Minyard <minyard@acm.org>
Date: 08 Dec 1998 21:50:44 -0600
Message-ID: <m267bmc6sr.fsf@wf-rch.cirr.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have Linux 2.1.127 running on a Motorola MVME2700 (750 processor).
It's working fine except for timekeeping.  It gains about 1.5 seconds
every 30 minutes, making time synchronization rather difficult.  It is
calculating the decrementer frequency value as around 998,736,000 (I
removed the hard coding of 998,700,000 that was in there to see what
happened.  The difference between the two is not significant).
However, by my calculations the frequency should be about
1,000,000,000.  This is all in arch/ppc/kernel/time.c.

I'm going to hard-code it to that value to see what happens, but has
anyone else seen this?  Unfortunately, I don't remember the processor
frequency offhand and I'm at home now.

-- 
Corey Minyard               Internet:  minyard@acm.org
  Work: minyard@nortel.ca       UUCP:  minyard@wf-rch.cirr.com

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
