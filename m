Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C1752DDE19
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 03:07:07 +1100 (EST)
Date: Fri, 30 Nov 2007 19:11:36 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: CPM2 USB host driver
Message-ID: <20071130161136.GA27760@localhost.localdomain>
References: <200711301145.52926.laurentp@cse-semaphore.com>
	<200711301330.25100.laurentp@cse-semaphore.com>
	<20071130124801.GA13141@localhost.localdomain>
	<200711301628.33526.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200711301628.33526.laurentp@cse-semaphore.com>
Cc: mike@compulab.co.il, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 30, 2007 at 04:28:27PM +0100, Laurent Pinchart wrote:
[...]
> > I tried to forward-port FHCI from Freescale 2.6.11 kernels. Twice.
> > But these efforts always stumbled over more important tasks.
> 
> Do you think I start from the FHCI driver provided by Freescale for 2.6.11, 
> from the cpm2usb driver or from scratch ?

Well, the same question I asked myself when I was looking at
FHCI driver back then. USB subsystem changed drastically, powerpc
bits changed too. Forward porting or doing from scratch.. hm.

Unfortunately I didn't look into cpm2usb, thus I can't tell
whether it will be easier to reuse.

As for FHCI driver, it's not that big (6100 lines host patch + 3516
lines usbgadget patch), but since usb subsystem changed: you have to
know all the changes (or to look them up) and blindly follow them. Or
start from scratch with FHCI/cpm2usb as the reference, thus evolve
into Linux USB expert one day.


I've tried first option -- it's boring to death (that is, you're
doing job USB maintainers done years ago for in-tree drivers ;-).

Today, I think I would choose the second option. Definitely more
fun, and most probably quicker to progress. Though, I repeat,
I didn't look into cpm2usb project.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
