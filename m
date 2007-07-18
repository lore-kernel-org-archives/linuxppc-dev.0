Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B3FEDDFD7
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 15:19:40 +1000 (EST)
In-Reply-To: <20070718013528.GU15238@ld0162-tx32.am.freescale.net>
References: <20070718013528.GU15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <09805D76-8833-452D-9168-FDDAA7465964@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 23/61] Rename mpc82xx_ads_show_cpuinfo to
	m82xx_show_cpuinfo.
Date: Wed, 18 Jul 2007 00:20:08 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 17, 2007, at 8:35 PM, Scott Wood wrote:

> Vendor and machine are removed; any such information should go in
> ppc_md.name.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Do we really need a 82xx specific show_cpuinfo or can we just use the  
generic one?

I just get SVR, PLL, and memory size.  It seems like memory size is  
available elsewhere, PLL can be computed from clock freq & time base  
freq.

While SVR would be nice, but we kinda now it from the name.  Plus I'd  
rather we just maybe export that as a sysfs property or something.

- k
