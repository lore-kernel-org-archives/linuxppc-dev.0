Message-ID: <20000524201743.A8680@lx.c-side.com>
Date: Wed, 24 May 2000 20:17:43 -0700
From: Neil Russell <caret@c-side.com>
To: Dan Malek <dan@netx4.com>
Cc: diekema_jon <diekema@bucks.si.com>, all@cideas.com,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Floating Point problems with Linux on the EST SBC8260
References: <20000524134257.A9100@lx.c-side.com> <m12uikI-001SyaC@bucks> <20000524150506.D9100@lx.c-side.com> <392C5713.1C921311@embeddededge.com> <20000524160640.E9100@lx.c-side.com> <392C8042.EB65AAF6@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <392C8042.EB65AAF6@embeddededge.com>; from Dan Malek on Wed, May 24, 2000 at 09:22:10PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We have an FPGA that implements part of the ISA spec, enough to do
programmed I/O to an IDE device.  The FPGA has its own chip select and uses
the UPM for timing.  It doesn't work correctly yet because what the 8260
documentation says and what the 8260 does are different.  When it works,
it will be slow, but we probably don't care - we are not building a
file server.

I'm not sure that we care enough to redesign the logic to make it fast,
but I do care that it doesn't slow everything else down, so at some point
I plan to look to using some form of DMA; perhaps the SDMA that the CPM
provides.  It will probably still be slow, but he CPU will no longer be
held up.

Got any better ideas?  (no PCI, no expensive chips...).


Neil.


On Wed, May 24, 2000 at 09:22:10PM -0400, Dan Malek wrote:
> > console = SMC1.  First ported to SBC8260 (EST board), then to custom h/w.
> > The custom h/w has an IDE interface;  I hope to get the whole linux-1999 Q3
> > working on it;  that should be interesting.
>
> Oh oh.....You opened the flood gates for questions now :-).  How did
> you connect the IDE?

--
Neil Russell <caret@c-side.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
