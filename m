Date: Sun, 27 Jun 1999 20:58:50 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Troy Benjegerdes <hozer@drgw.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: sym53c8xx timeouts and aborts... egcs-1.1.2e problem??
In-Reply-To: <Pine.LNX.4.04.9906271940400.5764-100000@narn.local.drgw.net>
Message-ID: <Pine.LNX.4.05.9906272057130.20302-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 27 Jun 1999, Troy Benjegerdes wrote:

> Can anyone give me a success or failure report on an ncr/sym53c8xx board
> on a kernel compiled with egcs-1.1.2-12e?

Er.  I shoulda mentioned this on IRC I guess, but the Apple ncr53c8xx
cards (Beige G3 UW problem threads) are done with 12e and people haven't
had problems.  Which narrows it down to sym53c8xx.[ch] and egcs, yes?

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
