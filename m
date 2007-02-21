Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EB6A5DDE22
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 12:24:53 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1L1Oosd024507
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 20:24:50 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1L1Oomt369884
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 18:24:50 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1L1OodI031653
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 18:24:50 -0700
Date: Tue, 20 Feb 2007 19:30:13 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
	Christian Rund <Christian.Rund@de.ibm.com>,
	Hartmut Penner <HPENNER@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [0/14] Ebony support, 2nd spi
Message-ID: <20070221013012.GL1038@crusty.rchland.ibm.com>
References: <20070220020837.GF17818@localhost.localdomain>
	<200702201607.33249.arnd@arndb.de>
	<814781c1228541df932f8f4c7cc6ea89@kernel.crashing.org>
	<200702201902.09051.arnd@arndb.de>
	<df6b7857dc38d708a68c81a75b256cb5@kernel.crashing.org>
	<1172003365.24204.135.camel@zod.rchland.ibm.com>
	<20070221003856.GK10231@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070221003856.GK10231@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 21, 2007 at 11:38:56AM +1100, David Gibson wrote:
> On Tue, Feb 20, 2007 at 02:29:25PM -0600, Josh Boyer wrote:
> > On Tue, 2007-02-20 at 20:51 +0100, Segher Boessenkool wrote:
> > > 
> > > > We probably also need a volunteer to clean up the legacy_serial
> > > >
> > > > code for this, it's grown pretty messy by now.
> > > 
> > > I nominate you :-)
> > 
> > In the absence of someone actually cleaning up the code, the following
> > ugly patch should work for both Axon and 4xx until we can settle on
> > settle on something.  It booted on my Ebony board with David's
> > FIXED_PORT flag patch also applied anyway.
> > 
> > josh
> > 
> > Make legacy_serial look for multiple compatible serial types on the OBP bus.
> 
> Again: legacy_serial is not necessary for Ebony console support with
> the current patches.

Ok, that's fine.  But we should select of_serial from the Ebony Kconfig entry
if that's the one you'd like to use.

josh
