Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 84E5CDE108
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 08:07:43 +1000 (EST)
Date: Thu, 23 Apr 2009 17:09:09 -0500
From: Olof Johansson <olof@lixom.net>
To: Mike Wolf <mjw@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: adjust oprofile_cpu_type
Message-ID: <20090423220909.GA10487@lixom.net>
References: <1240443612.27209.2.camel@mx3> <20090423175210.GB4732@lixom.net>
	<1240523816.12000.2.camel@mx3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1240523816.12000.2.camel@mx3>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 23, 2009 at 04:56:56PM -0500, Mike Wolf wrote:
> On Thu, 2009-04-23 at 12:52 -0500, Olof Johansson wrote:
> > On Wed, Apr 22, 2009 at 06:40:12PM -0500, Mike Wolf wrote:
> > > Resending.  the patch was munged last time.
> > > 
> > > 
> > > Oprofile is changing the naming it is using for the compatibility modes.
> > > Instead of having compat-power<x>, oprofile will go to family naming
> > > convention and use compat-v<x>.  Currently only compat-v1 will be
> > > defined.
> > 
> > Compat V1 of what? powerpc64? IBM powerpc64 PMC? 
> 
> IBM powerpc PMC

Sounds like it'd be appropriate to have an ibm somewhere in the version
string then.

> >  The performance
> > monitors are not architected, to give them a version number without
> > vendor information seems weird.
> The current ones all fall into one family and they may be architected in
> the future.

Not all powerpc PMC implementations do, not even all ppc64 ones --
PA6T implements a completely different performance monitor.

The current IBM PMC is included in the appendix of the architecture as
a suggestion on how to implement it, but it is explicitly specified
as being implementation dependent in the architecture.

> > Also, doesn't this break compatibility with existing userspace tools?
> AFAIK there is nothing else that uses these.  Oprofile patch was
> rejected and this new naming was suggested from that community.

Ok, as long as you are 100% sure there are no proprietary users either.


-Olof
