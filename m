Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id 6F3BB67A2F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 07:32:34 +1100 (EST)
Date: Tue, 15 Mar 2005 13:32:31 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20050315133231.A5861@cox.net>
References: <4236D36D.3090809@timesys.com> <42372CF0.6040901@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42372CF0.6040901@mvista.com>;
	from mgreer@mvista.com on Tue, Mar 15, 2005 at 11:44:00AM -0700
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

On Tue, Mar 15, 2005 at 11:44:00AM -0700, Mark A. Greer wrote:
> Greg Weeks wrote:
> 
> > Are mtd maps still in drivers/mtd/maps or has that all moved to the 
> > platform code? I have an mtd map for the mpc8560ads but it's in mtd/maps.
> 
> 
> The mtd code has changed so that platform code can get at the routines 
> to set up the maps from there.  arch/ppc/platforms/katana.c has its mtd 
> maps there and I recently posted a patch that moves it for the chestnut 
> as well.
> 
> I think its a good idea to move them to the platform code since the mtd 
> maps are platform specific anyway.  Plus its one less place to add/edit 
> a file.  But that's just my $0.02...

But keep in mind that this currently only applies in the case where
you need to map chips of the same type. Some boards have multiple
chip types and physmap doesn't yet support that.

-Matt
