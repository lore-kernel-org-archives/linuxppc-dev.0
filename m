Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C2A506891D
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Feb 2006 06:07:27 +1100 (EST)
Message-ID: <43E79EDD.9010702@ovro.caltech.edu>
Date: Mon, 06 Feb 2006 11:09:17 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: Yosemite/440EP PLB4 vs PLB3 DMA to PCI issue
References: <20060205103958.284003535FD@atlas.denx.de>
	<43E68E85.3080100@ovro.caltech.edu> <200602061931.25370.sr@denx.de>
In-Reply-To: <200602061931.25370.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi Stefan,

> I never used DMA on 440EP/GP till now so I just noticed the two different 
> PLB's and their DMA controllers. Never seen this on any 4xx PPC so far. I 
> suspect that the PLB4 is integrated mainly because of the USB interface.

That sounds about right. In my app I won't be using USB, and since the 
PLB4 DMA controller has larger DMA buffers, I thought it might have an
edge over the PLB3 controller.

> What version of the user manual are you referring to? Could you please give 
> the pages for the current manual (Revision 1.18).

Oh, sorry, I was looking at the version 1.14 manual. I've just
downloaded the 1.18 manual. Whoa! The 1.14 manual has 1696 pages,
whereas the 1.18 manual has only 794 - I hope that means things
have got simpler ;)

(nope, looks like the 440 core just got moved into another document)

Anyways, here are the v1.18 page references;

v1.18 p365-6 has the PLB-to-PCI Transaction Handling section
       showing the cases where MRL and MRM will be used.

v1.18 p407 has the PCI Memory to SDRAM DMA transfer section
       with comments and forward references to the timing
       diagram pages.

>>(I hope you had a nice vacation Stefan!)
> 
> Thanks. Very nice. One week of sunshine in the snow. :-)

I hope that means you got some nice snowboarding or skiing!

We have a fun mountain just up the road;
http://www.mammothmountain.com/

Feel free to come and visit if you are in California anytime!

Cheers
Dave
