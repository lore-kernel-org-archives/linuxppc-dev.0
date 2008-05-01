Return-Path: <htejun@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 65D48DDE1B
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 10:40:25 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id n7so478252wag.13
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 17:40:24 -0700 (PDT)
Message-ID: <48191170.60205@gmail.com>
Date: Thu, 01 May 2008 09:40:16 +0900
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] devres: Add devm_ioremap_flags()
References: <Pine.LNX.4.64.0804301059430.22937@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0804301059430.22937@blarg.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	Emilian.Medve@Freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> From: Emil Medve <Emilian.Medve@Freescale.com>
> 
> We provide an ioremap_flags so provide a coresphonding devm_ioremap_flags.
> 
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
