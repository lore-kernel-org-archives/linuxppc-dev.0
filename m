In-Reply-To: <Pine.LNX.3.96.990216232757.32682C-100000@persephone.cs.nmt.edu>
Date: Wed, 17 Feb 1999 17:32:33 +0100
To: Cort Dougan <cort@persephone.cs.nmt.edu>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Restructuring Efforts
Message-Id: <19990217173233.029089@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 16, 1999, Cort Dougan <cort@persephone.cs.nmt.edu> wrote:

>With metered (and well behaved :) changes going into a linux/ppc cvs tree
>I think that wouldn't be a problem.  So I can get a handle on the scope of
>things, how many people would want r/w access to a linux/ppc cvs tree?

I would prefer that rather than one on vger. Many parts of Linux are
still really obscure to me and I'm really afraid of breaking things. I
prefer having to deal with two trees: an "official" one with qualified
patches than can be tested by users and that will ultimately go to Linus,
and a "developement" tree containing more cutting-edge stuffs.

However, the problem that will quickly come from that is the difficulty
to merge changes from the dev tree to vger, at least until 2.3.x is split.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
