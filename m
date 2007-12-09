Return-Path: <glikely@secretlab.ca>
Received: from hs-out-2122.google.com (hs-out-0708.google.com [64.233.178.248])
	by ozlabs.org (Postfix) with ESMTP id 1A707DDE16
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Dec 2007 07:23:20 +1100 (EST)
Received: by hs-out-2122.google.com with SMTP id n78so610950hsc
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 09 Dec 2007 12:23:19 -0800 (PST)
Message-ID: <fa686aa40712091223x3efb1143kfd81277890fb74ae@mail.gmail.com>
Date: Sun, 9 Dec 2007 13:23:18 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jean-Samuel Chenard" <jsamch@macs.ece.mcgill.ca>
Subject: Re: Xilinx ML310 Linux 2.6 PCI bridge
In-Reply-To: <169c03cb0712090932y52cb2744p245cdeb0cccc2ff2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <169c03cb0712082151k74e504bvc6e21bb57534ef28@mail.gmail.com>
	<fa686aa40712082218k7e520e45q1266ecb4692b7dbb@mail.gmail.com>
	<169c03cb0712090932y52cb2744p245cdeb0cccc2ff2@mail.gmail.com>
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

On 12/9/07, Jean-Samuel Chenard <jsamch@macs.ece.mcgill.ca> wrote:
> On Dec 9, 2007 1:18 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On 12/8/07, Jean-Samuel Chenard <jsamch@macs.ece.mcgill.ca> wrote:
> > > Thanks to the valuable information provided by this discussion group and
> > > particularly by Grant Likely from Secret Lab Technologies, I was able to
> > > setup and run Linux 2.6 on my ML-310 development platform.
> >
> > Congratulations.  If you had to make any changes to get it to work
> > then please send me your patches.
>
> Thank you for the quick reply.

No problem.

>
> I will directly update Secret Lab's Wiki pages.  Those pages are the
> ones that got me going really quickly, so I will add a few of my
> observations directly on your pages so everyone can benefit.

Much appreciated; thank you!

> My real target is the control FPGA on a BEE2 box
> (http://bee2.eecs.berkeley.edu) and on that particular setup, the
> control FPGA is directly connected to an LXT971A Ethernet PHY, so I'll
> use the ethernet MAC from Xilinx.

Cool platform.  Yes, you should have much better luck with the EMAC
core.  The driver needs some work to be acceptable for mainline, but
it should be functional.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
