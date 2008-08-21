Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DE458DE4BE
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 02:16:30 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m7LGGOA5027826
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 09:16:24 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m7LGGNmT004314
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 11:16:23 -0500 (CDT)
Date: Thu, 21 Aug 2008 11:16:22 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/4] kvmppc: convert wrteei to wrtee as kvm guest
	optimization
Message-ID: <20080821161622.GB15669@ld0162-tx32.am.freescale.net>
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<81439C52-0CB6-4C46-9A97-3D30B84F58AF@kernel.crashing.org>
	<48AD7815.70107@linux.vnet.ibm.com>
	<9E570AE9-6811-489F-9E2C-EF5A6B95ED5C@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9E570AE9-6811-489F-9E2C-EF5A6B95ED5C@kernel.crashing.org>
Cc: kvm-ppc@vger.kernel.org, hollisb@us.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 21, 2008 at 09:21:39AM -0500, Kumar Gala wrote:
> Where is the other discussion?  I'd like to understand what's going on  
> here.. (especially since I added the wrtee[i] changes to kernel way  
> back when).

Presumably, they want to be able to replace wrtee with a store to a
hypervisor/guest shared memory area, and there's no store-immediate
instruction.

-Scott
