Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C3367DE00C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 05:47:48 +1100 (EST)
Message-ID: <47D82542.8020000@freescale.com>
Date: Wed, 12 Mar 2008 13:47:30 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
Subject: Re: Using the loop feature of the DMA controller on MPC8544 DS
References: <20080312123437.GA1589@Chamillionaire.breakpoint.cc>
	<47D7FD9D.2040202@freescale.com>
	<20080312172024.GB7255@Chamillionaire.breakpoint.cc>
In-Reply-To: <20080312172024.GB7255@Chamillionaire.breakpoint.cc>
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

> I need to hold src & dst each with one and two bytes makes four
> channels. And then I need one for normal transfers. So I guess I have to
> talk to my HW ppl that we have to change something :)

What kind of driver are you writing that needs four simultaneous DMA transfers?

-- 
Timur Tabi
Linux kernel developer at Freescale
