Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AADC867B20
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 17:05:47 +1100 (EST)
Message-ID: <43ED7E1E.2030700@ovro.caltech.edu>
Date: Fri, 10 Feb 2006 22:03:10 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Yosemite/440EP 'issues' as a PCI target
References: <20060210173133.964B53525CC@atlas.denx.de>
In-Reply-To: <20060210173133.964B53525CC@atlas.denx.de>
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


Hi Wolfgang,

>>Of course there is also the option of finding another
>>PowerPC that matches my requirements;
> ...
> MPC834x comes to mind. But I have to admit that we never tried  using
> this as a PCI device yet...

Indeed you were correct. The MPC834x series meets my requirements.
It is also a 3.3V PCI device, so I'm checking into whether
the Trenton CPUs I can use as host CPUs use a 3.3V PCI interface.
If that is the case, then I'll move the Force CPUs into another
system, and I'll just define the cPCI bus in the correlator
system as 3.3V-only.

The potential advantages of the MPC834x over the 440EP are;

   - it has doorbell registers and mailboxes for PCI
     host-to-host comms (though does not have an I2O interface)

   - its DDR-SDRAM controller can run faster than the 440EP

   - its external local bus is wider and faster than
     the 440EP

   - but I think the MPC834x internal buses are slower than
     the 440EP CoreConnect buses, so I'll need to benchmark
     to compare the two.

   - it exists! I can find them on distributors web sites
     (can't say the same for the 440EP yet!)

So, I'll continue with my evalation of the 440EP, and then
I'll want to evaluate the MPC834x devices.

What MPC834x development kit are you using? What would you recommend?

  - I'd like to get a board in a PCI or cPCI-form factor, since
    I could use it as a PCI agent/peripheral
  - I'd really like to get access to the external bus
    too.

Embedded Planet has a PrPMC module with an 8343E, but I doubt
I can get to the local bus on that board. I found news releases
of an MPC8349E QUICCstart board, but couldn't find anything
on Freescale's web site. Wind River appears to have an eval
board; SBC8347E/49E, which looks to be a cPCI board, but their
web site didn't have much in the way of details (or pictures).

Freescale do have the MPC8349EMDS 'MPC8349E Modular Development
System', but its not clear how much of that system I would
need to purchase just to test the board in a PCI system.
Looks like its aimed toward AdvancedTCA development.

Anyway, thanks for the pointer to the MPC834x series!

Dave
