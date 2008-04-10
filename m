Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06B0BDDF6D
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 18:51:56 +1000 (EST)
Message-Id: <6D34DE41-ED8D-455A-89F3-288C9445691E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080410142430.256fd23e.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] 83xx/85xx: Reorganize defconfigs
Date: Thu, 10 Apr 2008 03:51:42 -0500
References: <Pine.LNX.4.64.0804091017440.18753@blarg.am.freescale.net>
	<20080410103131.f0dcf730.sfr@canb.auug.org.au>
	<6BE67DBD-325A-4628-8480-7EA0FE79DBE5@kernel.crashing.org>
	<20080410142430.256fd23e.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 9, 2008, at 11:24 PM, Stephen Rothwell wrote:
> On Wed, 9 Apr 2008 22:11:38 -0500 Kumar Gala <galak@kernel.crashing.org 
> > wrote:
>>
>> Yeah the are mpc85xx_defconfig and mpc83xx_defconfig.
>
> So should we add mpc83xx_defconfig to the kisskb builds and remove
> mpc885_ads_defconfig (we already do a mpc85xx_defconfig build)?

We should probably add mpc83xx_defconfig to kisskb.  However,  
mpc885_ads_defconfig is an 8xx (extreme low end) and mpc85xx_defconfig  
(higher end) cover two different processor families so we shouldn't  
drop mpc885_ads_defconfig.

- k
