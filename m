Date: Mon, 7 Jul 2003 15:16:22 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: Paul Mackerras <paulus@samba.org>,
	"Linuxppc-Dev@Lists. Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: memmove broken
Message-ID: <20030707131622.GD7104@wohnheim.fh-wedel.de>
References: <16133.19178.764449.966821@cargo.ozlabs.ibm.com> <IGEFJKJNHJDCBKALBJLLOEPGFNAA.joakim.tjernlund@lumentis.se> <16134.4102.899233.25492@cargo.ozlabs.ibm.com> <20030705072119.GA32363@wohnheim.fh-wedel.de> <16134.52251.943207.814024@cargo.ozlabs.ibm.com> <20030705170145.GA29928@wohnheim.fh-wedel.de> <003301c34473$0f88d7a0$020120b0@jockeXP> <20030707120606.GC7104@wohnheim.fh-wedel.de> <005501c34487$7bcafc40$020120b0@jockeXP>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <005501c34487$7bcafc40$020120b0@jockeXP>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 7 July 2003 14:58:33 +0200, Joakim Tjernlund wrote:
> >
> > This patch doesn't fix anything that is wrong, and it doesn't add
> > functionality that isn't there right now.
>
> Nor does most of you zlib patches either, but most of them are in 2.5.
> Point being, this is not a major change(so far). If nothing wrong is found and
> it is noticeably faster, I think it should go into 2.5.

Point taken.  If tests and benchmarks agree, it should go in.

Jörn

--
A defeated army first battles and then seeks victory.
-- Sun Tzu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
