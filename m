Message-Id: <199902090234.TAA26936@mx0-smtp.goodnet.com>
Date: Mon, 08 Feb 1999 19:34:56 -0700
Subject: L2CR
From: "Kyle Nesbit" <kyle.nesbit@asu.edu>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I am currently looking for some more info on how to get my L2 backside cache
running.  I am using a powerlogix card.

I have used the powerlogix/Ben patch posted in the mailing list during Dec.
The kernel compiled without and error.  When I try to pass the l2cr kernel
argument I get nothing.  my /proc/sys/kernel/l2cr is 00000000: disabled,
etc...

Another thing that is strange is in /proc/cpuinfo the clock rate of my chip
is off by over 100 MHZ.

I would greatly appreciate if someone could point me to more info on the
subject.

Thanx,
Kyle

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
