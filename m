Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 821EBDDDF0
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Dec 2008 11:19:51 +1100 (EST)
Subject: Re: testing (Was: Re: linux-next: scsi-post-merge tree build failure)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20081223100456.bb556b19.sfr@canb.auug.org.au>
References: <20081223012545.5b1e7f5e.sfr@canb.auug.org.au>
	<1229979392.4360.15.camel@pasglop>
	<20081223100456.bb556b19.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Tue, 23 Dec 2008 11:19:35 +1100
Message-Id: <1229991575.4360.31.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-12-23 at 10:04 +1100, Stephen Rothwell wrote:
> So, why is this series in powerpc/next at all if some of the modified
> files haven't even been compiled?  

Because nobody spotted the problem while the series was out for review ?

> A simple ppc44x_defconfig build of the
> powerpc/next tree fails - which I would have thought would be part of the
> testing since KVM is only implemented for 44x on powerpc.
> 
> (Sorry, I am annoyed - it was late when I finally found this build
> failure on top of everything else.)

I have about 3 44x configs in my build tests. KVM happens not to be
enabled in any of them :-( I'll add this ppc4xx_defconfig to the lot, I
didn't know it existed in fact.

Cheers,
Ben.
