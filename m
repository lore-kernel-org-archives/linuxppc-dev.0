Message-ID: <005501c34487$7bcafc40$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "J?rn Engel" <joern@wohnheim.fh-wedel.de>
Cc: "Paul Mackerras" <paulus@samba.org>,
	"Linuxppc-Dev@Lists. Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
References: <16133.19178.764449.966821@cargo.ozlabs.ibm.com> <IGEFJKJNHJDCBKALBJLLOEPGFNAA.joakim.tjernlund@lumentis.se> <16134.4102.899233.25492@cargo.ozlabs.ibm.com> <20030705072119.GA32363@wohnheim.fh-wedel.de> <16134.52251.943207.814024@cargo.ozlabs.ibm.com> <20030705170145.GA29928@wohnheim.fh-wedel.de> <003301c34473$0f88d7a0$020120b0@jockeXP> <20030707120606.GC7104@wohnheim.fh-wedel.de>
Subject: Re: memmove broken
Date: Mon, 7 Jul 2003 14:58:33 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Mon, 7 July 2003 12:32:21 +0200, Joakim Tjernlund wrote:
> >
> > > Agreed.  And even then, I don't want to submit it before 2.7.
> >
> > Why? Just look at 2.4 and you will find much boulder stuff going
> > in there than this.
>
> Other people's bad example is no justification for my misbehaviour. ;)
>
> This patch doesn't fix anything that is wrong, and it doesn't add
> functionality that isn't there right now.
[SNIP]

Nor does most of you zlib patches either, but most of them are in 2.5.
Point being, this is not a major change(so far). If nothing wrong is found and
it is noticeably faster, I think it should go into 2.5.

 Jocke

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
