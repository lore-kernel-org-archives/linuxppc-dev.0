Subject: Re: MPC8560ADS issues
From: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
To: Dan Malek <dan@embeddededge.com>
Cc: Jason McMullan <jason.mcmullan@timesys.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <405090F3.1000900@embeddededge.com>
References: <1078945499.3748.4.camel@veena.timesys>
	 <1079019785.29565.36.camel@chuck.arlut.utexas.edu>
	 <405090F3.1000900@embeddededge.com>
Content-Type: text/plain
Message-Id: <1079025268.29565.51.camel@chuck.arlut.utexas.edu>
Mime-Version: 1.0
Date: Thu, 11 Mar 2004 11:14:29 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-03-11 at 10:16, Dan Malek wrote:

> Do you keep up to date with the linuxppc trees?  Some of us have been
> pushing lots of CPM updates lately.  We recently updated all of the
> common code for 82xx and 85xx.  If this doesn't work there must be
> some I/O or board configuration that is amiss.

I'm running the latest linuxppc-2.4 branch. I'm not using the MPC8540ADS
board, the board I am using has an Intel LXT971A PHY attached to the
FCC. I've added support for that physical layer to
drivers/gianfar_phys.c. I'm guessing something is wrong with that code
that is making it go so slow, but I have been unable to pinpoint what
might be wrong.

I've noticed that the interrupts for the FCC come in at a very very slow
pace, that is the only thing I have really noticed that is odd. I've
also tried changing the priority of the interrupt via the IIVPR register
for the FCC with no results. I can't think of anything else I can
investigate, unless you have any ideas?

Thanks,
Matthew

--
Matthew S. McClintock <mattsm@arlut.utexas.edu>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
