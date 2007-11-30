Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 79186DDED5
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 00:02:36 +1100 (EST)
Date: Fri, 30 Nov 2007 16:02:21 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: CPM2 USB host driver
Message-ID: <20071130160221.583f8727@kernel.crashing.org>
In-Reply-To: <200711301330.25100.laurentp@cse-semaphore.com>
References: <200711301145.52926.laurentp@cse-semaphore.com>
	<20071130141638.4e00258d@kernel.crashing.org>
	<200711301330.25100.laurentp@cse-semaphore.com>
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

On Fri, 30 Nov 2007 13:30:18 +0100
Laurent Pinchart wrote:

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
> > that is mainly because of its semi-software nature. However, any
> > approach would be helpful I beleive.
> 
> The CPM/CPM2 USB host controller does indeed put some pressure on the
> CPU. The PowerQuick III family is much better in that respect as its
> USB host controller is EHCI compliant.
> 
> We plan to use an external USB host controller when we will redesign
> the hardware. My goal in writting a CPM2 USB host driver is mainly to
> enable the hardware team to perform EMC testing on the USB interface.
> I don't expect it to be shipped to any client, but I'd still like to
> get it merged (if I complete the project) as I don't like throwing
> away useful code.
> 
> > > As I need USB host support on my MPC8248 (CPM2), I decided to
> > > scratch the itch and try to get a working driver that could be
> > > merged upstream. This mail describes my plans to make sure the
> > > code I write will be useful for other people.
> > >
> > > The driver will be based on the cpm2usb project
> > > (http://cpm2usb.sf.net/). As I don't own any CPM1-based platform,
> > > I will convert the driver to use the CPM2 transaction-level
> > > interface, thus making it incompatible with the CPM1. CPM1
> > > support could be added back later. There is no planned release
> > > date, and more urgent projects could put this development on hold.
> > >
> > > Comments are welcome (and contributions too, especially in the
> > > form of a working driver :-)).
> >
> > I may have some WIP material left, will try to dig it out...
> 
> Should I wait ?
>

Dunno. It was about 3 years ago so the chance is small. 


-- 
Sincerely, Vitaly
