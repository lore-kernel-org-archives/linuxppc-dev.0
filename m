Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B9C768729
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Nov 2005 19:06:36 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
In-Reply-To: <200511140819.42439.arekm@pld-linux.org>
References: <1130999620.4680.28.camel@gaston> <43751182.1020009@gmail.com>
	<1131745946.24637.251.camel@gaston>
	<200511140819.42439.arekm@pld-linux.org>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 19:06:10 +1100
Message-Id: <1131955571.5504.150.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: 2.6.14 USB vs. sleep issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-11-14 at 08:19 +0100, Arkadiusz Miskiewicz wrote:
> On Friday 11 November 2005 22:52, Benjamin Herrenschmidt wrote:
> > The latest patch that is candidate for upstream is:
> 
> Oopsed for one pld user in a way shown in attachment after connecting usb 
> device while laptop (recent ibook g4 afaik) was in sleep and then waking it 
> up. That was with 2.6.14.2+your patch.

Ok, so there are still unresolved issues in the USB layer, which doesn't
surprise me. I'm trying to work with the USB folks to get those resolved
in 2.6.15 at least, we'll see if I succeed...

Ben.
