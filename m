Return-Path: <vitb@kernel.crashing.org>
Received: from localhost.localdomain (unknown [85.94.3.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DCACBDDE08
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 08:47:50 +1000 (EST)
Date: Wed, 9 May 2007 02:47:39 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: Current powerpc.git build failures
Message-ID: <20070509024739.6fa18168@localhost.localdomain>
In-Reply-To: <20070508191758.GA26879@lixom.net>
References: <20070508191758.GA26879@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@ardnb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 8 May 2007 14:17:58 -0500
Olof Johansson wrote:

> powerpc.mpc866_ads_defconfig:
> arch/powerpc/sysdev/mpc8xx_pic.c:98: error: static declaration of
> 'mpc8xx_pic' follows non-static declaration
> arch/powerpc/sysdev/mpc8xx_pic.h:7: error: previous declaration of
> 'mpc8xx_pic' was here
> 
> powerpc.mpc885_ads_defconfig:
> arch/powerpc/sysdev/mpc8xx_pic.c:98: error: static declaration of
> 'mpc8xx_pic' follows non-static declaration
> arch/powerpc/sysdev/mpc8xx_pic.h:7: error: previous declaration of
> 'mpc8xx_pic' was here

These 2 are addressed as a part of pcmcia patch series...

-- 
Sincerely, Vitaly
