Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 77224DDEE8
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 02:50:20 +1100 (EST)
Date: Mon, 28 Jan 2008 09:50:12 -0600
From: Scott Wood <scottwood@freescale.com>
To: "Bryan O'Donoghue" <bodonoghue@codehermit.ie>
Subject: Re: PATCH[1/1] 8xx: Add clock-frequency to .dts brg entries
Message-ID: <20080128155012.GA27054@ld0162-tx32.am.freescale.net>
References: <1201485191.5537.55.camel@neuromancer.mindspace>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1201485191.5537.55.camel@neuromancer.mindspace>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 28, 2008 at 01:53:11AM +0000, Bryan O'Donoghue wrote:
> cpm_uart_core has a dependency on fsl,cpm-brg/clock-frequency, this
> means that a .dts that uses the cpm uart driver needs to supply a
> clock-frequency entry for get_brgfreq to return a meaningful number.
> 
> Included is a patchset which adds the correct brgclk to the adder port -
> @ 50Mhz and also adds an entry for mpc885ads - which I've noticed is
> missing a clock-frequency entry.

It's not missing -- it's added by the bootwrapper.

-Scott
