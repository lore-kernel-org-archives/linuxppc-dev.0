Return-Path: <wfarnsworth@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 4E33867A65
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 05:04:19 +1100 (EST)
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Jason McMullan <jason.mcmullan@timesys.com>
In-Reply-To: <1110993985.2987.2.camel@ad.doubleclick.net>
References: <1110907039.24673.12.camel@rhino.az.mvista.com>
	<1110937421.28218.27.camel@jdub.homelinux.org>
	<1110989349.24673.99.camel@rhino.az.mvista.com>
	<1110993985.2987.2.camel@ad.doubleclick.net>
Content-Type: text/plain
Message-Id: <1110996255.24527.129.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 16 Mar 2005 11:04:15 -0700
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 1/3] PPC440EP SoC and Bamboo board support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2005-03-16 at 10:26, Jason McMullan wrote:
> Do you need a 'special' toolchain to work around Errata 42 (isync before
> blrl) for user-space, or are the kernel-land fixes sufficient?

Yes, this work around also needs to be in gcc.  I know this has been
fixed in MontaVista's toolchain, but I don't know if the work around has
been pushed up to the main gcc tree.

-Wade Farnsworth
