Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2BE6EDDDFA
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 10:34:05 +1100 (EST)
Subject: Re: mmap question on ppc440
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071106165909.0e80fb4e@zod.rchland.ibm.com>
References: <472F8503.2080705@harris.com> <20071105151659.3ea601e4@weaponx>
	<200711060750.21750.sr@denx.de> <1194386530.6523.37.camel@pasglop>
	<20071106165909.0e80fb4e@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 07 Nov 2007 10:31:40 +1100
Message-Id: <1194391900.6523.39.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > The solution is libpciaccess and the new pci-rework branch of X which
> > uses it, but I haven't had a chance to test that properly yet on 4xx.
> 
> Um... because arch/powerpc 4xx doesn't have PCI support? :)  You and
> Valentine and Vitaly keep trading emails about it though, which is a
> good sign.

Yeah :-) It shouldn't be hard in fact.

Ben.
