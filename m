Message-ID: <005d01c43134$b2c19cf0$0301a8c0@chuck2>
From: "Mark Chambers" <mwchambers@citlink.net>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <20040503153304.34906C109F@atlas.denx.de>
Subject: Re: Motorola 5200 MIPS 
Date: Mon, 3 May 2004 13:33:06 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Then go back and read the archives. This has been  discussed  several
> times before.
>

An excellent idea.  Why didn't I think of that?  And to all of you fellow
nerds back there who also like to know how things work and why - bless your
heart.  Actually, I don't fully follow the explanations, but clearly the 603
core is not able to execute a single looped dbnz once per clock, so 263
BogoMIPS is a reasonable number for a 396MHz 5200.  The number does not have
anything to do with bus speed, which is part of what was bothering me (2 x
132MHz, you know).  I won't pester you all with this any more but if anybody
else wants to discuss further I'd welcome your emails  (not discuss BogoMIPS
necessarily, but details of 5200 performance - I've got some very
challenging requirements to hit and any insights will be welcome).

Mark Chambers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
