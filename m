Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2CB90DE2C0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jul 2008 05:37:58 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m6TJaWan017427 for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jul 2008 12:36:32 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m6TJaV0C004304
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jul 2008 14:36:31 -0500 (CDT)
Date: Tue, 29 Jul 2008 14:36:30 -0500
From: Scott Wood <scottwood@freescale.com>
To: Ben Gardiner <BenGardiner@nanometrics.ca>
Subject: Re: No output from SMC1 console with the 2.6.26 kernel (8xx based
	board)
Message-ID: <20080729193630.GB8051@ld0162-tx32.am.freescale.net>
References: <8496f91a0807281243y2193dad5hc758444fe0a10258@mail.gmail.com>
	<488E2510.7070209@freescale.com>
	<8496f91a0807282310r5e70fe01v85b2ff2da7a80416@mail.gmail.com>
	<488F385B.9030504@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <488F385B.9030504@nanometrics.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Jul 29, 2008 at 11:33:47AM -0400, Ben Gardiner wrote:
> And my serial console output is stopping around the same point as 
> Matvejchikov. I have baud 9600, so I'm guessing that it's cutoff because 
> of this (please excuse me if this is wrong). NB: the console=ttyS0 
> bootarg is there to get a working console when I  boot back to 2.4.
> <snip console>
> Memory <- <0x0 0x8000000> (128MB)
> ENET0: local-mac-address <- 00:11:40:02:00:18
> CPU clock-frequency <- 0x3f940aa (67MHz)
> CPU timebase-frequency <- 0x1fce17 (2MHz)
> CPU bus-frequency <- 0x1fce170 (33MHz)

Try commenting out calls to cpm_setbrg(), to see if the frequency is bad.

-Scott
