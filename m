Date: Thu, 1 Apr 1999 13:35:41 -0700 (MST)
From: Brad Midgley <brad@pht.com>
Reply-To: Brad Midgley <brad@pht.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: a start at independent multihead
Message-ID: <Pine.LNX.3.95.990401133142.680A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi,

i have done some work as a proof of concept for independent multihead. it
appears that the details for things like keyboard/display assignment and
xdm configuration are satisfactory but the dispatch of keys is still wrong
in the kernel. i'm going to stand back and think about it for a bit
(grumble).

i wrote up a page that discusses my approach and includes source.

http://www.pht.com/~brad/patches/mhead/

Brad
brad@pht.com | http://www.pht.com/~brad/




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
