Date: Wed, 24 Feb 1999 15:39:40 -0500
From: Mayan Moudgill <mayan@watson.ibm.com>
Message-Id: <9902242039.AA29018@mayan.watson.ibm.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: ramdisks, anyone?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I am trying to build a small initrd, with a linuxrc that does something.
Does somebody have such a ramdisk.image available?
Or even some suggestions on what to do?

I started off by trying to make bash my /linuxrc. Bash
required ld.so.1, which required libc.so.2, etc....

This occupied more the 4MB. At that point the /dev/ram on the
machine I was building the ramdisk started giving problems -
If I built a bigger /dev/ram, after umount, dd would only
read the first 4MB.  is there something magical about 4M for ramdisks?

So I'm stuck..............

HELP!!!!!!!

:)
Mayan

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
