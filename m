Date: Tue, 25 Mar 2003 18:37:55 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: dcbz works on 862 everywhere!
In-reply-to: <005201c2f271$e1e199c0$020120b0@jockeXP>
To: Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>,
	strauman@SLAC.Stanford.EDU
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLAEHCFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > For a long time, we "solved" these problems on 8xx by not properly
> > implementing copy-on-write pages and always marking pages dirty.
> > It reduced the likelyhood of the problem, reduced the MMU overhead,
> > but cost lots more in memory and processing time during forks.
> > This still may not be a bad configuration option for selected
> > applications.
>
> Is it easy to patch/hard code? I would like to test the stability of my system.

I am still intrested in trying copy-on-write but I can't figure out
how. Is it a big job? Any pointers?

  Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
