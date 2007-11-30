Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A8F1ADDE37
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 07:17:42 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAUKHdSd025471
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 15:17:39 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lAUKHcj6108902
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 13:17:38 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAUKHcm6004187
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 13:17:38 -0700
Date: Fri, 30 Nov 2007 14:16:06 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 24/24] powerpc: Base support for 440SPe "Katmai" eval board
Message-ID: <20071130141606.725e919b@zod.rchland.ibm.com>
In-Reply-To: <20071130061209.497F3DE03A@ozlabs.org>
References: <1196403038.569525.367459803520.qpush@grosgo>
	<20071130061209.497F3DE03A@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 30 Nov 2007 17:11:06 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This adds base support for the Katmai board, including PCI-X and
> PCI-Express (but no RTC, nvram, etc... yet).
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> As for Taishan, the bootwrapper code can be simplified. In fact,
> we probably don't need to probe clocks & memsize off the chip and
> just trust what uboot tells us.
> 
>  arch/powerpc/boot/44x.h             |    1 
>  arch/powerpc/boot/Makefile          |    7 

Same small conflict as taishan.

josh
