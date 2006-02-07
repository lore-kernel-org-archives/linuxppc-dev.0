Return-Path: <tsawyer+linuxppc@sandburst.com>
Received: from sandmail.sandburst.com (sandmail.sandburst.com [216.57.132.42])
	by ozlabs.org (Postfix) with ESMTP id 0FF5168926
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Feb 2006 09:56:06 +1100 (EST)
Message-ID: <43E92584.1000007@sandburst.com>
Date: Tue, 07 Feb 2006 17:56:04 -0500
From: "Travis B. Sawyer" <tsawyer+linuxppc@sandburst.com>
MIME-Version: 1.0
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: Artesyn Processor PMC 'Host Bridge' has no IRQ assigned?
References: <43C7051D.8000001@ovro.caltech.edu>	<43C7AA6D.5060206@sandburst.com>	<43C7DA97.30505@ovro.caltech.edu>
	<43C7DD1D.20804@ovro.caltech.edu>
	<43E91ED1.2090400@ovro.caltech.edu>
In-Reply-To: <43E91ED1.2090400@ovro.caltech.edu>
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

David Hawkins wrote:

> What appears strange to me is that there is no IRQ assigned.
>
Ouch.

> I haven't used PrPMC boards before, so perhaps this
> is normal.
>
> Travis, you mentioned you'd used this board before. Do you
> recall if this 'feature' is configurable, i.e., can I enable
> an interrupt. I'll also take a look in the IBM CPC700 bridge
> data sheet and see if I can see anything in there.
>
It's been a couple of years since I've had to mess with the ArtPrPMC board.
There is, IIRC, there is a doorbell register in the CPC700, but I don't 
have the spec
handy.  My last use of the prpmc was with vxworks and shared memory 
messaging
using a doorbell.

> I checked the mode of the PMC board using the monitor program.
> It says its in non-Monarch mode, so it is correctly configuring
> itself as a PCI peripheral.
>
> My objective for the board is to put U-Boot on it (Travis mentioned
> the Artesyn board is supported), boot Linux, and then write
> drivers for communicating over PCI to an x86 host (much as
> I plan to do with the 440EP processor).
>
Umm... I recall stating the XPEDITE1000 from X-ES was supported by u-boot
(I'll have to submit another patch to Wolfgang as they(XES) changed some 
stuff wrt
flash write protect, I've also moved the env from the cramped i2c eeprom 
(bad) to
the intel flash).

I'd have to check the u-boot source for PrPMC support, as I haven't run 
u-boot on it.

Best Regards, and good luck!
-travis
