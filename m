Message-ID: <3BBE7D81.6E0E64E3@mvista.com>
Date: Fri, 05 Oct 2001 23:41:53 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ricardo Scop <scop@digitel.com.br>
Cc: Andrew Johnson <anj@aps.anl.gov>,
	linuxppc-embedded@lists.linuxppc.org,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: BK to CVS? + MDIO
References: <20011003130559.F31866@borg.org> <01100519044401.01029@scop.digitel.com.br> <3BBE6B92.60497E1@mvista.com> <01100523524704.16297@scop.digitel.com.br>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ricardo Scop wrote:

> I can assure you that I intend to follow strictly your orders :^)

Yeah, orders......There are (too many :-) other cooks if you would
rather send your recipe to them :-).

> ...... Is that all right for
> obtaining the current sources?

Sure.

> BTW, I'm staring right now at the FCC driver for the MPC8260,

There have been lots of cooks there recently as well.  I think the MDIO
enable is an artifact of something that was added for the 8xx configuration.
I guess I better look at this driver again and see if I can remember how
it attained its current state.  The MDIO has always been a challenge on
the 8260.  It is usually software managed, and when it works for one PHY
it seems to be broken for another.  Basically, it works for the last
person that added a PHY :-).

> ..... and I would like to force it to 100 Mbps at
> user's will.

You are welcome to make it work :-).  I just let them autonegotiate the
highest performance and declare victory.  I'm sufficiently challenged
to just send bits......

Well that's interesting....I just discovered my tibook clock is set
incorrectly......sorry about that.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
