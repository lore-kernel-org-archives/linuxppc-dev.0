Date: Wed, 26 Mar 2003 10:45:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: i2c-algo-8xx ???
Message-ID: <20030326174509.GA22018@ip68-0-152-218.tc.ph.cox.net>
References: <3E801F80.2000305@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E801F80.2000305@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Mar 25, 2003 at 10:21:04AM +0100, Steven Scholz wrote:

> Hi there,
>
> if I understand correctly:
>
> if one want to use i2c-algo-8xx on a MPC8xx one need to init the CPM,
> install
>  an irq handler and add an i2c bus handler.
> That all is done in i2c-rpx.c. But I think what's done there is pretty
> generic
> to MPC8xx boards using the CPM for I2C.
> (I just forced a build of this file and it works on my board.)
>
> So shouldn't we rename the file and the entry in Config.in to something less
> "misleading" ?

I2C on the 8xx, in terms of the existing code, is a bit of a mess.  In
short, yes, it should, and I must kick myself for not moving a verion of
the code which does that already out.  I've stuck it at the top of my
list, so I'll try and get to it this week.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
