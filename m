From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15282.31220.632378.644634@cargo.ozlabs.ibm.com>
Date: Thu, 27 Sep 2001 10:59:32 +1000 (EST)
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Adding 'bus_offset' to pci_controller
In-Reply-To: <3BB264BC.8E7291FE@mvista.com>
References: <3BB24A6B.BADCF16E@mvista.com>
	<15282.23932.770208.130313@cargo.ozlabs.ibm.com>
	<3BB2639D.A44BCA16@mvista.com>
	<3BB264BC.8E7291FE@mvista.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark A. Greer writes:

> Wait, I can't b/c then *everyone* will have this subtraction happen and
> everyone but me would be broken.
> With a separate field, I don't mess up other  board ports.

Well, how many other boards are there out there that use
indirect_pci.c and have more than one host bridge?  Anyone?

> Another way to go would be to #ifdef your suggestion into indirect_pci.c
> for my board only.
> Which do you prefer?

Not the ifdef. :)  Either make your own version of the indirect_pci
routines or add the field.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
