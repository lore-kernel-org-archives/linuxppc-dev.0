Return-Path: <mgreer@mvista.com>
Date: Fri, 12 Jan 2007 14:48:35 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH/RFC] Add cmd_wrap_dts rules to arch/powerpc/boot/Makefile
Message-ID: <20070112214835.GA5366@mag.az.mvista.com>
References: <20061019002635.GA2356@mag.az.mvista.com>
	<E1GaYUQ-0001jb-20@jdl.com>
	<20061019195156.GB6586@mag.az.mvista.com>
	<20070111004048.GA27351@mag.az.mvista.com>
	<1168631458.19605.34.camel@cashmere.sps.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1168631458.19605.34.camel@cashmere.sps.mot.com>
Cc: Jon Loeliger <jdl@jdl.com>, linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 12, 2007 at 01:50:59PM -0600, Jon Loeliger wrote:
> On Wed, 2007-01-10 at 18:40, Mark A. Greer wrote:
> > On Thu, Oct 19, 2006 at 12:51:56PM -0700, Mark A. Greer wrote:
> > > On Thu, Oct 19, 2006 at 09:03:18AM -0500, Jon Loeliger wrote:
> > > > So, like, the other day "Mark A. Greer" mumbled:
> > > > > 
> > > > > This would be used by the sandpoint, say, by adding the following rules
> > > > > to the Makefile in the appropriate places:
> > > > > 
> > > > > 	$(obj)/zImage.sandpoint: vmlinux $(wrapperbits)
> > > > > 		$(call cmd,wrap_dts,sandpoint)
> > > > > 
> > > > > 	$(obj)/zImage.initrd.sandpoint: vmlinux $(wrapperbits)
> > > > > 		$(call cmd,wrap_dts_initrd,sandpoint)
> > > > > 
> > > > > and:
> > > > > 
> > > > > 	image-$(CONFIG_SANDPOINT)               += zImage.sandpoint
> > > > > 
> > > > > Comments?
> > > > 
> > > > Isn't there a way to do this without hardcoding the
> > > > platform name in the makefiles directly?  I fear for
> > > > the one-per-platform effect that is yet to come with
> > > > the conversion of many of the legacy boards.
> > 
> > Okay, its been a while so let's see if anyone remembers and/or cares
> > anymore.  :)
> 
> We care.  We care deeply.  We've just all been on vacation. :-)
> 
> Scott Wood (here) has recently pushed around a patch
> internally that is very similar and much more comprehensive,
> though I confess I've not really studied it.  He mumbled
> something about prepping it to send out when he gets back.
> And I think that will be Monday.

Okay, that would be great.  Thanks for the heads up.

Mark
