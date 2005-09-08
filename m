Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C03BF681F5
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Sep 2005 00:11:54 +1000 (EST)
In-Reply-To: <20050908010428.GC8882@dmt.cnet>
References: <20050908010428.GC8882@dmt.cnet>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5B4F5836-F3E6-4511-BD4C-9388BBA715E0@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 8 Sep 2005 09:11:49 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, Tom Rini <trini@kernel.crashing.org>,
	"Gala Kumar K.-galak" <galak@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc32: add CONFIG_HZ
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Yep.
>
> Kumar, can you please change your patch to make CONFIG_8xx use 100Hz?
>
> There was a significant performance increase from doing that (vs  
> 1000Hz)
> on a 48Mhz 8xx with small cache.
>

I'd be happy to, but I'm not 100% sure how to get the Kconfig system  
to do that on a sub-arch case.  Right now the default is 250Hz based  
on the global kernel/Kconfig.hz.  If we want we can effectively  
replicate the Kconfig.hz functionality into arch/ppc/Kconfig which  
would give us more flexibility but I'd prefer not to do that.

Idea's on how to solve this are welcome.

- kumar
