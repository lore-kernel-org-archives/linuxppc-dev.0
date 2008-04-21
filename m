Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 647AEDDFD1
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 08:39:55 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] ppc32: Fix errata for 603 CPUs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <B9800143-8E81-44D2-A922-28E992203717@kernel.crashing.org>
References: <Pine.LNX.4.64.0804211457010.8003@blarg.am.freescale.net>
	<1208812957.9640.47.camel@pasglop>
	<059AA568-4729-4060-A876-C8460E0A7794@kernel.crashing.org>
	<1208815944.9640.49.camel@pasglop>
	<B9800143-8E81-44D2-A922-28E992203717@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 22 Apr 2008 08:39:48 +1000
Message-Id: <1208817588.9640.51.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-04-21 at 17:31 -0500, Kumar Gala wrote:
> Ok, but we'd also need to fix setup_750_7400_hid0 and  
> setup_745x_specifics to test.
> 
> There's a bit more cleanup that needs to be done here.  I'm not
> going  
> to worry about it for this patch since it covers handling a chip  
> errata and isn't any more "broken" than other bits of code in this fi

True.

Cheers,
Ben.
