Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 4BF8667A6F
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Mar 2005 09:12:01 +1100 (EST)
Date: Wed, 16 Mar 2005 15:11:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050316221152.GZ8345@smtp.west.cox.net>
References: <4e44f753c3a197eff3b584f24a239f06@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4e44f753c3a197eff3b584f24a239f06@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: building ppc_htab?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 16, 2005 at 12:57:24AM -0600, Kumar Gala wrote:

> Is there any reason not to make the following change so we build 
> ppc_htab only on PPC STD MMU?  This would also require fixing up 
> fs/proc/proc_misc.c.

I could have sworn, but maybe my memory sucks, that we no longer messed
w/ fs/proc/proc_misc.c for any of the PPC-specific things (since in 2.6
you can do all of that proc magic in your 'driver').  So this patch
would make a great deal of sense to do, and if it lacks what I'm talking
about, we should do that part as well :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
