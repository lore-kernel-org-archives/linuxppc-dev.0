Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 629FFDDF19
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 20:05:19 +1100 (EST)
Date: Wed, 13 Feb 2008 01:05:50 -0800 (PST)
Message-Id: <20080213.010550.211671868.davem@davemloft.net>
To: sam@ravnborg.org
Subject: Re: [GIT]: Make LMB code sharable with sparc64.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080213085735.GB8091@uranus.ravnborg.org>
References: <20080213.004120.22092044.davem@davemloft.net>
	<20080213085735.GB8091@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 13 Feb 2008 09:57:35 +0100

> Review had been easier if the patch was inlined.

Sorry :)

> Can we plase have this changed to use:
> 
>  config SPARC64
> +	select HAVE_LMB
> 
> And then in lib/Kconfig have
> +config HAVE_LMB
> +	bool
> 
> So we avoid creating a new variable each time we introdce LMB support.
> You would need to update powerpc Kconfig too of course.

Sure, I'll rework this in the next day or so to do things
that way.

Thanks for the review.
