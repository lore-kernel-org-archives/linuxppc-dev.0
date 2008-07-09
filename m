Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	by ozlabs.org (Postfix) with ESMTP id CEA78DE3C4
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 23:09:17 +1000 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: libfdt: Increase namespace-pollution paranoia 
In-reply-to: <1F3AE758-B99A-457F-A74D-6D12DAF74115@kernel.crashing.org> 
References: <20080709041024.GB29648@yookeroo.seuss>
	<1215603723.13186.0.camel@weaponx>
	<1F3AE758-B99A-457F-A74D-6D12DAF74115@kernel.crashing.org>
Date: Wed, 09 Jul 2008 08:09:02 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KGZPq-0003YZ-T5@jdl.com>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
> > On a slightly unrelated note, are you planning to sync the in-kernel
> > dtc/libfdt version with the upstream version anytime soon?
> 
> I know jon put an -rc, not sure if he plans to pick up the slew of  
> patches for the next -rc or the next release, but it would be good to  
> resync the in-kernel version for 2.6.27.
> 
> - k

My (DTC) plan is to apply the single patch with some
include file fixes, and release that.

I'll line the slew of patches up for the following release.

jdl
