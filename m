Message-Id: <199902160628.OAA02962@mule.wantree.com.au>
Subject: PPC 601 issues (was Re: bootstrap stuffs)
Date: Tue, 16 Feb 1999 17:00:49 +1030
From: Keith Jacob <kjacob@wantree.com.au>
To: <Paul.Mackerras@cs.anu.edu.au>,
        "linuxppc-dev list" <linuxppc-dev@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote

>Sync and isync turn out to be needed on some revs of some chips
>(particularly the 601) around rfi and mtmsr instructions.
>
>(In fact the 601 seems to have another weird bug - in the hash_page
>routine in head.S, the location of the rfi instruction w.r.t. cache
>lines appears to be critical on the 601; if it's wrong, you get a
>machine check on the rfi instruction.  At one stage I found that with
>2, 3, 6, or 7 nops added, it would work; with 0, 1, 4 or 5 nops added
>it wouldn't. :-)
>
>Paul.

Does that explain the recent problems with nearly all kernels on 7200s? 
Someone posted a patch (to head.S) for 2.2, but 2.2.1 from samba doesn't 
boot either without patching, AFAIK. Things were fine until about 2.1.130.

Would it be possible for 7200 patches to be released (on samba?) with 
each kernel release? I believe there are quite a few 7200s running Linux 
(maybe 20 or so by active list subscribers), and they make great little 
servers, so it would be sad to see them left behind.

--
Keith Jacob
kjacob@wantree.com.au




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
