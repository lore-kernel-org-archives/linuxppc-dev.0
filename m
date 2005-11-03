Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6996768596
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Nov 2005 08:21:49 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eddy =?iso-8859-2?Q?Petri=BAor?= <eddy.petrisor@gmail.com>
In-Reply-To: <60381eeb0511030103w551fad25h3d9d7fa258764d5e@mail.gmail.com>
References: <1130999620.4680.28.camel@gaston>
	<60381eeb0511030103w551fad25h3d9d7fa258764d5e@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 08:21:16 +1100
Message-Id: <1131052876.4680.78.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
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


> So this supposed to work with the USB sleep support enabled, right?
> If this works then I will be very thankful!
> I hope I have the time to test this patch this evening.
> 
> > Note that the patch is totally untested here so it may be just plain
> > bogus :)
> 
> No problem.
> 
> AIUI, this should allow me to put my PB 5,2 to sleep while a usb stick
> is mounted and come back from sleep with no problem and the stick to
> be still mounted, right?

Heh, in _theory_ :) The first aim of the patch is to remove the crash on
sleep/wakeup in 2.6.14. If it doesn't blow up, that's already a good
first step :) Wether suspend with your USB stick works is a different
matter, mostly due to the USB stack itself.

Ben.
