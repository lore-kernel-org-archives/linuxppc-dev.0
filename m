Message-ID: <3AA85AB9.524A49AE@mvista.com>
Date: Thu, 08 Mar 2001 23:23:21 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: David Schleef <ds@schleef.org>
Cc: Oliver Brown <obrown@adventnetworks.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: EST SBC8260 and Canary CTX-1170
References: <CD5CA14300A9D54A8D13D58CD3C87B422DD729@advcorp-exc01.advent.com> <3AA82575.D6C1CAF2@mvista.com> <20010308190734.A7116@stm.lbl.gov>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Schleef wrote:

> .... but there is an errata about this problem.
> I'm about halfway through a fix for this.

That should have been checked in long ago....maybe I messed up
and only put it into one of the kernel trees.  I'll check into it.

My plan with the MII control/status was to utilize the new
configurable PHY support that several people contributed to
the MPC8xx FEC driver.  Two problems occurred.  One is that it
just took too long to develop, and the second is it relied on
the async/interrupt capability of the FEC.  It will get there
for the 8260...


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
