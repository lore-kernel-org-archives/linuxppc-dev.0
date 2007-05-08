Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 18472DDE2B
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 03:05:00 +1000 (EST)
Message-ID: <4640AE88.9040806@mvista.com>
Date: Tue, 08 May 2007 10:08:24 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add dts entries to 85xx for EDAC
References: <20070425213700.GA8814@blade.az.mvista.com>
	<20070426000852.GA2193@localhost.localdomain>
	<20070426003748.GA30730@blade.az.mvista.com>
	<9903F55A-5E4E-42CE-8C27-6B7143B9FE25@kernel.crashing.org>
	<20070501183220.GA6426@blade.az.mvista.com>
	<20070507232634.GA11166@blade.az.mvista.com>
	<3EF891D2-F973-43D6-B43B-B8BBC4269C60@kernel.crashing.org>
In-Reply-To: <3EF891D2-F973-43D6-B43B-B8BBC4269C60@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On May 7, 2007, at 6:26 PM, Dave Jiang wrote:
> 
>> Adding memory-controller and l2-cache-controller entries to be used  
>> by EDAC as
>> of_devices.
> 
> we should distinguish the memory controllers on 8540/8560 (DDR1) from  
> the one on 8548 (DDR1 & DDR2).

Do you mean something like:

8540/8560
compatible = "fsl,85xx-ddr-controller"

8548
compatible = "fsl,85xx-ddr2-controller"

--
-= Dave =-
