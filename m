Message-Id: <199901190430.MAA01225@mule.wantree.com.au>
Subject: 15 partitions max prob revisited
Date: Tue, 19 Jan 1999 15:00:04 -0000
From: Keith Jacob <kjacob@wantree.com.au>
To: "linuxppc-user list" <linuxppc-user@lists.linuxppc.org>,
        "linuxppc-dev list" <linuxppc-dev@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


When I first tried to install R4 (on a 7200/75) I ran into the prob of 
having too many partitions on my HD. Since I only use HFS (not HFS+), I 
partitioned my new 4GB drive into 8 Mac partitions (==max allowed by 
Drive Setup) totalling 2GB, and left the last 2GB for Linux. However, 
Linux would only allow me another 3 ext2 partitions, totalling 15 all up 
(4 Mac driver/patch &c., 8 HFS, and 3 ext2).

So the question is: can I add more devices (e.g. sdb16, sdb17, ...), or 
do I need to "reclaim" some HFS partitions if I want more ext2 ones? BTW, 
it was the installer that choked on the extra partitions I had created, 
so I would need to know how to fix that as well (if possible).

I'm sure this is not a Powermac/Linux prob, per se, but perhaps others 
have had this problem and found a neat fix for it (although HFS+ is not a 
solution for me until the Mac HFS+ disk tools improve).

Thanks in advance for any suggestions.

--
Keith Jacob
kjacob@wantree.com.au




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
