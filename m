Return-Path: <Rick.Moleres@xilinx.com>
Received: from outbound9-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B8AF7DDE41
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Dec 2007 10:57:31 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx ML310 Linux 2.6 PCI bridge
Date: Mon, 10 Dec 2007 16:57:29 -0700
In-Reply-To: <fa686aa40712082218k7e520e45q1266ecb4692b7dbb@mail.gmail.com>
References: <169c03cb0712082151k74e504bvc6e21bb57534ef28@mail.gmail.com>
	<fa686aa40712082218k7e520e45q1266ecb4692b7dbb@mail.gmail.com>
From: "Rick Moleres" <Rick.Moleres@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Jean-Samuel Chenard" <jsamch@macs.ece.mcgill.ca>
Message-Id: <20071210235609.91265F18074@mail188-sin.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Grant,

Can you give me more details on why you say the opb_pci bridge is badly
broken?  I know there have been issues with it in the past, but I'm not
aware of major outages (perhaps I'm just not in the loop).

> However, word of warning.  The Xilinx PCI bridge is badly broken.
> Xilinx is not supporting the PCI core and it is missing the ability to
> do certain types of transfers.  Last I heard, Xilinx has no plans to
> fix their PCI core either.

The opb_pci and plb_pci (plbv34) bridges have transitioned to the
plbv36_pci bridge in EDK 9.2 and later.  This bridge is fully supported
and has been tested under MontaVista's 2.6.10 kernel.  I believe only
critical issues will be fixed in the opb/plbv34.

Thanks,
Rick
