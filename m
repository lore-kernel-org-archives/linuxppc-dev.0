Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 381A7DE28B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 00:23:30 +1000 (EST)
Message-Id: <6BDA49F4-EF06-4107-A011-EAC600CEEE70@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080929135603.GA27252@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/fsl_soc: remove mpc83xx_wdt code
Date: Mon, 29 Sep 2008 09:23:26 -0500
References: <20080929135603.GA27252@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 29, 2008, at 8:56 AM, Anton Vorontsov wrote:

> mpc83xx_wdt is the OF driver now, so we don't need fsl_soc  
> constructor.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> Just resending the following patch:
>
> http://ozlabs.org/pipermail/linuxppc-dev/2008-May/056253.html
>
> arch/powerpc/sysdev/fsl_soc.c |   47  
> -----------------------------------------
> 1 files changed, 0 insertions(+), 47 deletions(-)

applied.

- k
