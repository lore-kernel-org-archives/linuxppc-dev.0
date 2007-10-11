Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 94517DDFCD
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 23:05:21 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9BD5Is3006246
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 09:05:18 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9BD5Ibx566554
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 09:05:18 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9BD5Hfa014242
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 09:05:18 -0400
Subject: Re: [PATCH 4/4 v2] [POWERPC] Kilauea defconfig file
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200710111408.34207.sr@denx.de>
References: <200710111408.34207.sr@denx.de>
Content-Type: text/plain
Date: Thu, 11 Oct 2007 08:02:51 -0500
Message-Id: <1192107771.5534.120.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-10-11 at 14:08 +0200, Stefan Roese wrote:
> Signed-off-by: Stefan Roese <sr@denx.de>
> +# CONFIG_MATH_EMULATION is not set

Does the 405EX have an FPU?  If not, do you want this set by default so
floating point instructions work?

> +CONFIG_RESOURCES_64BIT=y

I'm not sure about that one.  I see walnut has the same thing for some
reason, but is it really needed?

> +CONFIG_WANT_DEVICE_TREE=y
> +CONFIG_DEVICE_TREE="walnut.dts"

That looks wrong.  Should be selecting the Kilauea dts

josh
