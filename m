Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 782F3DDE17
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 07:50:16 +1100 (EST)
Message-ID: <47D841EE.2060806@freescale.com>
Date: Wed, 12 Mar 2008 15:49:50 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
Subject: Re: Using the loop feature of the DMA controller on MPC8544 DS
References: <20080312123437.GA1589@Chamillionaire.breakpoint.cc>
	<47D7FD9D.2040202@freescale.com>
	<20080312172024.GB7255@Chamillionaire.breakpoint.cc>
	<47D82542.8020000@freescale.com>
	<20080312204451.GA11426@Chamillionaire.breakpoint.cc>
In-Reply-To: <20080312204451.GA11426@Chamillionaire.breakpoint.cc>
Content-Type: text/plain; charset=ISO-8859-1
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

Sebastian Siewior wrote:

> Do you recommend another solution? Or did I miss an important part of
> the API that solves this kind of problem.

Well, I need to solve this problem myself, but I wasn't planning on doing it for
a while since I have a higher priority assignment at the moment.  My 8610 sound
driver does DMA all on its own and completely ignores Zhang's driver, so I need
to fix that.

Unfortunately, I'm not familiar with Zhang's driver at all (it's changed too
much since I last looked at it), so I don't know what the *best* way is.  For my
sound driver, I don't even know if I'll be able to leverage Zhang's driver at
all, since I need to use a specific DMA channel, and I need to control each of
the link descriptors.  Zhang's driver abstracts DMA too much.  So all I was
going to do is come up with a way to reserve channels.

-- 
Timur Tabi
Linux kernel developer at Freescale
