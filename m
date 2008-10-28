Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8109CDDDFB
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 16:54:17 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m9S5sBRc017828
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 00:54:12 -0500
Subject: Re: [PATCH 0/10] powerpc/pci: Fix PCI Hotplug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1225172895.217185.958686212130.qpush@grosgo>
References: <1225172895.217185.958686212130.qpush@grosgo>
Content-Type: text/plain
Date: Tue, 28 Oct 2008 16:54:11 +1100
Message-Id: <1225173251.8004.67.camel@pasglop>
Mime-Version: 1.0
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-10-28 at 16:48 +1100, Benjamin Herrenschmidt wrote:
> This series of patches is aimed at fixing all sort of issues
> with the PCI hotplug support on pSeries. The meant is in the
> second to last patch, but it relies on a whole bunch of small
> changes to separate the bus fixup operation in two that are
> needed to fix the root of most problems.
> 
> Please review/test asap as I would like that in 2.6.28 despite
> being a bit late, as without these, PCI hotplug on pseries pretty
> much doesn't work. It should also make it easier in the future to
> implement hotplug support on other platforms.

Specifically, Kumar and Josh, can you give a couple of spins
of kernels with those patches on your respective platforms to
make sure I haven't broken something ?

Cheers,
Ben.
