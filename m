Date: Thu, 16 Oct 2003 16:11:38 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: Problem of concurrency in arch/ppc/8260_io/uart.c
In-reply-to: <3F8E8817.5ACD7ACB@siemens.com>
To: Agostino Sette ICN-CNX-RD-SW3 <Agostino.Sette@siemens.com>
Cc: Jean-Denis Boyer <jdboyer@m5t.com>,
	Steffen Rumler <Steffen.Rumler@siemens.com>,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLMEGNGAAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I had a similar problem on my_console_write. Here I wite down two version of the code, the first one is the old
> and the second one is the new with the modification. As you can see, there was a spin_unlock without a spink_lock
> ;this hangs the startup in calibration loop.

Agostino,
check out the new 8xx_io/uart.c in BK. I wrote a patch that fixes the locking problems
but minimizes the lock time.

   Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
