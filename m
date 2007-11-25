Return-Path: <benh@kernel.crashing.org>
Subject: Re: PCI to Parallel for PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Clemens Koller <clemens.koller@anagramm.de>
In-Reply-To: <4749AA1B.3050805@anagramm.de>
References: <f3566d60711242106x4d56efe1w325e70c522ddd62c@mail.gmail.com>
	<4749AA1B.3050805@anagramm.de>
Content-Type: text/plain
Date: Mon, 26 Nov 2007 08:09:11 +1100
Message-Id: <1196024951.7195.74.camel@pasglop>
Mime-Version: 1.0
Cc: puyq@lzu.cn, linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org,
	zhang_wei@lzu.cn, shekr06@lzu.cn
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2007-11-25 at 18:00 +0100, Clemens Koller wrote:
> Put that PCI Card to your host where your stepper was working
> properly to see if it's a hardware issue with that card.
> 
> Then it depends on how you control your stepper motor. If you use
> some bit-banging (which I wouldn't recommend) to drive each winding
> and want to have smooth movement, you need a very precise timing
> when it comes to some "more than low-speed" stepper motors,
> otherwise your motors will start to coggle.
> To be precise: you will first have to figure out what leads to
> the effect of "it's not stable". Do you have an Oscilloscope?

Also, we might need to see the code you are using to control the
parallel port, it may be ignoring issues such as PCI write posting or
lacking appropriate memory barriers...

Ben.
