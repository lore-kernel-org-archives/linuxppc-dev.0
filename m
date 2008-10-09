Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 2753FDDE98
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 09:08:29 +1100 (EST)
Date: Thu, 9 Oct 2008 18:08:26 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: PPC440EPx gpio driver
Message-ID: <20081009180826.32999ba8@lappy.seanm.ca>
In-Reply-To: <48ED1E96.4060406@harris.com>
References: <48ED1E96.4060406@harris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 08 Oct 2008 16:56:54 -0400
"Steven A. Falco" <sfalco@harris.com> wrote:

>  have begun writing a driver for the GPIOs of the PPC440EPx.  I just
> noticed that the PIKA Warp .dts references a device "ibm,gpio-440ep",
> but so far I have not been able to find a driver for that device.

It's just around the corner, through the blue door ;) That device string
was put in optimistically hoping somebody would write a gpio driver.

FYI the warp has two leds tied to gpios. It currently uses a custom led
driver. Once a gpio driver is written, the of gpio leds driver should
work and the custom driver will go away.

So I am very interested in your driver ;)

Cheers,
   Sean
