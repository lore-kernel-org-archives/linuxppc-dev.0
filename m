From: Brad Boyer <flar@cegt201.bradley.edu>
Message-Id: <199901191033.EAA19277@cegt201.bradley.edu>
Subject: Re: 15 partitions max prob revisited
To: kjacob@wantree.com.au (Keith Jacob)
Date: Tue, 19 Jan 1999 04:33:38 -0600 (CST)
Cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <199901190430.MAA01225@mule.wantree.com.au> from "Keith Jacob" at Jan 19, 99 03:00:04 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> So the question is: can I add more devices (e.g. sdb16, sdb17, ...), or 
> do I need to "reclaim" some HFS partitions if I want more ext2 ones? BTW, 
> it was the installer that choked on the extra partitions I had created, 
> so I would need to know how to fix that as well (if possible).
> 
> I'm sure this is not a Powermac/Linux prob, per se, but perhaps others 
> have had this problem and found a neat fix for it (although HFS+ is not a 
> solution for me until the Mac HFS+ disk tools improve).

No, this is a Linux problem.  You cannot have more than 15 partitions
on a drive because there are not device numbers allocated for anything
higher than partition number 15.  So even if you create a partion 16,
there is no way to access it under Linux.  This is the way that the
device numbers were allocated.  As far as I know, there isn't a
reasonable way to change this either.  Sorry I have to be the bearer
of bad news, but that's the way things currently stand.

       Brad Boyer
       flar@cegt201.bradley.edu

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
