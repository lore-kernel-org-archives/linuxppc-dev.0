Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0B6DE1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 11:42:16 +1000 (AEST)
Message-ID: <1436406135.18682.3.camel@ellerman.id.au>
Subject: Re: PASEMI: PA6T board doesn't boot with the RC1 of kernel 4.2 anymore
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 09 Jul 2015 11:42:15 +1000
In-Reply-To: <1436394990.3948.113.camel@kernel.crashing.org>
References: <559BB716.6040001@xenosoft.de> <559BC99D.20608@xenosoft.de>
 <559D653F.2060307@xenosoft.de>
 <1436394990.3948.113.camel@kernel.crashing.org>
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

On Thu, 2015-07-09 at 08:36 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2015-07-08 at 20:00 +0200, Christian Zigotzky wrote:
> > Dear Linuxppc-dev mailing list,
> > 
> > I used git bisect and found out that the following commit is the problem.
> > 
> > commit 3ceaccdf92073d193f0bfbe24280dd736e3fed86
> > Author: Dave Hansen <dave.hansen@linux.intel.com>
> 
> There is no way that commit affects anything on that platform, it only
> changes a file in arch/x86 that isn't compiled on a powerpc build. You
> must have made a mistake in your bisection, possibly the one "sometimes
> boots" should be considered good, but I can't say for sure.
> 
> Michael has a PA6T board at work, so I assume he will see if he can
> reproduce.

Yeah I can't reproduce here.

I think you need to bisect again and look for the particular crash you
reported. If you see that crash then mark it bad, else mark it good.

cheers
