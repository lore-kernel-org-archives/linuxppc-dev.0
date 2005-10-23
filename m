Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 78EC568618
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2005 18:27:15 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20051023081240.GA20134@suse.de>
References: <20051022213037.GA6097@suse.de>
	<1130022347.7919.39.camel@gaston>  <20051023081240.GA20134@suse.de>
Content-Type: text/plain
Date: Sun, 23 Oct 2005 18:22:40 +1000
Message-Id: <1130055760.7919.59.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] hide pmac specific drivers if CONFIG_ADB is not set
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > No. SMU machines too
> 
> arch/ppc64/configs/g5_defconfig has CONFIG_ADB_PMU enabled.
> It compiles ok with that option disabled.
> Is there a pmu in early G5 models?

Yes, but not newer ones and I intend to change the way all those low
level support options are dealt with anyway

Ben.
