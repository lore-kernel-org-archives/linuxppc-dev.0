Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-71-119.roch.qwest.net [67.41.71.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF7CD67A82
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 12:33:41 +1100 (EST)
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20050315133231.A5861@cox.net>
References: <4236D36D.3090809@timesys.com> <42372CF0.6040901@mvista.com>
	<20050315133231.A5861@cox.net>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 19:33:33 -0600
Message-Id: <1110936813.28218.21.camel@jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mtd maps
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2005-03-15 at 13:32 -0700, Matt Porter wrote:
> On Tue, Mar 15, 2005 at 11:44:00AM -0700, Mark A. Greer wrote:
> > Greg Weeks wrote:
> > 
> > > Are mtd maps still in drivers/mtd/maps or has that all moved to the 
> > > platform code? I have an mtd map for the mpc8560ads but it's in mtd/maps.
> > 
> > 
> > The mtd code has changed so that platform code can get at the routines 
> > to set up the maps from there.  arch/ppc/platforms/katana.c has its mtd 
> > maps there and I recently posted a patch that moves it for the chestnut 
> > as well.
> > 
> > I think its a good idea to move them to the platform code since the mtd 
> > maps are platform specific anyway.  Plus its one less place to add/edit 
> > a file.  But that's just my $0.02...
> 
> But keep in mind that this currently only applies in the case where
> you need to map chips of the same type. Some boards have multiple
> chip types and physmap doesn't yet support that.

There is a driver in MTD CVS now called mphysmap (untested I believe),
that might be able to deal with that.  Eventually.

josh
