Message-ID: <392CA1D7.17D475CD@embeddededge.com>
Date: Wed, 24 May 2000 23:45:27 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Neil Russell <caret@c-side.com>
CC: Dan Malek <dan@netx4.com>, diekema_jon <diekema@bucks.si.com>,
        all@cideas.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Floating Point problems with Linux on the EST SBC8260
References: <20000524134257.A9100@lx.c-side.com> <m12uikI-001SyaC@bucks> <20000524150506.D9100@lx.c-side.com> <392C5713.1C921311@embeddededge.com> <20000524160640.E9100@lx.c-side.com> <392C8042.EB65AAF6@embeddededge.com> <20000524201743.A8680@lx.c-side.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Neil Russell wrote:

> We have an FPGA that implements part of the ISA spec, enough to do
> programmed I/O to an IDE device.  The FPGA has its own chip select and uses
> the UPM for timing.


Interesting....I have used an FPGA or the UPM to provide the ISA
bus timing, but not both at the same time.  I have UPM programming
for the 8xx that creates ISA bus timing, so I guess I could try that
on the 8260 as well.....I think it needs an external signal inversion,
but that is all.

> .........  When it works,
> it will be slow, but we probably don't care - we are not building a
> file server.

Hmmmm....I'll bet it can be made to work with compact flash as well....

> ....  It will probably still be slow, but he CPU will no longer be
> held up.

Depending upon the data flow, they may still share a common internal
bus....Plus you tie up the CPM.

> Got any better ideas?  (no PCI, no expensive chips...).

I just gave it away, and I have another project on the pile :-).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
