Return-Path: <nvbolhuis@aimvalley.nl>
Message-ID: <492D74C3.9060205@aimvalley.nl>
Date: Wed, 26 Nov 2008 17:09:39 +0100
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: too few bogoMips on MPC8313E-RDB ?
References: <492D1CA5.2090007@aimvalley.nl>	<20081126102042.GA11397@mail.gnudd.com>
	<492D5B38.3080709@aimvalley.nl> <492D7219.8040501@mikroswiat.pl>
In-Reply-To: <492D7219.8040501@mikroswiat.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


ok, so it depends on the decrementer frequency
(which is 41666666 on my system).

Btw. the main oscillator on my board is not 83.3 mhz,
it's 66 mhz as well.

Hmmm. so by using the decrementer for the clock tick/irqs
(which perfectly makes sense) the bogoMIPS value is
nonsense now. That's a pity, but at least now I know/understand.

Thanks to everybody for their answers.
