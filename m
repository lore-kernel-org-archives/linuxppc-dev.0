Date: Mon, 7 Jul 2003 14:06:06 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: Paul Mackerras <paulus@samba.org>,
	"Linuxppc-Dev@Lists. Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: memmove broken
Message-ID: <20030707120606.GC7104@wohnheim.fh-wedel.de>
References: <16133.19178.764449.966821@cargo.ozlabs.ibm.com> <IGEFJKJNHJDCBKALBJLLOEPGFNAA.joakim.tjernlund@lumentis.se> <16134.4102.899233.25492@cargo.ozlabs.ibm.com> <20030705072119.GA32363@wohnheim.fh-wedel.de> <16134.52251.943207.814024@cargo.ozlabs.ibm.com> <20030705170145.GA29928@wohnheim.fh-wedel.de> <003301c34473$0f88d7a0$020120b0@jockeXP>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <003301c34473$0f88d7a0$020120b0@jockeXP>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 7 July 2003 12:32:21 +0200, Joakim Tjernlund wrote:
>
> > Agreed.  And even then, I don't want to submit it before 2.7.
>
> Why? Just look at 2.4 and you will find much boulder stuff going
> in there than this.

Other people's bad example is no justification for my misbehaviour. ;)

This patch doesn't fix anything that is wrong, and it doesn't add
functionality that isn't there right now.  Performance is the least
important aspect of computing, unless it has an impact on
functionality as well. (audio without glitches and such)

Besides, Marcelo didn't even take my fixes for the zlib yet, so there
is more important stuff in the queue.

Jörn

--
Fancy algorithms are slow when n is small, and n is usually small.
Fancy algorithms have big constants. Until you know that n is
frequently going to be big, don't get fancy.
-- Rob Pike

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
