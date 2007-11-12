Return-Path: <benh@kernel.crashing.org>
Subject: Re: pcspkr device, pnpPNP,100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910711111618l5190dee3jd8e0aa8f9b78ebf4@mail.gmail.com>
References: <9e4733910711111535w6ffdfa97x4bed07eb84d4ab13@mail.gmail.com>
	<1194825784.18185.0.camel@pasglop>
	<9e4733910711111607i35294d3ja43e1c616a3427bd@mail.gmail.com>
	<1194826191.18185.6.camel@pasglop>
	<9e4733910711111618l5190dee3jd8e0aa8f9b78ebf4@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 12 Nov 2007 12:07:26 +1100
Message-Id: <1194829646.18185.8.camel@pasglop>
Mime-Version: 1.0
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2007-11-11 at 19:18 -0500, Jon Smirl wrote:

> Using this scheme, which platforms should select the pcspkr hardware?

Run a poll :-) I suppose at least chrp/prep/pegasos

Ben.
