Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id EE16EDDE11
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 04:05:47 +1100 (EST)
Date: Wed, 26 Nov 2008 18:05:36 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Subject: Re: too few bogoMips on MPC8313E-RDB ?
Message-ID: <20081126170536.GA16864@iram.es>
References: <492D1CA5.2090007@aimvalley.nl>
	<20081126102042.GA11397@mail.gnudd.com>
	<492D5B38.3080709@aimvalley.nl> <492D7219.8040501@mikroswiat.pl>
	<492D74C3.9060205@aimvalley.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <492D74C3.9060205@aimvalley.nl>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 26, 2008 at 05:09:39PM +0100, Norbert van Bolhuis wrote:
>
> ok, so it depends on the decrementer frequency
> (which is 41666666 on my system).
>
> Btw. the main oscillator on my board is not 83.3 mhz,
> it's 66 mhz as well.

66MHz is the crystal frequency, but then clock generators
use PLL to generate about anything from it. Actually people
use the abomination called DFS (frequency spreading) to comply
with requirements on radiated energy; that's a bad joke, it does
not actually reduce radiated energy, but spreads it over wider
bandwidth which makes it much harder to detect with standard
test equipement.

> Hmmm. so by using the decrementer for the clock tick/irqs
> (which perfectly makes sense) the bogoMIPS value is
> nonsense now. That's a pity, but at least now I know/understand.
>

As far as I know, there are other architecture on which it is
as bogus. Besides that it has the advantage of being really constant
even when CPU frequency changes.

	Regards,
	Gabriel
