Message-ID: <20000524160640.E9100@lx.c-side.com>
Date: Wed, 24 May 2000 16:06:40 -0700
From: Neil Russell <caret@c-side.com>
To: Dan Malek <dan@netx4.com>
Cc: diekema_jon <diekema@bucks.si.com>, all@cideas.com,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Floating Point problems with Linux on the EST SBC8260
References: <20000524134257.A9100@lx.c-side.com> <m12uikI-001SyaC@bucks> <20000524150506.D9100@lx.c-side.com> <392C5713.1C921311@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <392C5713.1C921311@embeddededge.com>; from Dan Malek on Wed, May 24, 2000 at 06:26:27PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 24, 2000 at 06:26:27PM -0400, Dan Malek wrote:
> You should be able to lift the driver from the 2.3.99 kernel and make
> a couple of minor modifications.  There are just a couple of obvious
> places where the kernel/driver interface changes (synchronization points),
> and then add the 8260 interrupt and cache snooping changes.  It may be
> easier to take the 8xx enet.c driver from 2.2.13 and apply 8260 changes.

I'm taking the 2.2 version and going from there, as I did with the SMC driver.

> Are you using SMC1 for the console?  Is this a custom board?

console = SMC1.  First ported to SBC8260 (EST board), then to custom h/w.
The custom h/w has an IDE interface;  I hope to get the whole linux-1999 Q3
working on it;  that should be interesting.

> Do you want any of the work patched into 2.2.15 or 2.3.99?

Sure!  It might be a few weeks though...


Neil.

--
Neil Russell <caret@c-side.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
