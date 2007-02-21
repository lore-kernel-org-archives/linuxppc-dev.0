Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2AA91DDF0D
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:42:38 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l1LChwiE8339680
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:43:58 -0100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1L0k4dE181148
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:46:04 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1L0gXcn011592
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:42:34 +1100
Date: Wed, 21 Feb 2007 11:38:56 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [0/14] Ebony support, 2nd spi
Message-ID: <20070221003856.GK10231@localhost.localdomain>
References: <20070220020837.GF17818@localhost.localdomain>
	<200702201607.33249.arnd@arndb.de>
	<814781c1228541df932f8f4c7cc6ea89@kernel.crashing.org>
	<200702201902.09051.arnd@arndb.de>
	<df6b7857dc38d708a68c81a75b256cb5@kernel.crashing.org>
	<1172003365.24204.135.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1172003365.24204.135.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	Hartmut Penner <HPENNER@de.ibm.com>,
	Christian Rund <Christian.Rund@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 20, 2007 at 02:29:25PM -0600, Josh Boyer wrote:
> On Tue, 2007-02-20 at 20:51 +0100, Segher Boessenkool wrote:
> > 
> > > We probably also need a volunteer to clean up the legacy_serial
> > >
> > > code for this, it's grown pretty messy by now.
> > 
> > I nominate you :-)
> 
> In the absence of someone actually cleaning up the code, the following
> ugly patch should work for both Axon and 4xx until we can settle on
> settle on something.  It booted on my Ebony board with David's
> FIXED_PORT flag patch also applied anyway.
> 
> josh
> 
> Make legacy_serial look for multiple compatible serial types on the OBP bus.

Again: legacy_serial is not necessary for Ebony console support with
the current patches.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
