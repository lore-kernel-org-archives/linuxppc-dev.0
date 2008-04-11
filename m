Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DB315DE49B
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 00:46:15 +1000 (EST)
Date: Fri, 11 Apr 2008 09:46:20 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] CPM: Always use new binding.
Message-ID: <20080411144620.GA2534@loki.buserror.net>
References: <20080410204502.GB20197@loki.buserror.net>
	<E26DEDA5-96A7-40C1-A06A-5D8503453715@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E26DEDA5-96A7-40C1-A06A-5D8503453715@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 10, 2008 at 06:44:24PM -0500, Kumar Gala wrote:
>
> On Apr 10, 2008, at 3:45 PM, Scott Wood wrote:
>> The kconfig entry can go away once arch/ppc and references to the  
>> config in
>> drivers are removed.
>
> just to be clear.  arch/powerpc will always just use the new binding and 
> arch/ppc uses the old (or has the option)?

Yes, CONFIG_PPC_NEW_BINDING is effectively an alias for CONFIG_PPC_MERGE
after this patch (but I figure there's no point changing the drivers to use
the latter, just to make another change in a couple months when arch/ppc
dies).

-Scott
