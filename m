Date: Wed, 20 Jan 1999 14:43:22 +1100
Message-Id: <199901200343.OAA02278@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: kjacob@wantree.com.au
CC: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
In-reply-to: <199901190430.MAA01225@mule.wantree.com.au> (message from Keith
	Jacob on Tue, 19 Jan 1999 15:00:04 -0000)
Subject: Re: 15 partitions max prob revisited
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <199901190430.MAA01225@mule.wantree.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Keith Jacob <kjacob@wantree.com.au> wrote:

> So the question is: can I add more devices (e.g. sdb16, sdb17, ...), or 
> do I need to "reclaim" some HFS partitions if I want more ext2 ones? BTW, 
> it was the installer that choked on the extra partitions I had created, 
> so I would need to know how to fix that as well (if possible).

The problem is in the encoding of the device minor number for scsi
disks: only 4 bits are allocated to the partition number, so you can
have at most 15 partitions (/dev/sdx uses partition number 0).

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
