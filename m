Message-ID: <E380A44D523BD5118EAE0002A52CE5C40B9A0601@zcard0k8.ca.nortel.com>
From: "Andrew Williams" <awilliam@nortelnetworks.com>
To: "linuxppc-embedded@lists.linuxppc" <linuxppc-embedded@lists.linuxppc.org>
Subject: Spurious Interrupts.. 2.4.22 82xx platforms
Date: Sun, 2 May 2004 11:02:42 -0400 
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Trying to wrap my mind around where my "spurrious" interrupts
are coming from.

I've used some debug code to determine where the spurrious
counter was being incremented, in an attempt to see the
what/how/why. All occurences are a result of m8260_get_irq()
returning -1 (empty SIVEC register).

Ideas or pointers as to what might be occuring here?
We're using an 8270.

Can anyone reference a paper/chat/email that details the nature
of the SIVEC/SPINRx solution in linux?


Thanks
Andrew

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
