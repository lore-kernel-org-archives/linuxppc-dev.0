Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id ABA6867A64
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Mar 2005 01:06:09 +1100 (EST)
In-Reply-To: <20050310082639.GA19275@gate.ebshome.net>
References: <20050310082639.GA19275@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d10a9ba3f7ed768cff5f439840c96aec@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 10 Mar 2005 08:06:04 -0600
To: "Eugene Surovegin" <ebs@ebshome.net>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: build failure for 2.6.11-mm2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

right, but if you look back in the pervious -mm builds that past, they 
also did not have mkImage but still succeeded.

It appear some change is now report the lack of mkImage as a build 
error.  If this is desired behavior, should we maybe look at having a 
copy of its source in the kernel tree?

- kumar

On Mar 10, 2005, at 2:26 AM, Eugene Surovegin wrote:

> On Thu, Mar 10, 2005 at 02:10:04AM -0600, Kumar Gala wrote:
>  > Do you have any ideas on what changes occurred in the makefiles to
> > cause the uImage related failures:
>  >
> > http://l4x.org/k/?d=2173
>
> This looks like mkimage is just not present on build host. I don't
> think it's included anywhere in kernel tree, so it must be installed
> separately.
>
> -- 
>  Eugene
