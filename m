Return-Path: <sr@denx.de>
Received: from natnoddy.rzone.de (natnoddy.rzone.de [81.169.145.166])
	by ozlabs.org (Postfix) with ESMTP id 1B62D67B5B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 19:21:43 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Yosemite/440EP 'issues' as a PCI target
Date: Sat, 11 Feb 2006 09:21:32 +0100
References: <20060210173133.964B53525CC@atlas.denx.de>
	<43ED7E1E.2030700@ovro.caltech.edu>
In-Reply-To: <43ED7E1E.2030700@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602110921.33245.sr@denx.de>
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

On Saturday 11 February 2006 07:03, David Hawkins wrote:
> Indeed you were correct. The MPC834x series meets my requirements.
> It is also a 3.3V PCI device, so I'm checking into whether
> the Trenton CPUs I can use as host CPUs use a 3.3V PCI interface.
> If that is the case, then I'll move the Force CPUs into another
> system, and I'll just define the cPCI bus in the correlator
> system as 3.3V-only.

Ahhh. ;-)

> The potential advantages of the MPC834x over the 440EP are;
>
>    - it has doorbell registers and mailboxes for PCI
>      host-to-host comms (though does not have an I2O interface)
>
>    - its DDR-SDRAM controller can run faster than the 440EP
>
>    - its external local bus is wider and faster than
>      the 440EP
>
>    - but I think the MPC834x internal buses are slower than
>      the 440EP CoreConnect buses, so I'll need to benchmark
>      to compare the two.
>
>    - it exists! I can find them on distributors web sites
>      (can't say the same for the 440EP yet!)

Hmmm. The 440EP is around for quite a while. I would be surprised if you 
couldn't buy those parts right now. But I have to admit, I never tried to. I 
would contact my AMCC distributor for availability...

Best regards,
Stefan
