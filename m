Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-71-119.roch.qwest.net [67.41.71.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4A9C267A33
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Apr 2005 09:37:13 +1000 (EST)
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Matt <mporter@kernel.crashing.org>
In-Reply-To: <20050331131044.A29501@cox.net>
References: <20050316231800.GD8345@smtp.west.cox.net>
	<d0e9907f9780a7fce59b3f69af6ece99@freescale.com>
	<1111171391.2987.24.camel@ad.doubleclick.net>
	<20050318193045.GM8345@smtp.west.cox.net>
	<1112286378.24673.252.camel@rhino.az.mvista.com>
	<20050331163420.GI25923@smtp.west.cox.net>
	<20050331131044.A29501@cox.net>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 17:37:11 -0600
Message-Id: <1112312232.12105.36.camel@jdub.homelinux.org>
Mime-Version: 1.0
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: 440EP FPU patch
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2005-03-31 at 13:10 -0700, Matt wrote:
> 
> If nobody has time to work on this, then I intend  to put Wade's 440EP
> support in as is (actually, he's planning on resubmitting with some
> additional changes).  When somebody has time, they can redo the patch
> against that.

Do those changes happen to include the MTD driver for the NAND
controller?  Wade, any word on that?

josh
