Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BCE8EB6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Apr 2011 12:49:33 +1000 (EST)
Subject: Re: PowerMacintosh B&W G4 boot failure - linux-2.6.36.x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: acrux <acrux_it@libero.it>
In-Reply-To: <20110413202714.ad1b5697.acrux_it@libero.it>
References: <20110413202714.ad1b5697.acrux_it@libero.it>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Apr 2011 12:49:16 +1000
Message-ID: <1302749356.28876.105.camel@pasglop>
Mime-Version: 1.0
Cc: Nello M <ppc.addon@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-04-13 at 20:27 +0200, acrux wrote:
> i guess it's a different problem from the PegasosI G3 but i could be wrong.
> 
> I'd like to receive  feedbacks and a working kernel config if someone is running with success
>  linux-2.6.26.x on a Pmac B&W G3. This machine, altough obsolete, is still quite common

The snapshot you posted doesn't have much information... there's no
obvious error for example in there...

What video driver are you trying to use ? Have you tried plain offb ?
(disabling whatever is the native driver for your video card, ie,
radeonfb or aty128fb or even atyfb, dunno what you have in there).

You can also try something like "udbg-immortal" on the kernel command
line see if that brings you more debug output.

Cheers,
Ben.
