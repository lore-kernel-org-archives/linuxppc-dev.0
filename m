Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C1D31A0060
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 11:13:45 +1100 (AEDT)
Message-ID: <1455668017.3357.6.camel@russell.cc>
Subject: Re: [PATCH] MAINTAINERS: rename EEH from "enhanced" to "extended"
 error handling
From: Russell Currey <ruscur@russell.cc>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 17 Feb 2016 11:13:37 +1100
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
> > 
> > On Wed, Feb 17, 2016 at 09:49:08AM +1100, Gavin Shan wrote:
> > > 
> > > 
> > > On Tue, Feb 16, 2016 at 07:52:00PM +1100, Russell Currey wrote:
> > > > 
> > > > 
> > > > Incredibly, IBM online documentation for EEH uses "extended error
> > > > handling"
> > > > and "enhanced error handling" to refer to the same thing, in
> > > > different
> > > > places.  In other parts of the kernel, namely the EEH documentation
> > > > (found
> > > > in Documentation/powerpc/eeh-pci-error-recovery.txt), it's referred
> > > > to as
> > > > "extended", and in my opinion "extended" makes more sense for what
> > > > EEH
> > > > does.
> > > > 
> > > > The only place "enhanced error handling" shows up in the kernel is
> > > > in
> > > > MAINTAINERS, so fix it.
> > > > 
> > > Russell, Thanks for fixing it up. Since you're at it, Please replace
> > > the
> > > maintainer to yourself. Also, the components mentioned in this file
> > > are
> > > listed in alphabetic order according to their names. As the name of
> > > EEH
> > > is changed, it would be put in front of "Extended Verification Module
> > > (EVM)".
> > > 
> > I agree with Michael as discussed in another thread: we're going to use
> > "enhanced", not "extended" though some chip datasheet (P7IOC) talks
> > about
> > "extended error handling".
> > 
> > Russell, please change the maintainer to you and repost.
> Sure.
> 
> While I'm changing MAINTAINERS, what are your thoughts on renaming the
> EEH
> entry from "ENHANCED ERROR HANDLING (EEH)" to something like "PCI
> EXTENDED
> ERROR HANDLING (EEH)" or "EXTENDED ERROR HANDLING (EEH) FOR PCI" - so
> it's
> clear it refers to PCI and not something more generic?

and of course, s/EXTENDED/ENHANCED...-ENOCOFFEE
> > 
> > 
> > > 
> > > 
> > > > 
> > > > 
> > > > Signed-off-by: Russell Currey <ruscur@russell.cc>
> > > With above issues fixed:
> > > 
> > > Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> > > 
> > Thanks,
> > Gavin
> > 
> > > 
> > > 
> > > > 
> > > > 
> > > > ---
> > > > I don't know what kind of things parse MAINTAINERS, and if there's
> > > > a
> > > > chance
> > > > this will break them.  Also, the powerpc tree *is* the right place
> > > > to
> > > > send
> > > > this, right?
> > > > ---
> > > > MAINTAINERS | 2 +-
> > > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 28eb61b..e5d9134 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -4222,7 +4222,7 @@ M:	Maxim Levitsky <maximlevitsky@gmail
> > > > .c
> > > > om>
> > > > S:	Maintained
> > > > F:	drivers/media/rc/ene_ir.*
> > > > 
> > > > -ENHANCED ERROR HANDLING (EEH)
> > > > +EXTENDED ERROR HANDLING (EEH)
> > > > M:	Gavin Shan <shangw@linux.vnet.ibm.com>
> > > > L:	linuxppc-dev@lists.ozlabs.org
> > > > S:	Supported
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
