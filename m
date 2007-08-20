Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 78A6CDDED8
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 01:44:45 +1000 (EST)
Message-ID: <46C9B6DF.1000006@freescale.com>
Date: Mon, 20 Aug 2007 10:44:31 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3 v2] Remove need for include/asm-ppc
References: <Pine.LNX.4.64.0708181203320.31362@blarg.am.freescale.net>	<20070820060000.GA26100@localhost.localdomain>	<A4E8D00C-87DB-4C59-A6C4-70D437ED9988@kernel.crashing.org>
	<20070820103719.23f50f64@weaponx.rchland.ibm.com>
In-Reply-To: <20070820103719.23f50f64@weaponx.rchland.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Mon, 20 Aug 2007 10:32:43 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
>>Do we want to go and move stuff back out of arch/powerpc/kernel back  
>>into arch/ppc/kernel?  or just include files?
> 
> 
> What would be the point of doing that?  I would think we want the
> opposite, in that we want to reuse as much of arch/powerpc during
> arch/ppc compiles as possible.  Sort of shows how much is "left" to
> port.

The point would be to keep the two trees separate, so that one doesn't 
need to worry about breaking arch/ppc when making a change to arch/powerpc.

-Scott
