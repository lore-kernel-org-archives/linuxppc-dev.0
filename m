Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B00D22BDF2
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Nov 2004 12:57:16 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arrigo Benedetti <arrigo@bologna.vision.caltech.edu>
In-Reply-To: <4187D1DE.90203@vision.caltech.edu>
References: <4187D1DE.90203@vision.caltech.edu>
Content-Type: text/plain
Date: Wed, 03 Nov 2004 12:49:27 +1100
Message-Id: <1099446567.31630.21.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: G5 clock frequency scaling
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2004-11-02 at 10:28 -0800, Arrigo Benedetti wrote:
> Does anyone know if the current IBM 970 chips in dual G5 Powermacs and 
> Xserves is under any clock frequency
> scaling control? In other words, is the clock freuquency always 
> guardanteed to be the nominal, or it may change
> based on temperature? If this is the case, does the linux kernel have 
> any control on it?

The current desktop models have a "clock slewing" capability which isn't
used by the kernel at this point. So the machine stays at the speed it
had when booting.

However, it's been observed that the firmware tend to boot at max speed
when auto-booting, and at lowest speed (1.3Ghz generally observed) when
entering the OF manual command line interface.

Ben.
