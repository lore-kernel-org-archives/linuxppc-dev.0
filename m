Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Message-Id: <v04103d00b2f3c9868068@[208.150.38.73]>
Date: Fri, 19 Feb 1999 20:17:41 -0600
To: linuxppc-dev@lists.linuxppc.org
From: Steven Bytnar <s-bytnar@uiuc.edu>
Subject: PPC Privileged mode
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


How do I exit cleanly from PPC supervisor mode to MacOS? I am trying 
to work with the code in BootX, but it was meant to execute the 
kernel and never return. My purpose is only to read and write to 
supervisor read/writable registers on the chip without destroying 
MacOS.

Thank you,
--Steve

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
