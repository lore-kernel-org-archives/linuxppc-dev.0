Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 994BFDDEC0
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 23:43:30 +1100 (EST)
Date: Fri, 30 Nov 2007 15:48:01 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: CPM2 USB host driver
Message-ID: <20071130124801.GA13141@localhost.localdomain>
References: <200711301145.52926.laurentp@cse-semaphore.com>
	<20071130141638.4e00258d@kernel.crashing.org>
	<200711301330.25100.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200711301330.25100.laurentp@cse-semaphore.com>
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

On Fri, Nov 30, 2007 at 01:30:18PM +0100, Laurent Pinchart wrote:
> On Friday 30 November 2007 12:16, Vitaly Bordug wrote:
> > On Fri, 30 Nov 2007 11:45:49 +0100
> >
> > Laurent Pinchart wrote:
> > > Hi everybody,
> > >
> > > Linux USB host support for the CPM, CPM2 and CPM2 pro is far from
> > > complete. Many people showed interest on this list (and on
> > > linuxppc-embedded) in the past, but nobody managed to complete a
> > > driver and get it merged.
> >
> > that is mainly because of its semi-software nature. However, any approach
> > would be helpful I beleive.
> 
> The CPM/CPM2 USB host controller does indeed put some pressure on the CPU. The 
> PowerQuick III family is much better in that respect as its USB host 
> controller is EHCI compliant.

I didn't yet compare with CPM/CPM2, but I wonder if PQIIPro (MPC8360E)
USB controller is similar to cpms?..

I tried to forward-port FHCI from Freescale 2.6.11 kernels. Twice.
But these efforts always stumbled over more important tasks.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
