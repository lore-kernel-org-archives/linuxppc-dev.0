Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AE3F6B7CC3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 15:32:34 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DA8EFDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 15:32:33 +1000 (EST)
Message-Id: <3A70932E-B267-48E0-A6A2-A482606133E0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Poonam Aggrwal <poonam.aggrwal@freescale.com>
In-Reply-To: <1251208441-9777-1-git-send-email-poonam.aggrwal@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH][v2] powerpc/85xx: P1020RDB Support Added
Date: Fri, 28 Aug 2009 00:32:27 -0500
References: <1251208441-9777-1-git-send-email-poonam.aggrwal@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 25, 2009, at 8:54 AM, Poonam Aggrwal wrote:

> P1020 is another member of Freescale QorIQ series of processors.
> It is an e500 based dual core SOC.
> Being a scaled down version of P2020 it has following differences  
> from P2020:
> - 533MHz - 800MHz core frequency.
> - 256Kbyte L2 cache
> - Ethernet controllers with classification capabilities(new  
> controller).
>> From board perspective P1020RDB is same as P2020RDB.
>
> * This code adds the basic basic platform support for P1020RDB.
>
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> ---
> - based on http://www.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
> - branch->next
> - The patch does not contain ethernet support because P1020 contains  
> new eTSEC
>  controller. The support will be added in the following patches.
> - changes over v1- few changes in interrupt numbers.
> arch/powerpc/boot/dts/p1020rdb.dts        |  477 ++++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   24 ++
> 2 files changed, 501 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/p1020rdb.dts


applied to next

- k
