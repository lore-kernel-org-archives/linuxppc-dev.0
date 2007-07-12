Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 348EEDDDF7
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 23:03:13 +1000 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/2] Move DTC Technical specs out of b-w-o.txt into DTC
	Repo
In-Reply-To: Your message of "Thu, 12 Jul 2007 02:01:07 CDT."
	<BFA74155-D32C-41F5-B61C-D9CE89A29B9B@kernel.crashing.org>
References: <1184190325.25384.125.camel@ld0161-tx32>
	<BFA74155-D32C-41F5-B61C-D9CE89A29B9B@kernel.crashing.org>
Date: Thu, 12 Jul 2007 08:03:07 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1I8yK3-0003UC-Fk@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Kumar Gala mumbled:
> 
> On Jul 11, 2007, at 4:45 PM, Jon Loeliger wrote:
> 
> > Folks,
> >
> > Here are two patches, one to the kernel, the other to
> > the DTC repo, that moves the technical description
> > portions of the booting-without-of.txt documentation
> > out of the kernel and into the DTC repository.
> 
> Why remove it from the kernel?  It seems like this part should change  
> infrequently and it would be good to keep its documentation with the  
> kernel as well?

Well, all the usual reasons.  It will be improving over time,
and it makes much more sense to keep the documntation about
a system within the repository for that system.  And rather
than have two copies, one of which will get out of sync,
I feel it makes more sense to relocate the DTC technical
descriptions to the DTC repository where it belongs.

And speaking of which, I will also be removing the already extant
and already way out of data copy of the booting-without-of.txt
from the DTC repo as well.

If a small summary of say, DTC command line usage is left in
b-w-o.txt as a Quick Ref, I'm fine with that, of course.

Thanks,
jdl
