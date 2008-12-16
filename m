Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DEDDBDDEF3
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 05:29:25 +1100 (EST)
Message-Id: <3FEDAAC8-3408-45B4-A687-4BCC5AB006D0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081203192752.GE13035@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 5/5] powerpc/83xx: Fix sparse warnings in mpc836x_mds.c
Date: Tue, 16 Dec 2008 12:27:15 -0600
References: <20081203192644.GA6145@oksana.dev.rtsoft.ru>
	<20081203192752.GE13035@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 3, 2008, at 1:27 PM, Anton Vorontsov wrote:

> This patch fixes following sparse warnings:
>
>  CHECK   mpc836x_mds.c
> mpc836x_mds.c:75:12: warning: Using plain integer as NULL pointer
> mpc836x_mds.c:79:13: warning: incorrect type in assignment  
> (different address spaces)
> mpc836x_mds.c:79:13:    expected unsigned char [usertype] *static  
> [toplevel] bcsr_regs
> mpc836x_mds.c:79:13:    got void [noderef] <asn:2>*
> mpc836x_mds.c:105:3: warning: incorrect type in argument 1  
> (different address spaces)
> mpc836x_mds.c:105:3:    expected unsigned char volatile [noderef]  
> [usertype] <asn:2>*addr
> mpc836x_mds.c:105:3:    got unsigned char [usertype] *
> mpc836x_mds.c:105:3: warning: incorrect type in argument 1  
> (different address spaces)
> mpc836x_mds.c:105:3:    expected unsigned char const volatile  
> [noderef] [usertype] <asn:2>*addr
> mpc836x_mds.c:105:3:    got unsigned char [usertype] *
> mpc836x_mds.c:107:3: warning: incorrect type in argument 1  
> (different address spaces)
> mpc836x_mds.c:107:3:    expected unsigned char volatile [noderef]  
> [usertype] <asn:2>*addr
> mpc836x_mds.c:107:3:    got unsigned char [usertype] *
> mpc836x_mds.c:107:3: warning: incorrect type in argument 1  
> (different address spaces)
> mpc836x_mds.c:107:3:    expected unsigned char const volatile  
> [noderef] [usertype] <asn:2>*addr
> mpc836x_mds.c:107:3:    got unsigned char [usertype] *
> mpc836x_mds.c:131:11: warning: incorrect type in argument 1  
> (different address spaces)
> mpc836x_mds.c:131:11:    expected void volatile [noderef] <asn:2>*addr
> mpc836x_mds.c:131:11:    got unsigned char [usertype] *static  
> [toplevel] bcsr_regs
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/platforms/83xx/mpc836x_mds.c |    6 +++---
> 1 files changed, 3 insertions(+), 3 deletions(-)

applied to next

- k
