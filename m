Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 7822FDDEE2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Dec 2007 11:20:44 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so392440anc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Dec 2007 16:20:43 -0800 (PST)
Message-ID: <fa686aa40712101620u14924d73gff6291dfb9e0a17e@mail.gmail.com>
Date: Mon, 10 Dec 2007 17:20:43 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Rick Moleres" <Rick.Moleres@xilinx.com>
Subject: Re: Xilinx ML310 Linux 2.6 PCI bridge
In-Reply-To: <20071210235609.91265F18074@mail188-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <169c03cb0712082151k74e504bvc6e21bb57534ef28@mail.gmail.com>
	<fa686aa40712082218k7e520e45q1266ecb4692b7dbb@mail.gmail.com>
	<20071210235609.91265F18074@mail188-sin.bigfish.com>
Cc: Jean-Samuel Chenard <jsamch@macs.ece.mcgill.ca>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 12/10/07, Rick Moleres <Rick.Moleres@xilinx.com> wrote:
>
> Grant,
>
> Can you give me more details on why you say the opb_pci bridge is badly
> broken?  I know there have been issues with it in the past, but I'm not
> aware of major outages (perhaps I'm just not in the loop).

Actually, it's more likely that I'm not in the loop (see below)

I know of 2 projects that had difficulty with the opb_pci core; The
major issue was that it didn't support all of the PCI transfer modes
(IIRC it was the multiple read transfer command).  Last I heard from
the FAE was that Xilinx was not offering support for the core.

> The opb_pci and plb_pci (plbv34) bridges have transitioned to the
> plbv36_pci bridge in EDK 9.2 and later.  This bridge is fully supported
> and has been tested under MontaVista's 2.6.10 kernel.  I believe only
> critical issues will be fixed in the opb/plbv34.

This I was not aware of.  I stand corrected.

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
