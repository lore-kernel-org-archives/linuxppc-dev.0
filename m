Message-ID: <392C5713.1C921311@embeddededge.com>
Date: Wed, 24 May 2000 18:26:27 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Neil Russell <caret@c-side.com>
CC: diekema_jon <diekema@bucks.si.com>, all@cideas.com,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Floating Point problems with Linux on the EST SBC8260
References: <20000524134257.A9100@lx.c-side.com> <m12uikI-001SyaC@bucks> <20000524150506.D9100@lx.c-side.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Neil Russell wrote:

> I'm part way getting the SCC ethernet to work and fixing the way I do
> bootinfo.  I'll look to making a patch after that (hopefully within a
> week).

You should be able to lift the driver from the 2.3.99 kernel and make
a couple of minor modifications.  There are just a couple of obvious
places where the kernel/driver interface changes (synchronization points),
and then add the 8260 interrupt and cache snooping changes.  It may be
easier to take the 8xx enet.c driver from 2.2.13 and apply 8260 changes.

Are you using SMC1 for the console?  Is this a custom board?

> I compile the kernel native on that machine.  All applications that I
> use are directly from that CD.

This is subtle but important.  Using a consistent set of tools,
libraries, and applications makes life much easier.

Do you want any of the work patched into 2.2.15 or 2.3.99?


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
