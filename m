To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        LinuxPPC List <linuxppc-user@lists.linuxppc.org>
Subject: Re: G3 Upgrade Questions....
References: <Pine.LNX.4.10.9907291349260.10509-100000@mercator.cs.kuleuven.ac.be>
From: Andreas Bogk <andreas@andreas.org>
Date: 29 Jul 1999 15:30:04 +0200
In-Reply-To: Geert Uytterhoeven's message of "Thu, 29 Jul 1999 13:50:03 +0200 (CEST)"
Message-Id: <m3vhb37fdv.fsf@soma.andreas.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be> writes:

> Since the 750 is derived from the 603e, it scores 1 bogomips per MHz. The 604e
> does 2 bogomips per MHz.

This contradicts my readings:

processor       : 0
cpu             : 750
temperature     : 67 C
clock           : 297MHz
revision        : 2.2
bogomips        : 599.65
zero pages      : total 0 (0Kb) current: 0 (0Kb) hits: 0/688 (0%)
machine         : PowerBook
motherboard     : AAPL,PowerBook1998 MacRISC
L2 cache        : 1024K unified pipelined-syncro-burst
memory          : 192MB

But I wouldn't be surprised if the second level cache would influence
the BogoMIPS value by a factor of two.

Andreas

-- 
"We show that all proposed quantum bit commitment schemes are insecure because
the sender, Alice, can almost always cheat successfully by using an
Einstein-Podolsky-Rosen type of attack and delaying her measurement until she
opens her commitment." ( http://xxx.lanl.gov/abs/quant-ph/9603004 )

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
