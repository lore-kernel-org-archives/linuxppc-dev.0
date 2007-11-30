Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 12BAADDEAB
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 00:00:40 +1100 (EST)
Date: Fri, 30 Nov 2007 16:00:22 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: avorontsov@ru.mvista.com
Subject: Re: CPM2 USB host driver
Message-ID: <20071130160022.5701fc03@kernel.crashing.org>
In-Reply-To: <20071130124801.GA13141@localhost.localdomain>
References: <200711301145.52926.laurentp@cse-semaphore.com>
	<20071130141638.4e00258d@kernel.crashing.org>
	<200711301330.25100.laurentp@cse-semaphore.com>
	<20071130124801.GA13141@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, mike@compulab.co.il
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 30 Nov 2007 15:48:01 +0300
Anton Vorontsov wrote:

> On Fri, Nov 30, 2007 at 01:30:18PM +0100, Laurent Pinchart wrote:
> > On Friday 30 November 2007 12:16, Vitaly Bordug wrote:
> > > On Fri, 30 Nov 2007 11:45:49 +0100
> > >
> > > Laurent Pinchart wrote:
> > > > Hi everybody,
> > > >
> > > > Linux USB host support for the CPM, CPM2 and CPM2 pro is far
> > > > from complete. Many people showed interest on this list (and on
> > > > linuxppc-embedded) in the past, but nobody managed to complete a
> > > > driver and get it merged.
> > >
> > > that is mainly because of its semi-software nature. However, any
> > > approach would be helpful I beleive.
> >=20
> > The CPM/CPM2 USB host controller does indeed put some pressure on
> > the CPU. The PowerQuick III family is much better in that respect
> > as its USB host controller is EHCI compliant.
>=20
> I didn't yet compare with CPM/CPM2, but I wonder if PQIIPro (MPC8360E)
> USB controller is similar to cpms?..
>
=46rom what I recall, it is similar, but ucc usb  should work fine,
at least according to RM it does all the necessary things in hw
so the cpu isn't hogged with say SOF generation.

> I tried to forward-port FHCI from Freescale 2.6.11 kernels. Twice.
> But these efforts always stumbled over more important tasks.
>=20


--=20
Sincerely, Vitaly
