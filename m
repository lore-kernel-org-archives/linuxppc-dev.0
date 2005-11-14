Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C69F668762
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 08:07:00 +1100 (EST)
Date: Mon, 14 Nov 2005 13:57:37 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Kumar Gala <galak@kernel.crashing.org>
Message-ID: <20051114155736.GB29411@logos.cnet>
References: <20051114143821.GA28852@logos.cnet>
	<9E7D3814-47AB-4601-A565-2530C3A4BEE0@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9E7D3814-47AB-4601-A565-2530C3A4BEE0@kernel.crashing.org>
Cc: Florian Schirmer <jolt@tuxbox.org>, obi@saftware.de, carjay@gmx.de,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] m8xx_wdt: software watchdog reset/interrupt select\
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kumar,

On Mon, Nov 14, 2005 at 02:55:24PM -0600, Kumar Gala wrote:
> Can we put the WDT for 8xx in drivers/char/watchdog/?

The userspace interface is already there at
drivers/char/watchdog/mpc8xx_wdt.c. I don't any reason for having two
files, will try to merge them into drivers/.

Thanks.
