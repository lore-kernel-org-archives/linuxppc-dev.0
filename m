Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1D87DDDED9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Sep 2007 02:08:41 +1000 (EST)
Date: Thu, 20 Sep 2007 11:08:04 -0500
From: Scott Wood <scottwood@freescale.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Printing device tree on running system
Message-ID: <20070920160804.GA15796@ld0162-tx32.am.freescale.net>
References: <9e4733910709200855p5a1cdf18v1848a31c7935ca5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910709200855p5a1cdf18v1848a31c7935ca5e@mail.gmail.com>
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

On Thu, Sep 20, 2007 at 11:55:10AM -0400, Jon Smirl wrote:
> Is there a command for printing the device tree on a running system? I
> want to see what changes the various device drivers made to the DTC I
> started with.

It's exported in /proc/device-tree, if support is built into the kernel.

It might be interesting to make dtc support turning that into a dts...

-Scott
