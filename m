Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62B01DDE02
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 13:56:14 +1000 (EST)
Subject: Re: [PATCH] Remove unused old code from powermac setup code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18180.25146.321019.568200@cargo.ozlabs.ibm.com>
References: <18180.25146.321019.568200@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 04 Oct 2007 13:56:08 +1000
Message-Id: <1191470168.22572.149.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-10-04 at 13:47 +1000, Paul Mackerras wrote:
> Since bootdevice never gets initialized, it's always NULL, and hence a
> whole pile of code in arch/powerpc/platforms/setup.c never gets used.
> (This was the code that originally was there so that the automatic
> root partition selection mechanism would prefer a rootish-looking
> partition on the device that OF loaded the kernel from over a similar
> partition on other devices.)
> 
> This removes the unused code.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
