Date: Wed, 26 Sep 2001 14:54:30 -0700
From: Matt Porter <mporter@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Cc: "Mark A. Greer" <mgreer@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Adding 'bus_offset' to pci_controller
Message-ID: <20010926145429.B28204@cx258813-a.chnd1.az.home.com>
References: <3BB24A6B.BADCF16E@mvista.com> <15282.23932.770208.130313@cargo.ozlabs.ibm.com> <3BB2639D.A44BCA16@mvista.com> <3BB264BC.8E7291FE@mvista.com> <15282.31220.632378.644634@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15282.31220.632378.644634@cargo.ozlabs.ibm.com>; from paulus@samba.org on Thu, Sep 27, 2001 at 10:59:32AM +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 27, 2001 at 10:59:32AM +1000, Paul Mackerras wrote:
>
> Mark A. Greer writes:
>
> > Wait, I can't b/c then *everyone* will have this subtraction happen and
> > everyone but me would be broken.
> > With a separate field, I don't mess up other  board ports.
>
> Well, how many other boards are there out there that use
> indirect_pci.c and have more than one host bridge?  Anyone?

The CPC710 ports, K2 and Adirondack.  Soon to be a large number of
boards with GT64620 since it seems to be the high-end system
controller of choice for embedded 7xx/74xx these days and
everybody wants Linux.

> > Another way to go would be to #ifdef your suggestion into indirect_pci.c
> > for my board only.
> > Which do you prefer?
>
> Not the ifdef. :)  Either make your own version of the indirect_pci
> routines or add the field.

New field seems better than dupping 98% of indirect_pci, IMHO.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
