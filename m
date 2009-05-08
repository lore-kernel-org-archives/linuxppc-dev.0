Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 50B68DDF90
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 07:31:57 +1000 (EST)
Message-Id: <0530B4F4-9A01-470B-84A2-996E7A6FFB7C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090430222745.GA10985@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/fsl_soc: Remove mpc83xx_wdt_init, again
Date: Fri, 8 May 2009 16:31:52 -0500
References: <20090430222745.GA10985@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 30, 2009, at 5:27 PM, Anton Vorontsov wrote:

> commit b31a1d8b41513b96e9c7ec2f68c5734cef0b26a4 ("gianfar: Convert
> gianfar to an of_platform_driver"), possibly due merge issues,
> reintroduced completely unneded mpc83xx_wdt_init call, which
> I removed some time ago in commit 20d38e01d48019c578ab0ec1464454c0
> ("powerpc/fsl_soc: remove mpc83xx_wdt code").
>
> Remove it once again.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/sysdev/fsl_soc.c |   46  
> -----------------------------------------
> 1 files changed, 0 insertions(+), 46 deletions(-)

applied to merge

- k
