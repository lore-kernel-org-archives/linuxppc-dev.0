Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9443367B6E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 05:22:44 +1100 (EST)
Message-ID: <43ECD918.1050202@ovro.caltech.edu>
Date: Fri, 10 Feb 2006 10:19:04 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Mark Chambers <markc@mail.com>, linuxppc-embedded@ozlabs.org
Subject: Re: Yosemite/440EP 'issues' as a PCI target
References: <20060209003459.0ED30352564@atlas.denx.de><43EBD715.4020303@ovro.caltech.edu>
	<200602100847.54363.sr@denx.de> <43ECC7CE.1010409@ovro.caltech.edu>
	<001701c62e6c$09c48ea0$6401a8c0@CHUCK2>
In-Reply-To: <001701c62e6c$09c48ea0$6401a8c0@CHUCK2>
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

Hi Mark,

> Some unsolicited brainstorming

Brainstorm away!

> if you go with a QUICC based processor you could bring 
> the data into SDRAM via a serial port. That gets you DMA
> and some extra buffer management help from the co-processor.

Ooooh I like it.

> Some extra logic in the FPGA (but less pins), but you've got
> a lot of flexibility in what you can do with SCCs or I2C.

But do I have the bandwidth? (I'll look in the data book).

> I'm currently working on an MPC8247 based design, btw.
> It has a PC104+ header and is directly connected to a 
> T.I. 6205 (which, at $10, is a lot of crunch for the buck).

But the you have to program it with Code Composer and
the horrid TI DSP tools. Yeah, ok I've got the older
C31 version, not the newer 6x-based DSPs. I'm trying
to move the system to Linux, so that others round
here can 'share the burden'. I'm designing the boards,
drivers, and host software (ACE/C++) at the moment.
I need a break! :)

I want to avoid spending $20k on the TI tools and an
emulator ... hey, call me cheap.

However, I like the SCC idea. They sound very similar
to the multi-processor links on the Analog Devices
SHARC DSPs.

More reading :)

Dave
