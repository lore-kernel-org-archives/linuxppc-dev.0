Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 0768867C7D
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jul 2005 05:47:35 +1000 (EST)
Date: Tue, 5 Jul 2005 12:47:24 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Message-ID: <20050705194724.GB6878@smtp.west.cox.net>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
	<20050703172955.GA25976@suse.de>
	<20050703183237.GC16764@smtp.west.cox.net>
	<20050705181448.GA28142@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050705181448.GA28142@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 05, 2005 at 08:14:48PM +0200, Olaf Hering wrote:
>  On Sun, Jul 03, Tom Rini wrote:
> 
> > cpu-as-y = -Wa,-mcpu=powerpc	# Pure ppc32
> 
> That alone should fix it, adding -mcpu=$somecpu may generate bad code
> for other cpu types, according to alanm.

Exactly.

> > cpu-as-$(CONFIG_6xx) += -Wa,-maltivec
> > cpu-as-$(CONFIG_PPC_601) := -Wa,-mcpu=601 # Or whatever the 601 option is
> 
> 601 doesnt need special cflags handling.

gcc info page says that -mcpu=powerpc won't work for 601.

-- 
Tom Rini
http://gate.crashing.org/~trini/
