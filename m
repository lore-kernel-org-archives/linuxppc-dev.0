Message-ID: <3F74BBC5.3010302@embeddededge.com>
Date: Fri, 26 Sep 2003 18:20:53 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	Jean-Denis Boyer <jdboyer@m5t.com>,
	Steffen Rumler <Steffen.Rumler@siemens.com>,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem of concurrency in arch/ppc/8260_io/uart.c
References: <IGEFJKJNHJDCBKALBJLLEEGCFPAA.joakim.tjernlund@lumentis.se> <IGEFJKJNHJDCBKALBJLLGEGDFPAA.joakim.tjernlund@lumentis.se> <20030926212410.GB8927@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> KGDB still works for me.  Dan, any final thoughts / comments /
> objections?

In the last patch I saw, we are blocking interrupts for quite a while,
across a copy_from_user(), in 8xx_write().  This can cause large
interrupt latencies due to page faults, it would be nice if could fix that.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
