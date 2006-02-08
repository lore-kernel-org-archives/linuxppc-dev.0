Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B658968AB0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Feb 2006 05:47:18 +1100 (EST)
Message-ID: <43EA3BC9.4090506@ovro.caltech.edu>
Date: Wed, 08 Feb 2006 10:43:21 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: Yosemite/440EP PLB4 vs PLB3 DMA to PCI issue
References: <20060205103958.284003535FD@atlas.denx.de>
	<200602061931.25370.sr@denx.de> <43E79EDD.9010702@ovro.caltech.edu>
	<200602081638.25905.sr@denx.de>
In-Reply-To: <200602081638.25905.sr@denx.de>
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



>>Anyways, here are the v1.18 page references;
>>
>>v1.18 p365-6 has the PLB-to-PCI Transaction Handling section
>>       showing the cases where MRL and MRM will be used.
>>
>>v1.18 p407 has the PCI Memory to SDRAM DMA transfer section
>>       with comments and forward references to the timing
>>       diagram pages.
> 
> 
> Thanks. I have to admit that my only advice to you is, to send these questions 
> to the AMCC support. This seems to be a hardware related question/problem. 
> Sorry.

No problem! I appreciate you taking the time to look at it.
I'll contact AMCC and see what they have to say.

> Please keep me informed when you get an explanation for this PLB4 DMA 
> behaviour.

I will.

> Thanks for the invitation. But our 9 month's old daughter will not "allow" us 
> to make such a long trips in the next few years, I am afraid! :-(

Ahh, well come visit in a few years then :)

You can't convince Wolfgang that someone needs to show up at the
Embedded Systems Conference in San Jose, CA, in April, then eh!?

Dave
