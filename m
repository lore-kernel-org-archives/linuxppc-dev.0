Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 59DF867B69
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Jun 2006 03:48:27 +1000 (EST)
Received: from vitb.ru.mvista.com ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k5SHmQs27436
	for <linuxppc-embedded@ozlabs.org>; Wed, 28 Jun 2006 22:48:26 +0500
Date: Wed, 28 Jun 2006 21:48:41 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: block after "io scheduler noop registered"
Message-ID: <20060628214841.311060c6@vitb.ru.mvista.com>
In-Reply-To: <J1KRSY$2A22F25EF5BB111FA515FFA9A4DCCD71@libero.it>
References: <J1KRSY$2A22F25EF5BB111FA515FFA9A4DCCD71@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 28 Jun 2006 16:48:34 +0200
"morelli.gab" <morelli.gab@libero.it> wrote:

> Hi All,
> 
> i,m upgrading the linux kernel 2.4 from 2.6, during the phase of restart on my card the system blocks on message "io scheduler noop registered".
> the board mount MPC875 processor
> 
> 
> ...
> Serial: CPM driver $Revision: 0.01 $
> ttyCPM0 at MMIO 0xf0000a80 (irq = 20) is a CPM UART
> ttyCPM1 at MMIO 0xf0000a90 (irq = 19) is a CPM UART
> io scheduler noop registered
You should add the proper cpm uart initialization bits to the board-specific code, as say 885ads does (ppc/platforms/mpc885ads_setup.c). 

What experienced is uart misconfiguration which alters pins in a way the console doesn't like very much.

-- 
Sincerely, 
Vitaly
