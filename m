Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 88BD8DDE08
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2008 07:39:24 +1100 (EST)
Date: Sun, 6 Jan 2008 14:48:23 -0600
From: Olof Johansson <olof@lixom.net>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: Enable RTC for Ebony and Walnut
Message-ID: <20080106204823.GB12640@lixom.net>
References: <20071221022130.GI2665@localhost.localdomain>
	<20071221212922.GC11910@lixom.net>
	<20080102114208.GD23168@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080102114208.GD23168@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 02, 2008 at 10:42:08PM +1100, David Gibson wrote:
> On Fri, Dec 21, 2007 at 03:29:22PM -0600, Olof Johansson wrote:
> > Hi,
> > 
> > On Fri, Dec 21, 2007 at 01:21:30PM +1100, David Gibson wrote:
> > > Index: working-2.6/arch/powerpc/platforms/Kconfig
> > > ===================================================================
> > > --- working-2.6.orig/arch/powerpc/platforms/Kconfig	2007-12-10 10:52:44.000000000 +1100
> > > +++ working-2.6/arch/powerpc/platforms/Kconfig	2007-12-21 13:11:34.000000000 +1100
> > > @@ -315,6 +315,9 @@ config FSL_ULI1575
> > >  config CPM
> > >  	bool
> > >  
> > > +config OF_RTC
> > > +	bool
> > > +
> > 
> > New config options should have descriptions, even if they're silent
> > ones.
> 
> Uh.. but if there's a description, won't kconfig prompt for the
> option?  This one should only ever be selected by the platform
> options.

Sorry, should have said "should have help texts to describe them". Yes,
the one-line description will trigger a question, but adding a short
help text describing what the config option is for does not.


-Olof
