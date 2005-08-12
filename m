Return-Path: <jwboyer@jdub.homelinux.org>
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20050811195927.GX3187@smtp.west.cox.net>
References: <c237b7e878e0c32f421209fa37b7a156@freescale.com>
	<20050811195927.GX3187@smtp.west.cox.net>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 21:09:44 -0500
Message-Id: <1123812584.3299.18.camel@yoda.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Becky Bruce <becky.bruce@freescale.com>,
	linuxppc64-dev@ozlabs.org
Subject: Re: RFC: proposed arch/powerpc directory structure
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-08-11 at 12:59 -0700, Tom Rini wrote:
> On Wed, Aug 10, 2005 at 11:45:10AM -0500, Becky Bruce wrote:
> 
> [snip]
> > 	platforms/
> > 		- platform-specific code laid out in the following 
> > 		directories:
> > 		pSeries/
> > 		iSeries/
> > 		pmac/  (both 32 and 64-bit)
> > 		classic32/  (platforms containing 
> > 		6xx/7xx/74xx/8240/8241/8245)
> > 		classic64/  (Maple?)
> 
> I'm a bit ppc64-ignorant, but isn't 'pSeries' just a regular
> OpenFirmware-containing ppc64 box (like Maple) ?  How about just 9xx/
> for all of the ppc64's that have a 9xx in them (Maple), that aren't pmac
> (which is a class of its own).

I myself am also pretty ppc64 ignorant, but I do know that not all
pSeries are 9xx based.  There are POWER 4 and POWER 5 pSeries boxes too.

josh
