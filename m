Date: Sun, 21 Feb 1999 21:59:25 +1100
Message-Id: <199902211059.VAA01518@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: brad@pht.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.LNX.3.95.990220154008.23593A-100000@pacific.pht.com>
	(message from Brad Midgley on Sat, 20 Feb 1999 16:16:50 -0700 (MST))
Subject: Re: 601 vs head.S
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.3.95.990220154008.23593A-100000@pacific.pht.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brad Midgley <brad@pht.com> wrote:

> my quest is for a kernel that boots both on the 7200 and the imac. help me

Found it... had to take out the 2 nop's in hash_page this time.  Vger
(cvs) and samba (rsync) have the fix, if you want a precompiled
kernel, try ftp://ftp.linuxppc.org/linuxppc/kernel/powermac/test/vmlinux.

> out and i'll give you a free ppc601 card :)

No thanks, got one already. :)  Now if someone could send me one of
the quantum 1280S drives that are having fits, that could be useful.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
