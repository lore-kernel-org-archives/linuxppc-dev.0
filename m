Message-ID: <38E88948.DE0DB79B@sgi.com>
Date: Mon, 03 Apr 2000 07:06:32 -0500
From: Steven Hein <ssh@sgi.com>
MIME-Version: 1.0
To: dan@netx4.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc.kernel.org problems
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

(My apologies if I'm not reading this right......)

I just updated from BitKeeper this morning, and I'm still seeing
problems.....

- in arch/ppc/8xx_io/uart.c the version says 0.02, where the version
  in the HardHat tree is 0.03

- the arch/ppc/8xx_io/fec.c still won't compile for me; it is trying to
  reference the field 'tbusy' in struct net_device, and there is no
  'tbusy' field in net_device (looks like this still coresponds to the
  older 'struct device', which did have a 'tbusy' field.....)

Thanks,
Steve


Dan Malek wrote:
>
> I am working on the 2.3.xx kernel right now.  There have been lots of
> generic changes that need integration for 8xx.  Keep looking at the
> tree over the next few days, it should come together.
>
> > I have BitKeeper access and I grabbed the latest Linux/PPC kernel tree,
> > but it doesn't have updated FEC or UART drivers in arch/ppc/8xx_io,
>
> That should have all been there last week......
>
>
>         -- Dan


--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Steve Hein (ssh@sgi.com)              Engineering Diagnostics/Software
Silicon Graphics, Inc.
1050 Lowater Road                     Phone: (715) 726-8410
Chippewa Falls, WI 54729              Fax:   (715) 726-6715
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
