Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3AE9FDE0EE
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 02:14:56 +1000 (EST)
Message-ID: <487B7B71.9060606@freescale.com>
Date: Mon, 14 Jul 2008 11:14:41 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>, Grant Likely <grant.likely@secretlab.ca>,
	linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	liam.girdwood@wolfsonmicro.com
Subject: Re: [alsa-devel] [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper
	for matching bus and codec drivers
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>	<20080714134930.GC25448@sirena.org.uk>	<9e4733910807140713r5739efedw81e65632006d101d@mail.gmail.com>
	<20080714150527.GD25448@sirena.org.uk>
In-Reply-To: <20080714150527.GD25448@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark Brown wrote:

>> The PowerPC side isn't without fault too. PowerPC still doesn't have a
>> good way to load the fabric/machine driver.
> 
> I'm finding it difficult to square these two statements - from an ASoC
> point of view the main thing this patch is doing is adding a machine
> driver and that's not something that's going to go away.  

Jon's concern is that there is no straightforward way to build a kernel with
multiple fabric drivers and have the right one chosen via the device tree.  This
is just a limitation of the device tree model, and no one has come up with a
good solution yet.

The problem still exists in ASoC V2.  However, it's not anything that ASoC
itself needs to be concerned with.  It's purely a PowerPC problem.

>> Which are we going to call it, fabric or machine? I had been working
>> on the Apple code in sound/aoa. It is called fabric in that code. The
>> equivalent driver is called machine in ASoC v1.
> 
> ASoC has always called it a machine driver.

Wait, I thought it's supposed to be called a fabric driver now?  On PowerPC, it
should be called a fabric driver because we already have machine drivers.

-- 
Timur Tabi
Linux kernel developer at Freescale
