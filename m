Return-Path: <sr@denx.de>
Received: from natipslore.rzone.de (natipslore.rzone.de [81.169.145.179])
	by ozlabs.org (Postfix) with ESMTP id E011268A0F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Feb 2006 05:31:36 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Yosemite/440EP PLB4 vs PLB3 DMA to PCI issue
Date: Mon, 6 Feb 2006 19:31:24 +0100
References: <20060205103958.284003535FD@atlas.denx.de>
	<43E68E85.3080100@ovro.caltech.edu>
In-Reply-To: <43E68E85.3080100@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602061931.25370.sr@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David,

I never used DMA on 440EP/GP till now so I just noticed the two different 
PLB's and their DMA controllers. Never seen this on any 4xx PPC so far. I 
suspect that the PLB4 is integrated mainly because of the USB interface.

On Monday 06 February 2006 00:47, David Hawkins wrote:
> I took a look at the 440EP user manual, and I haven't been
> able to explain the PLB4 DMA controller observations.
>
> Here's what I've got so far;
>
> p595: PLB-to-PCI transaction handling
>     Shows the two situations where the PCI bridge will
>     generate memory-read-line (MRL) and memory-read-multiple (MRM)

What version of the user manual are you referring to? Could you please give 
the pages for the current manual (Revision 1.18).

<snip>

> (I hope you had a nice vacation Stefan!)

Thanks. Very nice. One week of sunshine in the snow. :-)

Ciao,
Stefan
