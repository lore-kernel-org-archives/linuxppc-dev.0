Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DBDE5679F2
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 12 Feb 2006 05:08:55 +1100 (EST)
Message-ID: <43EE279E.6070609@ovro.caltech.edu>
Date: Sat, 11 Feb 2006 10:06:22 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: Yosemite/440EP 'issues' as a PCI target
References: <20060209003459.0ED30352564@atlas.denx.de>
	<200602101859.24830.sr@denx.de> <43ECD753.5000105@ovro.caltech.edu>
	<200602110906.05547.sr@denx.de>
In-Reply-To: <200602110906.05547.sr@denx.de>
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



>>However, its not totally out of the question ... $50 per 21555
>>and 20 per crate, thats $1000, about half the price of
>>a CPU. But of course, without the I20 unit on the 440EP,
>>I might need the 21555 anyway.
> 
> 
> Do you really need this I2O unit? You could easily create some message 
> ringbuffers, one in the 440EP's SDRAM for the host-to-440 messages and one in 
> the host-cpu SDRAM for the 440-to-host messages. This way, all messages will 
> be transferred using pci writes.

Hi Stefan,

Nope, I can always work with the 440EP. I was just disappointed
to find that the 440EP had no way for an external host to
generate an interrupt (without coming up with the work-arounds
I suggested). I don't have the part designed into a board, I'm
merely  evaluating it. So, I wanted to see what else was out
there with a similar set of features; the MPC834x has them.

So, now I have two possible processors to evaluate :)

I'll finish the other tests I want to do with the 440EP, get
myself a MPC834x and repeat the same tests with it (which
shouldn't take too long, since it'll be a repeat of the
440 tests).

The MPC834x does have features to make communications between a
host and a target (PCI 'agent') work much nicer than the 440EP.
It also appears to have a faster local bus. I haven't had time
to benchmark, or estimate from timing diagrams, the performance
of the 440EP external memory bus, but there is a chance that
it will fail to meet my spec.

I wouldn't consider the 440EP work to be wasted. Its been a good
learning experience, and mainly I've just been working on this
stuff in the evenings and weekends to see whether the processor
will work. This was my first experience with PowerPC processors,
so its all good fun!

Cheers
Dave
