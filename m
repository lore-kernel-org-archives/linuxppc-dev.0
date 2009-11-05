Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2BD0AB7B93
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 00:30:26 +1100 (EST)
Subject: Re: [PATCH][v4] powerpc/85xx: Added P1020RDB Platform support.
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1253852428-1156-1-git-send-email-poonam.aggrwal@freescale.com>
Date: Thu, 5 Nov 2009 07:30:20 -0600
Message-Id: <9DE864E6-DC6D-465C-AB45-D30B46A19D52@kernel.crashing.org>
References: <1253852428-1156-1-git-send-email-poonam.aggrwal@freescale.com>
To: Poonam Aggrwal <poonam.aggrwal@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 24, 2009, at 11:20 PM, Poonam Aggrwal wrote:

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
>  controller. The support will be added in the later patches.
> - changes above v3-> minor change in a comment for localbus  
> chipselects.
> PLEASE ignore the earlier patch mail with no subject.
> arch/powerpc/boot/dts/p1020rdb.dts        |  477 ++++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   24 ++
> 2 files changed, 501 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/p1020rdb.dts

applied to next

- k
