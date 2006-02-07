Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E134D68AA6
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Feb 2006 10:04:30 +1100 (EST)
Message-ID: <43E92745.1080407@ovro.caltech.edu>
Date: Tue, 07 Feb 2006 15:03:33 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "Travis B. Sawyer" <tsawyer+linuxppc@sandburst.com>
Subject: Re: Artesyn Processor PMC 'Host Bridge' has no IRQ assigned?
References: <43C7051D.8000001@ovro.caltech.edu>	<43C7AA6D.5060206@sandburst.com>	<43C7DA97.30505@ovro.caltech.edu>
	<43C7DD1D.20804@ovro.caltech.edu>
	<43E91ED1.2090400@ovro.caltech.edu>
	<43E92584.1000007@sandburst.com>
In-Reply-To: <43E92584.1000007@sandburst.com>
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


Hi Travis,

> It's been a couple of years since I've had to mess with the
> ArtPrPMC board. There is, IIRC, there is a doorbell register
> in the CPC700, but I don't have the spec handy.  My last
> use of the prpmc was with vxworks and shared memory 
> messaging using a doorbell.

Yeah, thats pretty much the 'way of PCI', so I was surprized
not to see the IRQ line assigned from the x86 host-side.

> Umm... I recall stating the XPEDITE1000 from X-ES was
> supported by u-boot (I'll have to submit another patch to
> Wolfgang as they(XES) changed some stuff wrt flash write
> protect, I've also moved the env from the cramped i2c eeprom 
> (bad) to the intel flash).

Oh, perhaps the comment was that you had used the board then :)

> I'd have to check the u-boot source for PrPMC support, as I
> haven't run u-boot on it.

No sweat, if I want to put U-Boot on it, then I'll just have to
port it :)  Since the Artesyn bootloader can tftp etc, I'll
figure out first how to get Linux booted.

I just booted up the second board, and it did not get
an IRQ either. I'll dig into the CPC700 manual, its likely
a boot-time enable.

Thanks for the feedback!
Dave
