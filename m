Date: Sun, 01 Apr 2001 12:02:53 +0100
Subject: Re: Sound stoppage
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: "Michael R. Zucca" <mrz5149@acm.org>,
	linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010401110310.A98CEDBA31@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> I'm hacking on a 2.2 snapshot at the moment (yes, yes, I'll get 2.4 as soon
> as I can!) :-)

2.2.x is ***broken*** in dmasound dbdma - (even with my last patch)... the
is a memory allocation bug in the dbdma cmd buffs.

so - all bets are off about what might happen ;-)

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
