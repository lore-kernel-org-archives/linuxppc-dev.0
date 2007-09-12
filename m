Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F2070DDEC6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Sep 2007 02:02:57 +1000 (EST)
Message-ID: <46E80E08.2090204@ovro.caltech.edu>
Date: Wed, 12 Sep 2007 09:04:24 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Subject: Re: PCI target implementation on AMCC PPC CPUs
References: <556445368AFA1C438794ABDA8901891C06460054@USA0300MS03.na.xerox.net>
	<200709111113.46508.matthias.fuchs@esd-electronics.com>
	<46E6D131.2030904@ovro.caltech.edu>
	<200709120917.29767.matthias.fuchs@esd-electronics.com>
In-Reply-To: <200709120917.29767.matthias.fuchs@esd-electronics.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Leonid <Leonid@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Matthias,

> I must admit, that the AMCC PowerPC's PCI interrupt capabilities could
> be better:-) In both directions the host CPU has to do PCI
> configuration cycles either to generate or acknowledge an interrupt.
> The later is problematic for some OS coming from Redmond: you 
> have to do pci configuration cycles from interrupt level - and
> these OS do not 'like' that. 

Yikes. I'm sure there were some headaches there.

> In later designs and where possible we also switched to alternative
> interrupt mechanisms (GPIO for target to host and gated flags in FPGA
> registers for the other direction). Multiple interrupt sources 
> are identified by messages that are written to the other sides
> memory.
> 
> I think we should stop this discussion because its a little bit
> off-topic on this list.

I think this particular piece of info is important on
this list. It'll help those looking for processor options
that happen to search back through the list messages.

I'm done now, I just wanted to satisfy my curiosity
(and I did learn how the host can interrupt the core!).

I know that Leonid has hardware with these CPUs on them,
and he wanted some feedback on the AMCCs as target processor.
I'd eliminated the processor before getting it fully into
a design; so your experience is a little further on.

However, the conclusion remains the same; try to avoid
using the 440EP as a PCI target device.

Cheers,
Dave
