Message-ID: <B0010934149@mail.olg.com>
Date: Tue, 20 Jul 1999 22:33:58 -0400
Subject: imstt video question
From: "charlie buckheit" <buckheit@olg.com>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


OK, this horse is probably been long dead, but...

First, I have an Power Tower Pro w/ 8 meg IMSTT video card running Linuxppc
1999. I've successfully compiled and am using 2.2.10 kernel (OBTW the
turbomouse5 works great for me with no changes...). The colors are only
correct in 8 bit setting. 16 bit mode is yellow/red in color, 24 bit has
some colors correct, but others are way off. I've done a register dump and
compared to the code from IXMicro and previous driver code I wrote that
worked, and the card appears to be configured correctly. So my guess is that
this is an X issue. I've looked at XF86config and I don't have a clue. I
sort of remember getting a version way back from Geert that worked, but I
can't access his site these days. Anyway, does somebody have a XF86config
file that works with the IMSTT card? Thanks in advance.

VR, Charlie 

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
