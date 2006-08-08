Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CA31F67B53
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Aug 2006 02:07:21 +1000 (EST)
Received: from [192.100.16.36] (kiwi.ovro.caltech.edu [192.100.16.36])
	by ovro.ovro.caltech.edu (8.13.6/8.13.6) with ESMTP id k78G7HSe029069
	for <linuxppc-embedded@ozlabs.org>; Tue, 8 Aug 2006 09:07:17 -0700
Message-ID: <44D8B69B.9080507@ovro.caltech.edu>
Date: Tue, 08 Aug 2006 09:06:51 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: PowerPC Local Bus
References: <20060808135020.GG26606@igloo.df.lth.se>
In-Reply-To: <20060808135020.GG26606@igloo.df.lth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fredrik Roubert wrote:
> Hi!
> 
> I'm about to write drivers for some FPGA's that are connected to the
> local bus of a PowerQUICC II Pro processor and use the user-programmable
> machines (UPM's) to transfer data over the bus. What code does already
> exist for Linux to help me with this? In the stock kernels, I can't even
> find a structure definition for the registers of the local bus
> controller, but it seems strange that no-one has written such code
> before me. Will I really have to write everything from scratch, or what
> code is there that I don't know about yet?
> 
> Cheers // Fredrik Roubert
> 

Hi Fredrik,

I'm going to working on something similar soon. If you want
to discuss it off-list, feel free to. We can report the
results back to the list once we have something working.

This is something that can either go in U-Boot or Linux. The
UPM looks fairly easy to setup. Freescale has a UPM programming
tool that allows you to setup waveforms for the single-read/write
and burst-read/write sequences. I was going to connect up
an FPGA to the MPC8349E-MDS local bus (using the unloaded
SDRAM pads) and then capture logic analyzer traces of the
transactions.

I plan to setup a burst mode interface to an FPGA. Actually,
I'll probably decode one chip select to non-burst registers,
and another to burstable memory.

Like I said, we can chat off-list if you like since this discussion
will not be of general interest (but if anyone thinks this should
stay on-list, let me know, and we'll discuss it here).

What FPGA family are you using? I'll be attaching an Altera
Stratix II FPGA onto the local-bus.

Dave Hawkins
Caltech.
