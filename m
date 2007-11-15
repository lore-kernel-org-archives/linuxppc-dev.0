Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id D09F8DDDE6
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 13:34:47 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so497052wag
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 18:34:46 -0800 (PST)
Message-ID: <9e4733910711141834n2bfb1742v5637c56e27e26f5a@mail.gmail.com>
Date: Wed, 14 Nov 2007 21:34:45 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jerry Van Baren" <gvb.linuxppc.dev@gmail.com>
Subject: Re: Hardware debuggers for PPC74xx G4 CPUs
In-Reply-To: <473BA278.2000402@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071113214845.85820@gmx.net>
	<fa686aa40711131357r6b072f4cgcd43c5cb8e73abdb@mail.gmail.com>
	<fa686aa40711131359l43f289e7j48b0df3ff57ea7c7@mail.gmail.com>
	<FA44C867-4933-40F2-8EBA-5C9967005223@embeddedalley.com>
	<20071113233906.GA32689@lixom.net>
	<9e4733910711131553ked87330ubc0c439c42e51ace@mail.gmail.com>
	<1195003078.28865.18.camel@pasglop>
	<9e4733910711131732i5ec5d226r4037e42399c38f59@mail.gmail.com>
	<473BA278.2000402@gmail.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/14/07, Jerry Van Baren <gvb.linuxppc.dev@gmail.com> wrote:
> Jon Smirl wrote:
> > On 11/13/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >>> That's why Dominic wants to get OpenOCD running on the PowerPC. All we
> >>> need is the programming documentation for controlling the CPU via the
> >>> debug hardware.
> >> Note that this is basically different for every CPU around.
> >
> > I'd like to get it for the MPC5200 because of the project I am working
> > on, an open source audio device. It would be nice if there was a cheap
> > hardware debugger available for hackers to use on it. Maybe one of the
> > Freescale developers will see this and send me the right docs.
> >
> > Is it radically different? Dominic has been able to support every ARM
> > 7/9 chip he can get his hands on without too much trouble once the
> > core support was written. I don't think he has ARM 11 working yet.
> >
> >>> Obviously this documentation exist, all of the commercial vendors had
> >>> to have it to develop their debuggers. Maybe it is already out there
> >>> and we just don't know where to look.
> >> Ben.
>
> DISCLAIMER: Extrapolating grossly from almost no knowledge!
>
> My understanding is that the Freescale PPC debugger interface is based
> on the JTAG interface using a proprietary command set.  Basically, if
> you do their magic BDM (JTAG extension) command, you get into an
> internal scan chain that allows you to read/write the processor
> internals (registers).
>
> The problems are many...
> * The documentation is only available under NDA, a problem for open
> source debuggers.

This is what we need. I would like it specifically for the mpc5200.
But we want to use it in OpenOCD so NDA won't work.

> * The scan chain is different on every processor, and may be different
> on different revisions of the same processor.

Hopefully the doc will cover this.

> * If you mess up with JTAG, you will probably burn up the CPU.  Very
> literally.  I've seen it done.  Twice.  (Thankfully not my screwup, and
> it wasn't a PPC so it deserved to die. ;-)  The internal scan chain is
> probably safer, but YMMV.

Dominic is way experienced implementing JTAG for ARM CPUs. He has done
several dozen interfaces. ARM doesn't have any problems releasing
their debugging info.

I've also lined up a mpc5200 development board vendor who wants a
cheap mpc5200 JTAG too and is willing to supply him with target
hardware.

JTAG hardware would be something similar to this:
http://www.amontec.com/jtagkey-tiny.shtml
So $30-40 for hardware with free OpenOCD software and you have JTAG
for the mpc5200.
This puts it in the range of classroom use.

The few embedded classes I've been around lately are being taught on
ARM hardware because it is so cheap. Development boards and the JTAG
can be had for under $100.

For example check out this store, it carries hundreds of ARM products
and almost no PowerPC ones.
http://microcontrollershop.com


-- 
Jon Smirl
jonsmirl@gmail.com
