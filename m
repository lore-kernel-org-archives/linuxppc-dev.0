Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4BD7867A33
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2005 09:11:10 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jek6nf1pcj.fsf@sykes.suse.de>
References: <1112681154.9517.7.camel@gaston>  <jek6nf1pcj.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 09:10:19 +1000
Message-Id: <1112829020.9518.202.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Update ppc32-fix-errata-for-some-g3-cpus.patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-04-07 at 01:02 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > The previous version of ppc32-fix-errata-for-some-g3-cpus.patch had an
> > issue that would crash some G4 CPUs on boot. This is fixed in this new
> > version, please replace the old one and send to linus asap (it's now
> > been tested on enough CPUs).
> 
> Apparently not.  I'm getting "floating point used in kernel" crashes
> during wakeup on my iBook G3 (750FX).

And does removing that patch fixes it ? That is very strange. The patch
works fine here on a G3 Pismo and a couple of G4s, the code in the patch
does enable the FPU before initilizing the registers, so the kernel
shouldn't take any FP exception... Couldn't the above be a different
problem ? What is the exact PC where the exception occurs ? what
instruction does it correspond to ?

Ben.
 
