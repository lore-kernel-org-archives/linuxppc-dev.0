Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1F451A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 13:23:09 +1100 (AEDT)
Message-ID: <1455675789.2956.1.camel@ellerman.id.au>
Subject: Re: [PATCH] MAINTAINERS: rename EEH from "enhanced" to "extended"
 error handling
From: Michael Ellerman <mpe@ellerman.id.au>
To: Russell Currey <ruscur@russell.cc>, Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 17 Feb 2016 13:23:09 +1100
In-Reply-To: <1455666599.3357.5.camel@russell.cc>
References: <1455612720-3758-1-git-send-email-ruscur@russell.cc>
 <20160216224908.GA5078@gwshan> <20160216225835.GA8240@gwshan>
 <1455666599.3357.5.camel@russell.cc>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-02-17 at 10:49 +1100, Russell Currey wrote:
> On Wed, 2016-02-17 at 09:58 +1100, Gavin Shan wrote:
> > On Wed, Feb 17, 2016 at 09:49:08AM +1100, Gavin Shan wrote:
> > > 
> > > On Tue, Feb 16, 2016 at 07:52:00PM +1100, Russell Currey wrote:
> > > > 
> > > > Incredibly, IBM online documentation for EEH uses "extended error
> > > > handling"
> > > > and "enhanced error handling" to refer to the same thing, in
> > > > different
> > > > places.  In other parts of the kernel, namely the EEH documentation
> > > > (found
> > > > in Documentation/powerpc/eeh-pci-error-recovery.txt), it's referred
> > > > to as
> > > > "extended", and in my opinion "extended" makes more sense for what
> > > > EEH
> > > > does.
> > > > 
> > > > The only place "enhanced error handling" shows up in the kernel is in
> > > > MAINTAINERS, so fix it.
> > > > 
> > > Russell, Thanks for fixing it up. Since you're at it, Please replace
> > > the
> > > maintainer to yourself. Also, the components mentioned in this file are
> > > listed in alphabetic order according to their names. As the name of EEH
> > > is changed, it would be put in front of "Extended Verification Module
> > > (EVM)".
> > > 
> > I agree with Michael as discussed in another thread: we're going to use
> > "enhanced", not "extended" though some chip datasheet (P7IOC) talks about
> > "extended error handling".
> > 
> > Russell, please change the maintainer to you and repost.
> Sure.
> 
> While I'm changing MAINTAINERS, what are your thoughts on renaming the EEH
> entry from "ENHANCED ERROR HANDLING (EEH)" to something like "PCI EXTENDED
> ERROR HANDLING (EEH)" or "EXTENDED ERROR HANDLING (EEH) FOR PCI" - so it's
> clear it refers to PCI and not something more generic?

Yep, having PCI at the front would be good as it will sort next to the other
PCI things. Having POWERPC in there is probably also good.

cheers
