Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 4B376DDE3B
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 09:32:59 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: avorontsov@ru.mvista.com
Subject: Re: CPM2 USB host driver
Date: Fri, 30 Nov 2007 23:32:20 +0100
References: <200711301145.52926.laurentp@cse-semaphore.com>
	<200711301628.33526.laurentp@cse-semaphore.com>
	<20071130161136.GA27760@localhost.localdomain>
In-Reply-To: <20071130161136.GA27760@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711302332.21864.arnd@arndb.de>
Cc: dbrownell@users.sourceforge.net, linux-usb-devel@lists.sourceforge.net,
	gregkh@suse.de, linuxppc-dev@ozlabs.org, mike@compulab.co.il
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(Cc:'ing linux-usb-devel)

On Friday 30 November 2007, Anton Vorontsov wrote:
> As for FHCI driver, it's not that big (6100 lines host patch + 3516
> lines usbgadget patch), but since usb subsystem changed: you have to
> know all the changes (or to look them up) and blindly follow them. Or
> start from scratch with FHCI/cpm2usb as the reference, thus evolve
> into Linux USB expert one day.

6100 lines means it's still the second-largest hcd driver in the kernel,
only drivers/usb/host/u132-hcd.c has even more.

> Today, I think I would choose the second option. Definitely more
> fun, and most probably quicker to progress. Though, I repeat,
> I didn't look into cpm2usb project.

My experience with other drivers moved into the kernel is that you
end up rewriting it completely anyway. I can also recommend starting
from scratch, and taking one of the in-kernel drivers as an example.
Maybe Greg or David can give you a suggestion which one of them
serves as the best example for a new host driver.

	Arnd <><
